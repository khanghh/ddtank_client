package store.fineStore.view.pageBringUp
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.LockableBagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import flash.utils.setTimeout;
   import latentEnergy.LatentEnergyEvent;
   import shop.view.BuyJewelryExperienceView;
   import store.FineBringUpController;
   import store.forge.ForgeRightBgView;
   import trainer.view.NewHandContainer;
   
   public class FineBringUpView extends Sprite implements Disposeable, IObserver
   {
      
      public static var isEatStatus:Boolean = false;
       
      
      private var _leftBg:MovieClip;
      
      private var _rightBgView:ForgeRightBgView;
      
      private var _bgCell:Bitmap;
      
      private var _upgrade:MovieClip;
      
      private var _eatExp:MovieClip;
      
      private var _bringUpItemCell:FineBringUpCell;
      
      private var _bagList:FineBringUpBagListView;
      
      private var _rightDrapSprite:FineBringUpRightDragSprite;
      
      private var _leftDrapSprite:FineBringUpLeftDragSprite;
      
      private var _buyExpBtn:SimpleBitmapButton;
      
      private var _bringUpEatAllBtn:SimpleBitmapButton;
      
      private var _bringUpEatBtn:SimpleBitmapButton;
      
      private var _bringUpLockBtn:SelectedButton;
      
      private var _mouseLockImg:Sprite;
      
      private var _mouseEatImg:Sprite;
      
      private var _helpBtn:BaseButton;
      
      private var _progress:MovieClip;
      
      private var _progressTips:OneLineTip;
      
      private var _progressTxt:FilterFrameText;
      
      private var _listData:BagInfo;
      
      private var _usingEatMouse:Boolean = false;
      
      private var _moneyBoard:Sprite;
      
      private var showMoneyBG:MutipleImage;
      
      private var moneyTxt:FilterFrameText;
      
      private var bindMoneyTxt:FilterFrameText;
      
      private var medelTxt:FilterFrameText;
      
      private var _moneyButton:RichesButton;
      
      private var _bindMoneyButton:RichesButton;
      
      private var _medelButton:RichesButton;
      
      private var _scrollPanel:ListPanel;
      
      private var _refreshTooFast:Boolean = false;
      
      public function FineBringUpView()
      {
         super();
         initView();
         initEvent();
         createAcceptDragSprite();
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:int = FineBringUpController.getInstance().progress(param1 as InventoryItemInfo);
         if(_progress.totalFrames >= _loc2_)
         {
            _progress && _progress.gotoAndStop(_loc2_);
            _progressTxt && _loc3_;
         }
         else
         {
            _progress && _progress.gotoAndStop(0);
            _progressTxt && _loc3_;
         }
      }
      
      private function initView() : void
      {
         _leftBg = ComponentFactory.Instance.creat("asset.store.bringup.leftBg");
         PositionUtils.setPos(_leftBg,"storeBringUp.leftBgPos");
         _leftBg.gotoAndStop(1);
         addChild(_leftBg);
         _rightBgView = new ForgeRightBgView();
         _rightBgView.hideMoney();
         _rightBgView.title1("");
         _rightBgView.title2("");
         _rightBgView.showStoreBagViewText(LanguageMgr.GetTranslation("tank.view.bagII.rightTip"),"",false);
         _rightBgView.equipmentTipText().x = _rightBgView.equipmentTipText().x - 40;
         _rightBgView.bgFrame(2);
         PositionUtils.setPos(_rightBgView,"storeBringUp.rightBgViewPos");
         addChild(_rightBgView);
         _bagList = new FineBringUpBagListView(0,7,63);
         BringupScrollCell._bringupContent = _bagList;
         _scrollPanel = ComponentFactory.Instance.creat("bringup.scrollPanel");
         _scrollPanel.vectorListModel.clear();
         _scrollPanel.vectorListModel.appendAll([{}]);
         addChild(_scrollPanel);
         refreshBagList();
         _bgCell = ComponentFactory.Instance.creatBitmap("equipretrieve.trieveCell1");
         PositionUtils.setPos(_bgCell,"storeBringUp.itemCellPos");
         addChild(_bgCell);
         _bringUpItemCell = new FineBringUpCell(0);
         _bringUpItemCell.info = null;
         _bringUpItemCell.register(this);
         _bringUpItemCell.x = _bgCell.x + 22;
         _bringUpItemCell.y = _bgCell.y + 24;
         addChild(_bringUpItemCell);
         _upgrade = ComponentFactory.Instance.creat("asset.strength.weaponUpgrades");
         _upgrade.mouseEnabled = false;
         _upgrade.mouseChildren = false;
         _upgrade.x = _bringUpItemCell.x + _bringUpItemCell.width * 0.5;
         _upgrade.y = _bringUpItemCell.y + _bringUpItemCell.height * 0.5;
         _upgrade.gotoAndStop(_upgrade.totalFrames);
         addChild(_upgrade);
         _eatExp = ComponentFactory.Instance.creat("accet.strength.starMovie");
         _eatExp.mouseEnabled = false;
         _eatExp.mouseChildren = false;
         PositionUtils.setPos(_eatExp,"storeBringUp.expEatMCPos");
         _eatExp.gotoAndStop(_eatExp.totalFrames);
         addChild(_eatExp);
         _progress = ComponentFactory.Instance.creat("asset.store.bringup.progressbar");
         PositionUtils.setPos(_progress,"storeBringUp.progressPos");
         _progress.stop();
         addChild(_progress);
         _progressTips = new OneLineTip();
         _progressTips.tipData = "0/0";
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("ddt.store.view.exalt.StoreExaltProgressBar.percentage");
         PositionUtils.setPos(_progressTxt,"storeBringUp.progressTxtPos");
         _progressTxt.mouseEnabled = false;
         _progressTxt.text = "0%";
         addChild(_progressTxt);
         _bringUpEatAllBtn = ComponentFactory.Instance.creat("storeBringUp.bringUpEatAllBtn");
         addChild(_bringUpEatAllBtn);
         _bringUpEatBtn = ComponentFactory.Instance.creat("storeBringUp.bringUpEatBtn");
         addChild(_bringUpEatBtn);
         _bringUpLockBtn = ComponentFactory.Instance.creat("bringup.lock.checkBoxBtn");
         addChild(_bringUpLockBtn);
         _mouseLockImg = new Sprite();
         _mouseLockImg.addChild(ComponentFactory.Instance.creatBitmap("asset.store.bringup.lockCursor"));
         _mouseEatImg = new Sprite();
         _mouseEatImg.addChild(ComponentFactory.Instance.creatBitmap("asset.store.bringup.feedIcon"));
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.store.bringup.help",404,484);
         PositionUtils.setPos(_helpBtn,"storeFine.bringup.helpPos");
         _buyExpBtn = ComponentFactory.Instance.creat("storeBringUp.buyExpBtn");
         _buyExpBtn.tipStyle = "ddt.view.tips.OneLineTip";
         _buyExpBtn.tipGapV = 6;
         _buyExpBtn.tipGapH = 6;
         _buyExpBtn.tipDirctions = "0,1,2";
         _buyExpBtn.tipData = LanguageMgr.GetTranslation("tank.view.bagII.bringup.expBuyBtnTips");
         addChild(_buyExpBtn);
         _moneyBoard = new Sprite();
         _moneyBoard.x = 414;
         _moneyBoard.y = 49;
         addChild(_moneyBoard);
         showMoneyBG = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BringUp.MoneyPanelBg");
         _moneyBoard.addChild(showMoneyBG);
         moneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.TicketText");
         _moneyBoard.addChild(moneyTxt);
         _moneyButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.GoldButton");
         _moneyButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GoldDirections");
         _moneyBoard.addChild(_moneyButton);
         bindMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.GiftText");
         _moneyBoard.addChild(bindMoneyTxt);
         _bindMoneyButton = ComponentFactory.Instance.creatCustomObject("bagAndInfo.bag.GiftButton");
         _bindMoneyButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.GiftButton");
         var _loc2_:int = 6000;
         var _loc1_:int = ServerConfigManager.instance.VIPExtraBindMoneyUpper[PlayerManager.Instance.Self.VIPLevel - 1];
         if(PlayerManager.Instance.Self.IsVIP)
         {
            _bindMoneyButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",(_loc2_ + _loc1_).toString());
         }
         else
         {
            _bindMoneyButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.GiftDirections",_loc2_.toString());
         }
         _moneyBoard.addChild(_bindMoneyButton);
         _medelButton = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreBagView.MoneyButton");
         _medelButton.tipData = LanguageMgr.GetTranslation("tank.view.bagII.MoneyDirections",ServerConfigManager.instance.getBindBidLimit(PlayerManager.Instance.Self.Grade,PlayerManager.Instance.Self.VIPLevel));
         _moneyBoard.addChild(_medelButton);
         medelTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreBagView.GoldText");
         PositionUtils.setPos(medelTxt,"ddtstore.bringUp.GoldPos");
         _moneyBoard.addChild(medelTxt);
         updateMoney();
         equipChangeHandler(null);
      }
      
      private function initEvent() : void
      {
         _bagList.addEventListener("itemclick",cellClickHandler,false,0,true);
         _bagList.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
         _bringUpItemCell.addEventListener("change",equipChangeHandler,false,0,true);
         _progress.addEventListener("rollOver",onProgressOver);
         _progress.addEventListener("rollOut",onProgressOut);
         _bringUpEatAllBtn.addEventListener("click",onEatAllClick);
         _bringUpEatBtn.addEventListener("click",onEatBtnClick);
         _bringUpLockBtn.addEventListener("click",onLockBtnClick);
         FineBringUpController.getInstance().addEventListener("eat_mouse_status_change",onBringUpEatResult);
         PlayerManager.Instance.addEventListener("bring_up",__updateInventorySlot);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         _buyExpBtn.addEventListener("click",onBuyExpBtnClick);
      }
      
      private function removeEvent() : void
      {
         _bagList.removeEventListener("itemclick",cellClickHandler);
         _bagList.removeEventListener("doubleclick",__cellDoubleClick);
         _bringUpItemCell.removeEventListener("change",equipChangeHandler);
         _progress.addEventListener("rollOver",onProgressOver);
         _progress.addEventListener("rollOut",onProgressOut);
         _bringUpEatAllBtn.removeEventListener("click",onEatAllClick);
         _bringUpEatBtn.removeEventListener("click",onEatBtnClick);
         _bringUpLockBtn.removeEventListener("click",onLockBtnClick);
         FineBringUpController.getInstance().removeEventListener("eat_mouse_status_change",onBringUpEatResult);
         PlayerManager.Instance.removeEventListener("bring_up",__updateInventorySlot);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         _buyExpBtn.removeEventListener("click",onBuyExpBtnClick);
      }
      
      private function __updateInventorySlot(param1:CEvent) : void
      {
         if(FineBringUpController.getInstance().onSending)
         {
            return;
         }
         var _loc2_:InventoryItemInfo = PlayerManager.Instance.Self.getBag(12).getItemAt(0);
         if(_loc2_ == null)
         {
            _bringUpItemCell.info = _loc2_;
            _listData = FineBringUpController.getInstance().getCanBringUpData();
            _bagList.setData(_listData);
            return;
         }
         if(!(_bringUpItemCell == null || FineBringUpController.getInstance().needPlayMovie == false))
         {
            if(_bringUpItemCell.lastLevel < int(_loc2_.Property1))
            {
               _upgrade.play();
            }
            else
            {
               _eatExp.play();
            }
         }
         _bringUpItemCell && _loc3_;
         _listData = FineBringUpController.getInstance().getCanBringUpData();
         _bagList.setData(_listData);
      }
      
      protected function onProgressOut(param1:MouseEvent) : void
      {
      }
      
      protected function onProgressOver(param1:MouseEvent) : void
      {
         var _loc3_:ItemTemplateInfo = _bringUpItemCell.info;
         var _loc2_:String = FineBringUpController.getInstance().progressTipData(_bringUpItemCell.info);
         _progressTips.tipData = _loc2_;
         _progressTips.x = mouseX;
         _progressTips.y = mouseY;
         addChild(_progressTips);
      }
      
      public function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Money"] || param1.changedProperties["Gold"] || param1.changedProperties["Money"] || param1.changedProperties["BandMoney"])
         {
            updateMoney();
         }
      }
      
      private function updateMoney() : void
      {
         medelTxt.text = String(PlayerManager.Instance.Self.Gold);
         moneyTxt.text = String(PlayerManager.Instance.Self.Money);
         bindMoneyTxt.text = String(PlayerManager.Instance.Self.BandMoney);
      }
      
      protected function onBuyExpBtnClick(param1:MouseEvent) : void
      {
         e = param1;
         onBuy = function(param1:Object):void
         {
            FineBringUpController.getInstance().buyExp(param1.type,param1.num);
         };
         if(_bringUpItemCell.info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.PleaseSelect"),0,false,1);
            return;
         }
         var expData:Array = FineBringUpController.getInstance().expDataArr(_bringUpItemCell.info);
         if(expData[1] == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.topLevel"),0,false,1);
            return;
         }
         FineBringUpController.getInstance().hideNewHandTip();
         var buyView:BuyJewelryExperienceView = new BuyJewelryExperienceView(4);
         LayerManager.Instance.addToLayer(buyView,3,true,1);
         buyView.goodsData(expData[0],expData[1]);
         buyView.onBuy = onBuy;
      }
      
      protected function onBringUpEatResult(param1:CEvent) : void
      {
         e = param1;
         if(_refreshTooFast)
         {
            if(isEatStatus == true)
            {
               setTimeout(eatStatusChange,75);
            }
            return;
         }
         _refreshTooFast = true;
         TweenLite.delayedCall(1.5,function():void
         {
            _refreshTooFast = false;
         });
         if(e.data == "submited")
         {
            refreshBagList();
            var __info:InventoryItemInfo = PlayerManager.Instance.Self.getBag(12).getItemAt(0);
            _bringUpItemCell && _loc3_;
            _listData = FineBringUpController.getInstance().getCanBringUpData();
            _bagList.setData(_listData);
         }
         if(isEatStatus == true)
         {
            setTimeout(function():void
            {
               isEatStatus = false;
               _usingEatMouse = true;
               eatStatusChange();
            },75);
         }
      }
      
      protected function onEatBtnClick(param1:MouseEvent) : void
      {
         if(FineBringUpController.getInstance().isMaxLevel(_bringUpItemCell.info as InventoryItemInfo))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.maxLevel"),0,true,1);
         }
         else
         {
            _bringUpLockBtn.mouseEnabled = false;
            _bringUpEatAllBtn.mouseEnabled = false;
            FineBringUpController.getInstance().completeNewHandGuide();
            isEatStatus = true;
            param1.stopImmediatePropagation();
            eatStatusChange();
         }
      }
      
      private function eatStatusChange() : void
      {
         _usingEatMouse = !_usingEatMouse;
         if(_usingEatMouse)
         {
            Mouse.hide();
            if(_mouseEatImg == null)
            {
               _mouseEatImg = new Sprite();
               _mouseEatImg.addChild(ComponentFactory.Instance.creatBitmap("asset.store.bringup.feedIcon"));
            }
            StageReferance.stage.addChild(_mouseEatImg);
            var _loc1_:Boolean = false;
            _mouseEatImg.mouseEnabled = _loc1_;
            _mouseEatImg.mouseChildren = _loc1_;
            _mouseEatImg.x = StageReferance.stage.mouseX - _mouseEatImg.width * 0.5;
            _mouseEatImg.y = StageReferance.stage.mouseY - _mouseEatImg.height * 0.5;
            _mouseEatImg.startDrag(false);
            StageReferance.stage.addEventListener("click",onEatMouseClick);
            _bagList.removeEventListener("itemclick",cellClickHandler);
            _bagList.removeEventListener("doubleclick",__cellDoubleClick);
         }
         else
         {
            _bringUpLockBtn && _loc1_;
            _bringUpEatAllBtn && _loc1_;
            Mouse.show();
            if(_mouseEatImg)
            {
               _mouseEatImg.parent && StageReferance.stage.removeChild(_mouseEatImg);
               _mouseEatImg.stopDrag();
            }
            StageReferance.stage.removeEventListener("click",onEatMouseClick);
            if(_bagList)
            {
               _bagList.addEventListener("itemclick",cellClickHandler,false,0,true);
               _bagList.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
            }
         }
      }
      
      protected function onEatMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:LockableBagCell = param1.target as LockableBagCell;
         if(_loc2_ && _loc2_.info)
         {
            if(_loc2_.info == _bringUpItemCell.info)
            {
               eatStatusChange();
            }
            else
            {
               if(_loc2_.cellLocked)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.canNotEatLockedCell"),0,true,1);
                  return;
               }
               onEatClick(_loc2_.info as InventoryItemInfo);
               _usingEatMouse = false;
               StageReferance.stage.removeEventListener("click",onEatMouseClick);
               Mouse.show();
               if(_mouseEatImg)
               {
                  _mouseEatImg.parent && StageReferance.stage.removeChild(_mouseEatImg);
                  _mouseEatImg.stopDrag();
               }
            }
         }
         else
         {
            isEatStatus = false;
            eatStatusChange();
         }
      }
      
      private function onEatClick(param1:InventoryItemInfo) : void
      {
         if(FineBringUpController.getInstance().isMaxLevel(_bringUpItemCell.info as InventoryItemInfo))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.maxLevel"),0,true,1);
         }
         else
         {
            _bringUpItemCell && FineBringUpController.getInstance().eatBtnClick(_bringUpItemCell.info as InventoryItemInfo,param1);
         }
      }
      
      protected function onEatAllClick(param1:MouseEvent) : void
      {
         if(FineBringUpController.getInstance().isMaxLevel(_bringUpItemCell.info as InventoryItemInfo))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.maxLevel"),0,true,1);
         }
         else
         {
            isEatStatus = false;
            FineBringUpController.getInstance().eatAllBtnClick(_bringUpItemCell.info as InventoryItemInfo);
         }
      }
      
      private function onLockBtnClick(param1:MouseEvent) : void
      {
         _bringUpEatBtn.mouseEnabled = false;
         param1.stopImmediatePropagation();
         lockStatusChange();
      }
      
      private function lockStatusChange() : void
      {
         var _loc1_:* = !FineBringUpController.getInstance().usingLock;
         FineBringUpController.getInstance().usingLock = _loc1_;
         _bringUpLockBtn.selected = _loc1_;
         if(FineBringUpController.getInstance().usingLock)
         {
            Mouse.hide();
            StageReferance.stage.addChild(_mouseLockImg);
            _loc1_ = false;
            _mouseLockImg.mouseEnabled = _loc1_;
            _mouseLockImg.mouseChildren = _loc1_;
            _mouseLockImg.x = StageReferance.stage.mouseX - _mouseLockImg.width * 0.5;
            _mouseLockImg.y = StageReferance.stage.mouseY - _mouseLockImg.height * 0.5;
            _mouseLockImg.startDrag(false);
            StageReferance.stage.addEventListener("click",onLockMouseClick);
            _bagList.removeEventListener("itemclick",cellClickHandler);
            _bagList.removeEventListener("doubleclick",__cellDoubleClick);
         }
         else
         {
            _bringUpEatBtn && _loc1_;
            Mouse.show();
            if(_mouseLockImg)
            {
               _mouseLockImg.parent && StageReferance.stage.removeChild(_mouseLockImg);
               _mouseLockImg.stopDrag();
            }
            StageReferance.stage.removeEventListener("click",onLockMouseClick);
            if(_bagList)
            {
               _bagList.addEventListener("itemclick",cellClickHandler,false,0,true);
               _bagList.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
            }
         }
      }
      
      protected function onLockMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:LockableBagCell = param1.target as LockableBagCell;
         if(param1.target is FineBringUpCell)
         {
            lockStatusChange();
         }
         if(_loc2_ && _loc2_.info)
         {
            _loc2_.cellLocked = !_loc2_.cellLocked;
            (_loc2_.info as InventoryItemInfo).cellLocked = _loc2_.cellLocked;
            GameInSocketOut.sendBringUpLockStatusUpdate(_loc2_.bagType,(_loc2_.info as InventoryItemInfo).Place,_loc2_.cellLocked);
         }
         else
         {
            lockStatusChange();
         }
      }
      
      private function createAcceptDragSprite() : void
      {
         _leftDrapSprite = new FineBringUpLeftDragSprite();
         _leftDrapSprite.mouseEnabled = false;
         _leftDrapSprite.mouseChildren = false;
         _leftDrapSprite.graphics.beginFill(0,0);
         _leftDrapSprite.graphics.drawRect(0,0,347,404);
         _leftDrapSprite.graphics.endFill();
         PositionUtils.setPos(_leftDrapSprite,"storeBringUp.dragLeftPos");
         addChild(_leftDrapSprite);
         _rightDrapSprite = new FineBringUpRightDragSprite();
         _rightDrapSprite.mouseEnabled = false;
         _rightDrapSprite.mouseChildren = false;
         _rightDrapSprite.graphics.beginFill(0,0);
         _rightDrapSprite.graphics.drawRect(0,0,374,407);
         _rightDrapSprite.graphics.endFill();
         PositionUtils.setPos(_rightDrapSprite,"storeBringUp.dragRightPos");
         addChild(_rightDrapSprite);
      }
      
      public function refreshBagList() : void
      {
         _listData = FineBringUpController.getInstance().getCanBringUpData();
         _bagList.setData(_listData);
      }
      
      private function cellClickHandler(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:LockableBagCell = param1.data as LockableBagCell;
         _loc2_.dragStart();
      }
      
      protected function __cellDoubleClick(param1:CellEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:String = "";
         _loc2_ = "latentEnergy_equip_move";
         var _loc3_:LatentEnergyEvent = new LatentEnergyEvent(_loc2_);
         var _loc4_:LockableBagCell = param1.data as LockableBagCell;
         _loc4_.cellLocked = false;
         _loc3_.info = _loc4_.info as InventoryItemInfo;
         _loc3_.moveType = 1;
         FineBringUpController.getInstance().dispatchEvent(_loc3_);
      }
      
      private function equipChangeHandler(param1:Event) : void
      {
         if(_bringUpEatAllBtn == null || _bringUpEatBtn == null)
         {
            return;
         }
         if(_bringUpItemCell.info)
         {
            _bringUpEatAllBtn.enable = true;
            _bringUpEatBtn.enable = true;
         }
         else
         {
            _bringUpEatAllBtn.enable = false;
            _bringUpEatBtn.enable = false;
         }
      }
      
      public function dispose() : void
      {
         Mouse.show();
         removeEvent();
         NewHandContainer.Instance.clearArrowByID(144);
         if(_scrollPanel)
         {
            _scrollPanel.vectorListModel.clear();
            ObjectUtils.disposeObject(_scrollPanel);
            _scrollPanel = null;
         }
         BringupScrollCell._bringupContent = null;
         if(_bagList != null)
         {
            ObjectUtils.disposeObject(_bagList);
            _bagList = null;
         }
         if(_bringUpItemCell != null)
         {
            ObjectUtils.disposeObject(_bringUpItemCell);
            _bringUpItemCell = null;
         }
         if(_leftBg != null)
         {
            ObjectUtils.disposeObject(_leftBg);
            _leftBg = null;
         }
         if(_progress != null)
         {
            ObjectUtils.disposeObject(_progress);
            _progress = null;
         }
         if(_progressTxt != null)
         {
            ObjectUtils.disposeObject(_progressTxt);
            _progressTxt = null;
         }
         ObjectUtils.disposeObject(_rightBgView);
         _rightBgView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_mouseLockImg);
         _mouseLockImg = null;
         ObjectUtils.disposeObject(_mouseEatImg);
         _mouseEatImg = null;
         if(_bringUpEatAllBtn != null)
         {
            ObjectUtils.disposeObject(_bringUpEatAllBtn);
            _bringUpEatAllBtn = null;
         }
         if(_bringUpEatBtn != null)
         {
            ObjectUtils.disposeObject(_bringUpEatBtn);
            _bringUpEatBtn = null;
         }
         if(showMoneyBG != null)
         {
            ObjectUtils.disposeObject(showMoneyBG);
            showMoneyBG = null;
         }
         if(medelTxt != null)
         {
            ObjectUtils.disposeObject(medelTxt);
            medelTxt = null;
         }
         if(moneyTxt != null)
         {
            ObjectUtils.disposeObject(moneyTxt);
            moneyTxt = null;
         }
         if(bindMoneyTxt != null)
         {
            ObjectUtils.disposeObject(bindMoneyTxt);
            bindMoneyTxt = null;
         }
         if(_moneyButton != null)
         {
            ObjectUtils.disposeObject(_moneyButton);
            _moneyButton = null;
         }
         if(_bindMoneyButton != null)
         {
            ObjectUtils.disposeObject(_bindMoneyButton);
            _bindMoneyButton = null;
         }
         if(_medelButton != null)
         {
            ObjectUtils.disposeObject(_medelButton);
            _medelButton = null;
         }
         if(_buyExpBtn != null)
         {
            ObjectUtils.disposeObject(_buyExpBtn);
            _buyExpBtn = null;
         }
      }
   }
}
