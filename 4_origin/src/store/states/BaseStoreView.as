package store.states
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import quest.TaskManager;
   import store.IStoreViewBG;
   import store.StoreController;
   import store.StoreMainView;
   import store.StoreTips;
   import store.StrengthDataManager;
   import store.data.StoreModel;
   import store.events.ChoosePanelEvnet;
   import store.events.StoreDargEvent;
   import store.events.StoreIIEvent;
   import store.view.Compose.StoreIIComposeBG;
   import store.view.ConsortiaRateManager;
   import store.view.embed.StoreEmbedBG;
   import store.view.fusion.StoreIIFusionBG;
   import store.view.storeBag.StoreBagCell;
   import store.view.storeBag.StoreBagController;
   import store.view.strength.StoreIIStrengthBG;
   import store.view.transfer.StoreIITransferBG;
   
   public class BaseStoreView extends Sprite implements Disposeable
   {
       
      
      protected var _controller:StoreController;
      
      protected var _model:StoreModel;
      
      public var _storeview:StoreMainView;
      
      protected var _tip:StoreTips;
      
      protected var _storeBag:StoreBagController;
      
      private var _soundTimer:Timer;
      
      protected var _guideEmbed:MovieClip;
      
      private var _consortiaManagerBtn:TextButton;
      
      private var _consortiaBtnEffect:MovieImage;
      
      private var _tipFlag:Boolean;
      
      private var _view:DisplayObject;
      
      public function BaseStoreView(param1:StoreController)
      {
         super();
         _controller = param1;
         _model = _controller.Model;
         init();
         initEvent();
         _soundTimer = new Timer(7500,1);
         _storeview.skipFromWantStrong(_controller.selectedIndex["bag_store"]);
      }
      
      private function init() : void
      {
         var _loc1_:Image = ComponentFactory.Instance.creatComponentByStylename("ddt.bagStore.BagStoreFrameTitle");
         var _loc2_:DisplayObject = ComponentFactory.Instance.creatCustomObject("ddtstore.BagStoreFrame.ContentBg");
         addChild(_loc2_);
         _consortiaManagerBtn = ComponentFactory.Instance.creat("ddtstore.BagStoreFrame.GuildManagerBtn");
         _consortiaManagerBtn.text = LanguageMgr.GetTranslation("store.view.GuildManagerText");
         addChild(_consortiaManagerBtn);
         _consortiaManagerBtn.visible = false;
         _storeview = ComponentFactory.Instance.creat("ddtstore.MainView");
         addChild(_storeview);
         _storeBag = new StoreBagController(_model);
         _view = _storeBag.getView(StoreModel.STORE_BAG);
         addChild(_view);
         _tip = ComponentFactory.Instance.creat("ddtstore.storeTip");
         addChild(_tip);
      }
      
      protected function initEvent() : void
      {
         _consortiaManagerBtn.addEventListener("click",assetBtnClickHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(58),__showTipsIII);
         SocketManager.Instance.addEventListener(PkgEvent.format(59),__showTip);
         SocketManager.Instance.addEventListener(PkgEvent.format(61),__showTipsIII);
         SocketManager.Instance.addEventListener(PkgEvent.format(138),__showExaltTips);
         SocketManager.Instance.addEventListener(PkgEvent.format(210),__showTipsIII);
         SocketManager.Instance.addEventListener("itemEmbed",__showTipsIII);
         SocketManager.Instance.addEventListener(PkgEvent.format(217),__openHoleComplete);
         _view.addEventListener("doubleclick",__cellDoubleClick);
         _view.addEventListener("startDarg",startShine);
         _view.addEventListener("stopDarg",stopShine);
         _storeview.addEventListener("ChoosePanelEvent",refresh);
         _storeview.addEventListener("embedClick",embedClickHandler);
         _storeview.addEventListener("embedInfoChange",embedInfoChangeHandler);
         ConsortiaRateManager.instance.addEventListener("loadComplete_consortia",_changeConsortia);
         _storeview.StrengthPanel.addEventListener("weaponUpgradesPlay",__weaponUpgradesPlay);
      }
      
      protected function removeEvent() : void
      {
         _soundTimer.stop();
         _soundTimer.removeEventListener("timerComplete",__soundComplete);
         _consortiaManagerBtn.removeEventListener("click",assetBtnClickHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(58),__showTipsIII);
         SocketManager.Instance.removeEventListener(PkgEvent.format(59),__showTip);
         SocketManager.Instance.removeEventListener(PkgEvent.format(138),__showExaltTips);
         SocketManager.Instance.removeEventListener(PkgEvent.format(61),__showTipsIII);
         SocketManager.Instance.removeEventListener(PkgEvent.format(210),__showTipsIII);
         SocketManager.Instance.removeEventListener("itemEmbed",__showTipsIII);
         SocketManager.Instance.removeEventListener(PkgEvent.format(217),__openHoleComplete);
         _view.removeEventListener("doubleclick",__cellDoubleClick);
         _view.removeEventListener("startDarg",startShine);
         _view.removeEventListener("stopDarg",stopShine);
         _storeview.removeEventListener("ChoosePanelEvent",refresh);
         _storeview.removeEventListener("embedClick",embedClickHandler);
         _storeview.removeEventListener("embedInfoChange",embedInfoChangeHandler);
         ConsortiaRateManager.instance.removeEventListener("loadComplete_consortia",_changeConsortia);
         _storeview.StrengthPanel.removeEventListener("weaponUpgradesPlay",__weaponUpgradesPlay);
      }
      
      public function setAutoLinkNum(param1:int) : void
      {
         _model.NeedAutoLink = param1;
      }
      
      private function refresh(param1:ChoosePanelEvnet) : void
      {
         _model.currentPanel = param1.currentPanle;
         _storeBag.setList(_model);
         _storeBag.changeMsg(_model.currentPanel + 1);
      }
      
      private function __cellDoubleClick(param1:CellEvent) : void
      {
         param1.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            SoundManager.instance.play("008");
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:BagCell = param1.data as StoreBagCell;
         var _loc2_:IStoreViewBG = _storeview.currentPanel;
         _loc2_.dragDrop(_loc3_);
      }
      
      private function autoLink(param1:int, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc3_:IStoreViewBG = _storeview.currentPanel;
         if(param1 == 0)
         {
            _loc4_ = _storeBag.getEquipCell(param2);
         }
         else
         {
            _loc4_ = _storeBag.getPropCell(param2);
         }
         _loc3_.dragDrop(_loc4_);
      }
      
      private function startShine(param1:StoreDargEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:IStoreViewBG = _storeview.currentPanel;
         if(_loc3_ is StoreIIStrengthBG)
         {
            _loc4_ = _loc3_ as StoreIIStrengthBG;
            if(param1.sourceInfo.CanEquip)
            {
               _loc4_.startShine(1);
            }
            else if(EquipType.isStrengthStone(param1.sourceInfo))
            {
               _loc4_.startShine(0);
            }
         }
         else if(_loc3_ is StoreIIComposeBG)
         {
            _loc2_ = _loc3_ as StoreIIComposeBG;
            if(param1.sourceInfo.CanEquip)
            {
               _loc2_.startShine(1);
            }
            else if(param1.sourceInfo.Property1 == "1")
            {
               _loc2_.startShine(2);
            }
            else if(param1.sourceInfo.Property1 == "3")
            {
               _loc2_.startShine(0);
            }
         }
         else if(_loc3_ is StoreIIFusionBG)
         {
            _loc5_ = _loc3_ as StoreIIFusionBG;
            if(param1.sourceInfo.Property1 == "8")
            {
               _loc5_.startShine(0);
            }
            else if(EquipType.isFusion(param1.sourceInfo))
            {
               _loc5_.startShine(1);
               _loc5_.startShine(2);
               _loc5_.startShine(3);
               _loc5_.startShine(4);
            }
         }
         else if(_loc3_ is StoreEmbedBG)
         {
            if(param1.sourceInfo.CanEquip)
            {
               (_loc3_ as StoreEmbedBG).startShine();
            }
            else
            {
               if(param1.sourceInfo.Property1 == "31" && param1.sourceInfo.Property2 == "1")
               {
                  (_loc3_ as StoreEmbedBG).stoneStartShine(1,param1.sourceInfo as InventoryItemInfo);
               }
               if(param1.sourceInfo.Property1 == "31" && param1.sourceInfo.Property2 == "2")
               {
                  (_loc3_ as StoreEmbedBG).stoneStartShine(2,param1.sourceInfo as InventoryItemInfo);
               }
               if(param1.sourceInfo.Property1 == "31" && param1.sourceInfo.Property2 == "3")
               {
                  (_loc3_ as StoreEmbedBG).stoneStartShine(3,param1.sourceInfo as InventoryItemInfo);
               }
            }
            _loc3_ = null;
         }
      }
      
      private function stopShine(param1:StoreDargEvent) : void
      {
         if(_storeview.currentPanel is StoreIIStrengthBG)
         {
            (_storeview.currentPanel as StoreIIStrengthBG).stopShine();
         }
         else if(_storeview.currentPanel is StoreIIComposeBG)
         {
            (_storeview.currentPanel as StoreIIComposeBG).stopShine();
         }
         else if(_storeview.currentPanel is StoreIIFusionBG)
         {
            (_storeview.currentPanel as StoreIIFusionBG).stopShine();
         }
         else if(_storeview.currentPanel is StoreIITransferBG)
         {
            (_storeview.currentPanel as StoreIITransferBG).stopShine();
         }
         else if(_storeview.currentPanel is StoreEmbedBG)
         {
            (_storeview.currentPanel as StoreEmbedBG).stopShine();
         }
      }
      
      private function __weaponUpgradesPlay(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:StoreIIStrengthBG = _storeview.StrengthPanel;
         TaskManager.instance.checkHighLight();
         _tip.showStrengthSuccess(_loc2_.getStrengthItemCellInfo(),_tipFlag);
         if(_tipFlag)
         {
            _loc3_ = _loc2_.getStrengthItemCellInfo();
            appearHoleTips(_loc3_);
            checkHasStrengthLevelThree(_loc3_);
         }
      }
      
      private function __showTip(param1:PkgEvent) : void
      {
         _tip.isDisplayerTip = true;
         var _loc3_:int = param1.pkg.readByte();
         _tipFlag = param1.pkg.readBoolean();
         var _loc2_:StoreIIStrengthBG = _storeview.currentPanel as StoreIIStrengthBG;
         if(_loc3_ != 0)
         {
            if(_loc3_ == 1)
            {
               _loc2_.starMoviePlay();
            }
            else if(_loc3_ == 2)
            {
               _tip.showFiveFail();
            }
            else if(_loc3_ == 3)
            {
               ConsortiaRateManager.instance.reset();
            }
         }
      }
      
      protected function __showExaltTips(param1:PkgEvent) : void
      {
         var _loc3_:int = param1.pkg.readByte();
         var _loc2_:int = param1.pkg.readInt();
         if(_loc3_ == 0)
         {
            _tip.showSuccess();
            StrengthDataManager.instance.exaltFinish();
         }
         else
         {
            StrengthDataManager.instance.exaltFail(_loc2_);
         }
      }
      
      private function checkHasStrengthLevelThree(param1:InventoryItemInfo) : void
      {
         if(PlayerManager.Instance.Self.Grade < 15 && _model.checkEmbeded() && SharedManager.Instance.hasStrength3[PlayerManager.Instance.Self.ID] == undefined && param1.StrengthenLevel == 3)
         {
            SharedManager.Instance.hasStrength3[PlayerManager.Instance.Self.ID] = true;
            SharedManager.Instance.save();
         }
      }
      
      private function __showTipsIII(param1:PkgEvent) : void
      {
         _tip.isDisplayerTip = true;
         var _loc2_:int = param1.pkg.readByte();
         if(_loc2_ == 0)
         {
            var _loc3_:* = param1.type;
            if(PkgEvent.format(61) !== _loc3_)
            {
               if("itemEmbed" !== _loc3_)
               {
                  _tip.showSuccess();
               }
               else
               {
                  _tip.showSuccess(1);
               }
            }
            else
            {
               _tip.showSuccess(0);
               if(_storeview.currentPanel is StoreIITransferBG)
               {
                  (_storeview.currentPanel as StoreIITransferBG).clearTransferItemCell();
               }
            }
         }
         else if(_loc2_ == 1)
         {
            _loc3_ = param1.type;
            if(PkgEvent.format(138) !== _loc3_)
            {
               _tip.showFail();
            }
         }
         else if(_loc2_ == 3)
         {
            ConsortiaRateManager.instance.reset();
         }
      }
      
      private function __openHoleComplete(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         _tip.isDisplayerTip = true;
         var _loc4_:int = param1.pkg.readByte();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc5_:int = param1.pkg.readInt();
         if(_loc4_ == 0)
         {
            _loc2_ = _storeview.currentPanel as StoreEmbedBG;
            if(_loc3_)
            {
               SoundManager.instance.pauseMusic();
               SoundManager.instance.play("063",false,false);
               _soundTimer.reset();
               _soundTimer.addEventListener("timerComplete",__soundComplete);
               _soundTimer.start();
               _loc2_.holeLvUp(_loc5_ - 1);
            }
         }
         else if(_loc4_ == 1)
         {
            _tip.showFail();
         }
      }
      
      private function __soundComplete(param1:TimerEvent) : void
      {
         _soundTimer.stop();
         _soundTimer.removeEventListener("timerComplete",__soundComplete);
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("063");
         SoundManager.instance.stop("064");
      }
      
      private function __showTipII(param1:CrazyTankSocketEvent) : void
      {
      }
      
      private function appearHoleTips(param1:InventoryItemInfo) : void
      {
         SoundManager.instance.play("1001");
      }
      
      private function showHoleTip(param1:InventoryItemInfo) : void
      {
         if(param1.CategoryID == 1)
         {
            if(param1.StrengthenLevel == 3 || param1.StrengthenLevel == 9 || param1.StrengthenLevel == 12)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.hatOpenProperty"));
            }
            if(param1.StrengthenLevel == 6)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.hatOpenDefense"));
            }
         }
         if(param1.CategoryID == 5)
         {
            if(param1.StrengthenLevel == 3 || param1.StrengthenLevel == 9 || param1.StrengthenLevel == 12)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.clothOpenProperty"));
            }
            if(param1.StrengthenLevel == 6)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.clothOpenDefense"));
            }
         }
         if(param1.CategoryID == 7)
         {
            if(param1.StrengthenLevel == 3)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.weaponOpenAttack"));
            }
            if(param1.StrengthenLevel == 6 || param1.StrengthenLevel == 9 || param1.StrengthenLevel == 12)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.weaponOpenProperty"));
            }
         }
      }
      
      private function assetBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ConsortionModelManager.Instance.alertManagerFrame();
      }
      
      protected function matteGuideEmbed() : void
      {
         _guideEmbed = ComponentFactory.Instance.creat("asset.ddtstore.TutorialStepAsset");
         _guideEmbed.gotoAndStop(1);
         LayerManager.Instance.addToLayer(_guideEmbed,2);
      }
      
      private function embedClickHandler(param1:StoreIIEvent) : void
      {
         if(_guideEmbed)
         {
            _guideEmbed.gotoAndStop(6);
         }
      }
      
      private function embedInfoChangeHandler(param1:StoreIIEvent) : void
      {
         var _loc2_:* = null;
         if(_guideEmbed)
         {
            _guideEmbed.gotoAndStop(11);
            param1.stopImmediatePropagation();
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("store.states.embedTitle"),LanguageMgr.GetTranslation("tank.view.store.matteTips"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,true,2);
            _loc2_.info.showCancel = false;
            _loc2_.moveEnable = false;
            _loc2_.addEventListener("response",_response);
         }
      }
      
      private function _response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2 || param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            okFunction();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function okFunction() : void
      {
         if(_guideEmbed)
         {
            ObjectUtils.disposeObject(_guideEmbed);
         }
         _guideEmbed = null;
      }
      
      private function _changeConsortia(param1:Event) : void
      {
         _consortiaManagerBtn.visible = PlayerManager.Instance.Self.ConsortiaID != 0?true:false;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         .super.visible = param1;
         if(_storeview)
         {
            if(visible)
            {
               _storeview.refreshCurrentPanel();
            }
            else
            {
               _storeview.deleteSomeDataTemp();
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _soundTimer = null;
         if(_storeview)
         {
            ObjectUtils.disposeObject(_storeview);
         }
         _storeview = null;
         if(_tip)
         {
            ObjectUtils.disposeObject(_tip);
         }
         _tip = null;
         if(_consortiaManagerBtn)
         {
            ObjectUtils.disposeObject(_consortiaManagerBtn);
         }
         _consortiaManagerBtn = null;
         if(_consortiaBtnEffect)
         {
            ObjectUtils.disposeObject(_consortiaBtnEffect);
         }
         _consortiaBtnEffect = null;
         if(_guideEmbed)
         {
            ObjectUtils.disposeObject(_guideEmbed);
         }
         _guideEmbed = null;
         if(_storeBag)
         {
            ObjectUtils.disposeObject(_storeBag);
         }
         _storeBag = null;
         _controller = null;
         _model.currentPanel = 0;
         _model = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
