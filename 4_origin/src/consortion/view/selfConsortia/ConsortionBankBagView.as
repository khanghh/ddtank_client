package consortion.view.selfConsortia
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.bag.CellMenu;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.BagInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   import playerDress.PlayerDressManager;
   import playerDress.components.DressUtils;
   import playerDress.data.DressVo;
   
   public class ConsortionBankBagView extends BagView
   {
      
      private static var LIST_WIDTH:int = 330;
      
      private static var LIST_HEIGHT:int = 320;
       
      
      private var _bank:ConsortionBankListView;
      
      private var _titleText2:FilterFrameText;
      
      private var _changeToConsortion:SimpleBitmapButton;
      
      private const MAX_HEIGHT:int = 455;
      
      public function ConsortionBankBagView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _changeToConsortion = ComponentFactory.Instance.creatComponentByStylename("consortion.bankView.stateChangeBtn");
         addChild(_changeToConsortion);
         setInit();
         setData(PlayerManager.Instance.Self);
      }
      
      private function setInit() : void
      {
         _tabBtn3.buttonMode = false;
         _tabBtn3.mouseEnabled = false;
         _tabBtn3.mouseChildren = false;
         bagLockBtn.visible = false;
      }
      
      override public function setBagType(type:int) : void
      {
         super.setBagType(type);
      }
      
      override protected function set_breakBtn_enable() : void
      {
         if(_keySortBtn && _isSkillCanUse())
         {
            _keySortBtn.enable = true;
         }
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _bank.addEventListener("itemclick",__bankCellClick);
         _bank.addEventListener("doubleclick",__bankCellDoubleClick);
         addEventListener("addedToStage",__addToStageHandler);
         _proplist.addEventListener("doubleclick",__cellDoubleClick);
         _equiplist.addEventListener("change",__listChange);
         _proplist.addEventListener("change",__listChange);
         PlayerManager.Instance.Self.addEventListener("propertychange",__upConsortiaStroeLevel);
         _changeToConsortion.addEventListener("click",__jumpToMagicHouse);
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         _bank.removeEventListener("itemclick",__bankCellClick);
         _bank.removeEventListener("doubleclick",__bankCellDoubleClick);
         removeEventListener("addedToStage",__addToStageHandler);
         _proplist.removeEventListener("doubleclick",__cellDoubleClick);
         _equiplist.removeEventListener("change",__listChange);
         _proplist.removeEventListener("change",__listChange);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__upConsortiaStroeLevel);
         _changeToConsortion.removeEventListener("click",__jumpToMagicHouse);
      }
      
      override protected function initBackGround() : void
      {
         super.initBackGround();
         _bank = new ConsortionBankListView(11,PlayerManager.Instance.Self.consortiaInfo.StoreLevel);
         PositionUtils.setPos(_bank,"consortion.bank.Pos");
         _titleText2 = ComponentFactory.Instance.creatComponentByStylename("consortion.bankBagView.titleText2");
         _titleText2.text = LanguageMgr.GetTranslation("consortion.bankBagView.titleText2");
         addChild(_bank);
         addChild(_titleText2);
      }
      
      override protected function __listChange(evt:Event) : void
      {
         if(_dressbagView && _dressbagView.visible == true)
         {
            return;
         }
         if(evt.currentTarget == _equiplist)
         {
            setBagType(0);
         }
         else
         {
            setBagType(1);
         }
      }
      
      override protected function __cellDoubleClick(evt:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var checkNum:int = _bank.checkBankCell();
         if(checkNum > 0)
         {
            if(checkNum == 1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.ConsortiaClubView.cellDoubleClick"));
            }
            else if(checkNum == 2 || checkNum == 3)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.ConsortiaClubView.cellDoubleClick.msg"));
            }
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         evt.stopImmediatePropagation();
         var cell:BagCell = evt.data as BagCell;
         var info:InventoryItemInfo = cell.info as InventoryItemInfo;
         if(checkDressSaved(info))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.cannotStore"));
            return;
         }
         var templeteInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(info.TemplateID);
         var playerSex:int = !!PlayerManager.Instance.Self.Sex?1:2;
         if(!cell.locked)
         {
            SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,11,-1);
         }
      }
      
      private function __jumpToMagicHouse(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade >= 40)
         {
            ConsortionModelManager.Instance.hideBankFrame();
            MagicHouseModel.instance.viewIndex = 1;
            MagicHouseManager.instance.show();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",40));
         }
      }
      
      private function __bankCellClick(evt:CellEvent) : void
      {
         var cell:* = null;
         var info:* = null;
         if(!_sellBtn.isActive)
         {
            evt.stopImmediatePropagation();
            cell = evt.data as BagCell;
            if(cell)
            {
               info = cell.info as InventoryItemInfo;
            }
            if(info == null)
            {
               return;
            }
            if(!cell.locked)
            {
               SoundManager.instance.play("008");
               cell.dragStart();
            }
         }
      }
      
      private function __bankCellDoubleClick(evt:CellEvent) : void
      {
         SoundManager.instance.play("008");
         evt.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var cell:BagCell = evt.data as BagCell;
         var info:InventoryItemInfo = cell.itemInfo;
         SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,getItemBagType(info),-1,info.Count);
      }
      
      private function getItemBagType(info:InventoryItemInfo) : int
      {
         if(EquipType.isBelongToPropBag(info))
         {
            return 1;
         }
         return 0;
      }
      
      private function __upConsortiaStroeLevel(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["StoreLevel"])
         {
            __addToStageHandler(null);
         }
      }
      
      private function __addToStageHandler(evt:Event) : void
      {
         _bank.updateBankBag(PlayerManager.Instance.Self.consortiaInfo.StoreLevel);
      }
      
      public function setData($info:SelfInfo) : void
      {
         _equiplist.setData($info.Bag);
         _proplist.setData($info.PropBag);
         _bank.setData($info.ConsortiaBag);
      }
      
      override protected function __cellClick(evt:CellEvent) : void
      {
         var cell:* = null;
         var info:* = null;
         var pos:* = null;
         if(!_sellBtn.isActive)
         {
            evt.stopImmediatePropagation();
            cell = evt.data as BagCell;
            if(cell)
            {
               info = cell.info as InventoryItemInfo;
            }
            if(info == null)
            {
               return;
            }
            if(!cell.locked)
            {
               SoundManager.instance.play("008");
               if(!DressUtils.isDress(info) && (info.getRemainDate() <= 0 && !EquipType.isProp(info) || EquipType.isPackage(info) || info.getRemainDate() <= 0 && info.TemplateID == 10200 || EquipType.canBeUsed(info)))
               {
                  pos = localToGlobal(new Point(cell.x,cell.y));
                  CellMenu.instance.show(cell,pos.x + 35,pos.y + 77);
               }
               else
               {
                  if(checkDressSaved(info))
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.cannotStore"));
                     return;
                  }
                  cell.dragStart();
               }
            }
         }
      }
      
      override protected function __cellMove(evt:Event) : void
      {
         var cell:BagCell = CellMenu.instance.cell;
         var info:InventoryItemInfo = cell.info as InventoryItemInfo;
         if(checkDressSaved(info))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.cannotStore"));
            return;
         }
         super.__cellMove(evt);
      }
      
      private function checkDressSaved(info:InventoryItemInfo) : Boolean
      {
         var i:int = 0;
         var item:* = null;
         var j:int = 0;
         var dressArr:* = null;
         var k:int = 0;
         var vo:* = null;
         if(!DressUtils.isDress(info))
         {
            return false;
         }
         var bag:BagInfo = PlayerManager.Instance.Self.Bag;
         for(i = 0; i <= 8 - 1; )
         {
            item = bag.items[DressUtils.getBagItems(i)];
            if(item && info.ItemID == item.ItemID)
            {
               return true;
            }
            i++;
         }
         var modelArr:Array = PlayerDressManager.instance.modelArr;
         for(j = 0; j <= modelArr.length - 1; )
         {
            dressArr = modelArr[j];
            if(dressArr)
            {
               for(k = 0; k <= dressArr.length - 1; )
               {
                  vo = dressArr[k];
                  if(info.ItemID == vo.itemId)
                  {
                     return true;
                  }
                  k++;
               }
            }
            j++;
         }
         return false;
      }
      
      override protected function __sortBagClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(11);
         PlayerManager.Instance.Self.PropBag.sortBag(3,bagInfo,0,100,_bagArrangeSprite.arrangeAdd);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bank)
         {
            _bank.dispose();
         }
         _bank = null;
         if(_titleText2)
         {
            ObjectUtils.disposeObject(_titleText2);
         }
         _titleText2 = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
