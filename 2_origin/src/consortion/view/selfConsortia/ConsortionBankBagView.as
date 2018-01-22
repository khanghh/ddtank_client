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
      
      override public function setBagType(param1:int) : void
      {
         super.setBagType(param1);
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
      
      override protected function __listChange(param1:Event) : void
      {
         if(_dressbagView && _dressbagView.visible == true)
         {
            return;
         }
         if(param1.currentTarget == _equiplist)
         {
            setBagType(0);
         }
         else
         {
            setBagType(1);
         }
      }
      
      override protected function __cellDoubleClick(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:int = _bank.checkBankCell();
         if(_loc3_ > 0)
         {
            if(_loc3_ == 1)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.club.ConsortiaClubView.cellDoubleClick"));
            }
            else if(_loc3_ == 2 || _loc3_ == 3)
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
         param1.stopImmediatePropagation();
         var _loc4_:BagCell = param1.data as BagCell;
         var _loc6_:InventoryItemInfo = _loc4_.info as InventoryItemInfo;
         if(checkDressSaved(_loc6_))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.cannotStore"));
            return;
         }
         var _loc5_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_loc6_.TemplateID);
         var _loc2_:int = !!PlayerManager.Instance.Self.Sex?1:2;
         if(!_loc4_.locked)
         {
            SocketManager.Instance.out.sendMoveGoods(_loc6_.BagType,_loc6_.Place,11,-1);
         }
      }
      
      private function __jumpToMagicHouse(param1:MouseEvent) : void
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
      
      private function __bankCellClick(param1:CellEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!_sellBtn.isActive)
         {
            param1.stopImmediatePropagation();
            _loc2_ = param1.data as BagCell;
            if(_loc2_)
            {
               _loc3_ = _loc2_.info as InventoryItemInfo;
            }
            if(_loc3_ == null)
            {
               return;
            }
            if(!_loc2_.locked)
            {
               SoundManager.instance.play("008");
               _loc2_.dragStart();
            }
         }
      }
      
      private function __bankCellDoubleClick(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:BagCell = param1.data as BagCell;
         var _loc3_:InventoryItemInfo = _loc2_.itemInfo;
         SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,getItemBagType(_loc3_),-1,_loc3_.Count);
      }
      
      private function getItemBagType(param1:InventoryItemInfo) : int
      {
         if(EquipType.isBelongToPropBag(param1))
         {
            return 1;
         }
         return 0;
      }
      
      private function __upConsortiaStroeLevel(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["StoreLevel"])
         {
            __addToStageHandler(null);
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _bank.updateBankBag(PlayerManager.Instance.Self.consortiaInfo.StoreLevel);
      }
      
      public function setData(param1:SelfInfo) : void
      {
         _equiplist.setData(param1.Bag);
         _proplist.setData(param1.PropBag);
         _bank.setData(param1.ConsortiaBag);
      }
      
      override protected function __cellClick(param1:CellEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(!_sellBtn.isActive)
         {
            param1.stopImmediatePropagation();
            _loc2_ = param1.data as BagCell;
            if(_loc2_)
            {
               _loc4_ = _loc2_.info as InventoryItemInfo;
            }
            if(_loc4_ == null)
            {
               return;
            }
            if(!_loc2_.locked)
            {
               SoundManager.instance.play("008");
               if(!DressUtils.isDress(_loc4_) && (_loc4_.getRemainDate() <= 0 && !EquipType.isProp(_loc4_) || EquipType.isPackage(_loc4_) || _loc4_.getRemainDate() <= 0 && _loc4_.TemplateID == 10200 || EquipType.canBeUsed(_loc4_)))
               {
                  _loc3_ = localToGlobal(new Point(_loc2_.x,_loc2_.y));
                  CellMenu.instance.show(_loc2_,_loc3_.x + 35,_loc3_.y + 77);
               }
               else
               {
                  if(checkDressSaved(_loc4_))
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.cannotStore"));
                     return;
                  }
                  _loc2_.dragStart();
               }
            }
         }
      }
      
      override protected function __cellMove(param1:Event) : void
      {
         var _loc2_:BagCell = CellMenu.instance.cell;
         var _loc3_:InventoryItemInfo = _loc2_.info as InventoryItemInfo;
         if(checkDressSaved(_loc3_))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("playerDress.cannotStore"));
            return;
         }
         super.__cellMove(param1);
      }
      
      private function checkDressSaved(param1:InventoryItemInfo) : Boolean
      {
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         if(!DressUtils.isDress(param1))
         {
            return false;
         }
         var _loc2_:BagInfo = PlayerManager.Instance.Self.Bag;
         _loc9_ = 0;
         while(_loc9_ <= 8 - 1)
         {
            _loc3_ = _loc2_.items[DressUtils.getBagItems(_loc9_)];
            if(_loc3_ && param1.ItemID == _loc3_.ItemID)
            {
               return true;
            }
            _loc9_++;
         }
         var _loc6_:Array = PlayerDressManager.instance.modelArr;
         _loc5_ = 0;
         while(_loc5_ <= _loc6_.length - 1)
         {
            _loc4_ = _loc6_[_loc5_];
            if(_loc4_)
            {
               _loc7_ = 0;
               while(_loc7_ <= _loc4_.length - 1)
               {
                  _loc8_ = _loc4_[_loc7_];
                  if(param1.ItemID == _loc8_.itemId)
                  {
                     return true;
                  }
                  _loc7_++;
               }
            }
            _loc5_++;
         }
         return false;
      }
      
      override protected function __sortBagClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BagInfo = PlayerManager.Instance.Self.getBag(11);
         PlayerManager.Instance.Self.PropBag.sortBag(3,_loc2_,0,100,_bagArrangeSprite.arrangeAdd);
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
