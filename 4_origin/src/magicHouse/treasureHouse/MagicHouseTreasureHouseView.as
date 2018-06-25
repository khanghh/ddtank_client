package magicHouse.treasureHouse
{
   import bagAndInfo.bag.BagView;
   import bagAndInfo.bag.CellMenu;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelController;
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
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import magicHouse.MagicHouseControl;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   import playerDress.PlayerDressManager;
   import playerDress.components.DressUtils;
   import playerDress.data.DressVo;
   
   public class MagicHouseTreasureHouseView extends BagView
   {
       
      
      private var _bagListBg:MutipleImage;
      
      private var _bagTipBitmap:Bitmap;
      
      private var _treasureBagListView:MagicHouseTreasureBagListView;
      
      private var _changeToConsortion:SimpleBitmapButton;
      
      public function MagicHouseTreasureHouseView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bagListBg = ComponentFactory.Instance.creatComponentByStylename("magicHouse.treasureHouseView.bagList.bg");
         _bagTipBitmap = ComponentFactory.Instance.creatBitmap("magichouse.treasure.bagtip");
         _changeToConsortion = ComponentFactory.Instance.creatComponentByStylename("magicHouse.treasureView.stateChangeBtn");
         addChild(_bagListBg);
         setChildIndex(_bagListBg,0);
         addChild(_bagTipBitmap);
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
      
      public function setData($info:SelfInfo) : void
      {
         _equiplist.setData($info.Bag);
         _proplist.setData($info.PropBag);
         _treasureBagListView.setData($info.MagicHouseBag);
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
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _treasureBagListView.addEventListener("itemclick",__bankCellClick);
         _treasureBagListView.addEventListener("doubleclick",__bankCellDoubleClick);
         addEventListener("addedToStage",__addToStageHandler);
         _proplist.addEventListener("doubleclick",__cellDoubleClick);
         _equiplist.addEventListener("change",__listChange);
         _proplist.addEventListener("change",__listChange);
         _changeToConsortion.addEventListener("click",__jumpToConsortion);
         PlayerManager.Instance.Self.addEventListener("propertychange",__upMagicHouseStroeLevel);
         MagicHouseManager.instance.addEventListener("magichouse_updata",__messageUpdate);
      }
      
      override protected function removeEvents() : void
      {
         _treasureBagListView.removeEventListener("itemclick",__bankCellClick);
         _treasureBagListView.removeEventListener("doubleclick",__bankCellDoubleClick);
         removeEventListener("addedToStage",__addToStageHandler);
         _proplist.removeEventListener("doubleclick",__cellDoubleClick);
         _equiplist.removeEventListener("change",__listChange);
         _proplist.removeEventListener("change",__listChange);
         _changeToConsortion.removeEventListener("click",__jumpToConsortion);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__upMagicHouseStroeLevel);
         MagicHouseManager.instance.removeEventListener("magichouse_updata",__messageUpdate);
         super.removeEvents();
      }
      
      override protected function initBackGround() : void
      {
         super.initBackGround();
         _treasureBagListView = new MagicHouseTreasureBagListView(51,MagicHouseModel.instance.depotCount);
         PositionUtils.setPos(_treasureBagListView,"magicHouse.TreasureBag.Pos");
         addChild(_treasureBagListView);
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
      
      private function __jumpToConsortion(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            MagicHouseControl.instance.closeMagicHouseView();
            ConsortionModelController.Instance.alertBankFrame();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.treasureView.noConsortion"));
         }
      }
      
      private function __messageUpdate(e:Event) : void
      {
         _treasureBagListView.addDepot(MagicHouseModel.instance.depotCount);
      }
      
      private function __upMagicHouseStroeLevel(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["StoreLevel"])
         {
            __addToStageHandler(null);
         }
      }
      
      private function __addToStageHandler(evt:Event) : void
      {
         _treasureBagListView.addDepot(MagicHouseModel.instance.depotCount);
      }
      
      override protected function __cellDoubleClick(evt:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var checkNum:int = _treasureBagListView.checkMagicHouseStoreCell();
         if(checkNum == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.treasureView.bagFull"));
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
            SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,51,-1);
         }
      }
      
      override protected function __sortBagClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(51);
         PlayerManager.Instance.Self.PropBag.sortBag(51,bagInfo,0,100,_bagArrangeSprite.arrangeAdd);
         if(_bagType != 21)
         {
            PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48,_bagArrangeSprite.arrangeAdd);
         }
         else
         {
            PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),32,178,true);
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
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bagListBg)
         {
            ObjectUtils.disposeObject(_bagListBg);
         }
         _bagListBg = null;
         if(_changeToConsortion)
         {
            ObjectUtils.disposeObject(_changeToConsortion);
         }
         _changeToConsortion = null;
         if(_bagTipBitmap)
         {
            ObjectUtils.disposeObject(_bagTipBitmap);
         }
         _bagTipBitmap = null;
         if(_treasureBagListView)
         {
            ObjectUtils.disposeObject(_treasureBagListView);
         }
         _treasureBagListView = null;
      }
   }
}
