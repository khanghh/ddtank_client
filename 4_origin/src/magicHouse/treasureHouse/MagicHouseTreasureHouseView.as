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
      
      public function setData(param1:SelfInfo) : void
      {
         _equiplist.setData(param1.Bag);
         _proplist.setData(param1.PropBag);
         _treasureBagListView.setData(param1.MagicHouseBag);
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
      
      private function __jumpToConsortion(param1:MouseEvent) : void
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
      
      private function __messageUpdate(param1:Event) : void
      {
         _treasureBagListView.addDepot(MagicHouseModel.instance.depotCount);
      }
      
      private function __upMagicHouseStroeLevel(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["StoreLevel"])
         {
            __addToStageHandler(null);
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         _treasureBagListView.addDepot(MagicHouseModel.instance.depotCount);
      }
      
      override protected function __cellDoubleClick(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:int = _treasureBagListView.checkMagicHouseStoreCell();
         if(_loc3_ == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.treasureView.bagFull"));
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
            SocketManager.Instance.out.sendMoveGoods(_loc6_.BagType,_loc6_.Place,51,-1);
         }
      }
      
      override protected function __sortBagClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BagInfo = PlayerManager.Instance.Self.getBag(51);
         PlayerManager.Instance.Self.PropBag.sortBag(51,_loc2_,0,100,_bagArrangeSprite.arrangeAdd);
         if(_bagType != 21)
         {
            PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),0,48,_bagArrangeSprite.arrangeAdd);
         }
         else
         {
            PlayerManager.Instance.Self.PropBag.sortBag(_bagType,PlayerManager.Instance.Self.getBag(_bagType),32,178,true);
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
