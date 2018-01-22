package enchant.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.ShortcutBuyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import enchant.EnchantManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import shop.manager.ShopBuyManager;
   
   public class EnchantMainView extends Sprite implements Disposeable
   {
       
      
      private var _itemBg:Bitmap;
      
      private var _enchantValueTxt:FilterFrameText;
      
      private var _enchantDesc:FilterFrameText;
      
      private var _bagCell:BagCell;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _upGradeBtn:SelectedCheckButton;
      
      private var _enchantBtn:SimpleBitmapButton;
      
      private var _successMc:MovieClip;
      
      private var _enchantMc:MovieClip;
      
      private var _expBar:EnchantExpBar;
      
      private var _equipListView:EnchantBagListView;
      
      private var _propListView:EnchantBagListView;
      
      private var _leftDrapSprite:EnchantLeftDragSprite;
      
      private var _itemCell:EnchantItemCell;
      
      private var _equipCell:EnchantEquipCell;
      
      public var updateEquipCellFunc:Function;
      
      public var updateEquipCellInfo:InventoryItemInfo;
      
      private var _helpBtn:BaseButton;
      
      private var _lastExaltTime:int = 0;
      
      public function EnchantMainView()
      {
         super();
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",_enchantCompHander);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",_enchantProgress);
         UIModuleLoader.Instance.addUIModuleImp("enchant");
      }
      
      protected function _enchantProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "enchant")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      protected function _enchantCompHander(param1:UIModuleEvent) : void
      {
         if(param1.module == "enchant")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",_enchantCompHander);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",_enchantProgress);
            initView();
            initEvent();
            createAcceptDragSprite();
         }
      }
      
      private function initView() : void
      {
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",{
            "x":625,
            "y":-58
         },LanguageMgr.GetTranslation("enchant.help.title"),"enchant.helpFrame.text",404,484);
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.enchant.itemBg");
         addChild(_itemBg);
         _enchantValueTxt = ComponentFactory.Instance.creatComponentByStylename("enchant.valueTxt");
         addChild(_enchantValueTxt);
         _enchantValueTxt.text = LanguageMgr.GetTranslation("enchant.valueTxt");
         _enchantDesc = ComponentFactory.Instance.creatComponentByStylename("enchant.descTxt");
         addChild(_enchantDesc);
         _enchantDesc.text = LanguageMgr.GetTranslation("enchant.descTxt");
         _enchantBtn = ComponentFactory.Instance.creatComponentByStylename("enchant.enchantBtn");
         addChild(_enchantBtn);
         var _loc1_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(EnchantManager.instance.soulStoneId);
         _bagCell = new BagCell(0,_loc1_);
         PositionUtils.setPos(_bagCell,"enchant.bagCellPos");
         addChild(_bagCell);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("enchant.buyBtn");
         addChild(_buyBtn);
         _upGradeBtn = ComponentFactory.Instance.creatComponentByStylename("enchant.upGrade");
         addChild(_upGradeBtn);
         _expBar = new EnchantExpBar();
         _expBar.upGradeFunc = showSuccessMovie;
         addChild(_expBar);
         _expBar.x = 72;
         _expBar.y = 175;
         _equipListView = new EnchantBagListView();
         _equipListView.setup(0,null,21);
         PositionUtils.setPos(_equipListView,"enchant.bagListPos");
         addChild(_equipListView);
         _propListView = new EnchantBagListView();
         PositionUtils.setPos(_propListView,"enchant.proBagListPos");
         _propListView.setup(1,null,21);
         addChild(_propListView);
         refreshBagList();
         _equipCell = new EnchantEquipCell(1,0,null,true,new Bitmap(new BitmapData(60,60,true,0)),false);
         _equipCell.BGVisible = false;
         PositionUtils.setPos(_equipCell,"enchant.equipCellPos");
         addChild(_equipCell);
         _equipCell.setContentSize(68,68);
         _equipCell.tipDirctions = "5,2,7";
         _equipCell.PicPos = new Point(-3,-5);
         _itemCell = new EnchantItemCell(0,0,null,true,new Bitmap(new BitmapData(60,60,true,0)),false);
         PositionUtils.setPos(_itemCell,"enchant.itemCellPos");
         _itemCell.BGVisible = false;
         addChild(_itemCell);
      }
      
      private function initEvent() : void
      {
         _enchantBtn.addEventListener("click",__enchantHandler);
         _buyBtn.addEventListener("click",__buySoulStoneHander);
         _equipListView.addEventListener("itemclick",cellClickHandler,false,0,true);
         _equipListView.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _propListView.addEventListener("itemclick",cellClickHandler,false,0,true);
         _propListView.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateStoreBag);
      }
      
      private function initProgress(param1:Boolean) : void
      {
         if(!_equipCell || !_equipCell.info)
         {
            _expBar.initPercentAndTip();
            return;
         }
         var _loc5_:int = (_equipCell.info as InventoryItemInfo).MagicLevel;
         var _loc4_:* = _loc5_ >= EnchantManager.instance.infoVec.length;
         var _loc6_:Number = EnchantManager.instance.getEnchantInfoByLevel(_loc5_).Exp;
         var _loc2_:Number = !!_loc4_?0:Number((_equipCell.info as InventoryItemInfo).MagicExp - _loc6_);
         var _loc3_:Number = !!_loc4_?0:Number(EnchantManager.instance.getEnchantInfoByLevel(_loc5_ + 1).Exp - _loc6_);
         if(param1)
         {
            _enchantBtn.enable = EnchantManager.instance.isUpGrade == false;
            _expBar.updateProgress(_loc2_,_loc3_,EnchantManager.instance.isUpGrade);
         }
         else
         {
            _expBar.initProgress(_loc2_,_loc3_);
         }
      }
      
      protected function __updateStoreBag(param1:BagEvent) : void
      {
         var _loc2_:* = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param1.changedSlots;
         for(_loc2_ in param1.changedSlots)
         {
            _loc4_ = PlayerManager.Instance.Self.StoreBag.items[_loc2_];
            if(_loc2_ == 0)
            {
               _itemCell.info = _loc4_;
            }
            else if(_loc2_ == 1)
            {
               if(_leftDrapSprite.equipCellActionState)
               {
                  _equipCell.info = _loc4_;
                  initProgress(false);
                  _leftDrapSprite.equipCellActionState = false;
               }
               else
               {
                  if(EnchantManager.instance.isUpGrade)
                  {
                     updateEquipCellInfo = _loc4_;
                     updateEquipCellFunc = updateEquipCell;
                  }
                  else
                  {
                     _equipCell.info = _loc4_;
                  }
                  initProgress(true);
               }
            }
         }
      }
      
      public function updateEquipCell() : void
      {
         _equipCell.info = updateEquipCellInfo;
      }
      
      private function cellClickHandler(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BagCell = param1.data as BagCell;
         _loc2_.dragStart();
      }
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = (param1.data as BagCell).info as InventoryItemInfo;
         if(_loc2_.MagicLevel >= EnchantManager.instance.infoVec.length)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("enchant.cannotUp"));
            return;
         }
         if(param1.target == _propListView)
         {
            SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,0,_loc2_.Count,true);
         }
         else
         {
            _leftDrapSprite.equipCellActionState = true;
            SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,1,1);
         }
      }
      
      protected function __buySoulStoneHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(EnchantManager.instance.soulStoneGoodsId);
         ShopBuyManager.Instance.buy(_loc2_.GoodsID,_loc2_.isDiscount,_loc2_.getItemPrice(1).PriceType);
      }
      
      private function removeFromStageHandler(param1:Event) : void
      {
         BagStore.instance.reduceTipPanelNumber();
      }
      
      private function __shortCutBuyHandler(param1:ShortcutBuyEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function createAcceptDragSprite() : void
      {
         _leftDrapSprite = new EnchantLeftDragSprite();
         _leftDrapSprite.mouseEnabled = false;
         _leftDrapSprite.mouseChildren = false;
         _leftDrapSprite.graphics.beginFill(0,0);
         _leftDrapSprite.graphics.drawRect(0,0,347,404);
         _leftDrapSprite.graphics.endFill();
         PositionUtils.setPos(_leftDrapSprite,"enchant.leftDrapSpritePos");
         addChild(_leftDrapSprite);
      }
      
      protected function __enchantHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.playButtonSound();
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastExaltTime > 1400)
         {
            _lastExaltTime = _loc2_;
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(_equipCell.info == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("enchant.noEquip"));
               return;
            }
            if(_itemCell.info == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("enchant.noSouleStone"));
               return;
            }
            if((_equipCell.info as InventoryItemInfo).MagicLevel >= EnchantManager.instance.infoVec.length)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("enchant.cannotUp"));
               return;
            }
            if(!_equipCell.itemInfo.IsBinds && _itemCell.itemInfo.IsBinds)
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIComposeBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc3_.addEventListener("response",_responseI);
            }
            else
            {
               showEnchantMovie();
               SocketManager.Instance.out.sendEnchant(_upGradeBtn.selected);
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
         }
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_responseI);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            showEnchantMovie();
            SocketManager.Instance.out.sendEnchant(_upGradeBtn.selected);
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function showEnchantMovie() : void
      {
         if(_enchantMc)
         {
            _enchantMc.stop();
         }
         ObjectUtils.disposeObject(_enchantMc);
         _enchantMc = null;
         _enchantMc = UICreatShortcut.creatAndAdd("asset.ddtstore.exalt.movieII",this);
         PositionUtils.setPos(_enchantMc,"enchant.moviePos");
         _enchantMc.gotoAndPlay(1);
         _enchantMc.addFrameScript(_enchantMc.totalFrames - 1,disposeExaltMovie);
      }
      
      private function disposeExaltMovie() : void
      {
         if(_enchantMc)
         {
            _enchantMc.stop();
         }
         ObjectUtils.disposeObject(_enchantMc);
         _enchantMc = null;
      }
      
      private function showSuccessMovie() : void
      {
         if(_successMc)
         {
            _successMc.stop();
         }
         ObjectUtils.disposeObject(_successMc);
         _successMc = null;
         _successMc = UICreatShortcut.creatAndAdd("asset.ddtstore.exalt.movieI",this);
         _successMc.gotoAndPlay(1);
         PositionUtils.setPos(_successMc,"enchant.moviePos2");
         _successMc.addFrameScript(_successMc.totalFrames - 1,disposeSuccessMovie);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         .super.visible = param1;
         if(param1)
         {
            refreshBagList();
            addUpdateStoreEvent();
            if(_expBar)
            {
               _expBar.initPercentAndTip();
            }
         }
         else
         {
            SocketManager.Instance.out.sendClearStoreBag();
            clearCellInfo();
            if(_expBar)
            {
               _expBar.initProgress(0,0);
            }
            removeUpdateStoreEvent();
         }
      }
      
      private function refreshBagList() : void
      {
         if(_equipListView)
         {
            _equipListView.setData(EnchantManager.instance.model.canEnchantEquipList);
         }
         if(_propListView)
         {
            _propListView.setData(EnchantManager.instance.model.canEnchantPropList);
         }
      }
      
      public function addUpdateStoreEvent() : void
      {
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateStoreBag);
      }
      
      public function removeUpdateStoreEvent() : void
      {
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateStoreBag);
      }
      
      public function clearCellInfo() : void
      {
         if(_equipCell)
         {
            _equipCell.info = null;
         }
         if(_itemCell)
         {
            _itemCell.info = null;
         }
      }
      
      private function disposeSuccessMovie() : void
      {
         if(_successMc)
         {
            _successMc.stop();
         }
         ObjectUtils.disposeObject(_successMc);
         _successMc = null;
         EnchantManager.instance.isUpGrade = false;
         if(updateEquipCellFunc != null)
         {
            updateEquipCellFunc();
         }
         _enchantBtn.enable = EnchantManager.instance.isUpGrade == false;
      }
      
      private function removeEvent() : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",_enchantCompHander);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",_enchantProgress);
         _enchantBtn.removeEventListener("click",__enchantHandler);
         _buyBtn.removeEventListener("click",__buySoulStoneHander);
         _equipListView.removeEventListener("itemclick",cellClickHandler);
         _equipListView.removeEventListener("doubleclick",__cellDoubleClick);
         _propListView.removeEventListener("itemclick",cellClickHandler);
         _propListView.removeEventListener("doubleclick",__cellDoubleClick);
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateStoreBag);
      }
      
      public function dispose() : void
      {
         removeEvent();
         disposeExaltMovie();
         disposeSuccessMovie();
         ObjectUtils.disposeAllChildren(this);
         _helpBtn = null;
         _expBar = null;
         _itemBg = null;
         _enchantValueTxt = null;
         _enchantDesc = null;
         _enchantBtn = null;
         _buyBtn = null;
         _upGradeBtn = null;
         _bagCell = null;
         _equipListView = null;
         _propListView = null;
         _leftDrapSprite = null;
         _equipCell = null;
         _itemCell = null;
      }
   }
}
