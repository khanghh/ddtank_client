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
      
      public function BaseStoreView(controller:StoreController)
      {
         super();
         _controller = controller;
         _model = _controller.Model;
         init();
         initEvent();
         _soundTimer = new Timer(7500,1);
         _storeview.skipFromWantStrong(_controller.selectedIndex["bag_store"]);
      }
      
      private function init() : void
      {
         var title:Image = ComponentFactory.Instance.creatComponentByStylename("ddt.bagStore.BagStoreFrameTitle");
         var contentBg:DisplayObject = ComponentFactory.Instance.creatCustomObject("ddtstore.BagStoreFrame.ContentBg");
         addChild(contentBg);
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
      
      public function setAutoLinkNum(num:int) : void
      {
         _model.NeedAutoLink = num;
      }
      
      private function refresh(evt:ChoosePanelEvnet) : void
      {
         _model.currentPanel = evt.currentPanle;
         _storeBag.setList(_model);
         _storeBag.changeMsg(_model.currentPanel + 1);
      }
      
      private function __cellDoubleClick(evt:CellEvent) : void
      {
         evt.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            SoundManager.instance.play("008");
            BaglockedManager.Instance.show();
            return;
         }
         var sourceCell:BagCell = evt.data as StoreBagCell;
         var currentPanel:IStoreViewBG = _storeview.currentPanel;
         currentPanel.dragDrop(sourceCell);
      }
      
      private function autoLink(bagType:int, pos:int) : void
      {
         var sourceCell:* = null;
         var currentPanel:IStoreViewBG = _storeview.currentPanel;
         if(bagType == 0)
         {
            sourceCell = _storeBag.getEquipCell(pos);
         }
         else
         {
            sourceCell = _storeBag.getPropCell(pos);
         }
         currentPanel.dragDrop(sourceCell);
      }
      
      private function startShine(evt:StoreDargEvent) : void
      {
         var spnl:* = null;
         var cpnl:* = null;
         var fpnl:* = null;
         var currentPanel:IStoreViewBG = _storeview.currentPanel;
         if(currentPanel is StoreIIStrengthBG)
         {
            spnl = currentPanel as StoreIIStrengthBG;
            if(evt.sourceInfo.CanEquip)
            {
               spnl.startShine(1);
            }
            else if(EquipType.isStrengthStone(evt.sourceInfo))
            {
               spnl.startShine(0);
            }
         }
         else if(currentPanel is StoreIIComposeBG)
         {
            cpnl = currentPanel as StoreIIComposeBG;
            if(evt.sourceInfo.CanEquip)
            {
               cpnl.startShine(1);
            }
            else if(evt.sourceInfo.Property1 == "1")
            {
               cpnl.startShine(2);
            }
            else if(evt.sourceInfo.Property1 == "3")
            {
               cpnl.startShine(0);
            }
         }
         else if(currentPanel is StoreIIFusionBG)
         {
            fpnl = currentPanel as StoreIIFusionBG;
            if(evt.sourceInfo.Property1 == "8")
            {
               fpnl.startShine(0);
            }
            else if(EquipType.isFusion(evt.sourceInfo))
            {
               fpnl.startShine(1);
               fpnl.startShine(2);
               fpnl.startShine(3);
               fpnl.startShine(4);
            }
         }
         else if(currentPanel is StoreEmbedBG)
         {
            if(evt.sourceInfo.CanEquip)
            {
               (currentPanel as StoreEmbedBG).startShine();
            }
            else
            {
               if(evt.sourceInfo.Property1 == "31" && evt.sourceInfo.Property2 == "1")
               {
                  (currentPanel as StoreEmbedBG).stoneStartShine(1,evt.sourceInfo as InventoryItemInfo);
               }
               if(evt.sourceInfo.Property1 == "31" && evt.sourceInfo.Property2 == "2")
               {
                  (currentPanel as StoreEmbedBG).stoneStartShine(2,evt.sourceInfo as InventoryItemInfo);
               }
               if(evt.sourceInfo.Property1 == "31" && evt.sourceInfo.Property2 == "3")
               {
                  (currentPanel as StoreEmbedBG).stoneStartShine(3,evt.sourceInfo as InventoryItemInfo);
               }
            }
            currentPanel = null;
         }
      }
      
      private function stopShine(evt:StoreDargEvent) : void
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
      
      private function __weaponUpgradesPlay(e:Event) : void
      {
         var info:* = null;
         var storeIIStrengthBG:StoreIIStrengthBG = _storeview.StrengthPanel;
         TaskManager.instance.checkHighLight();
         _tip.showStrengthSuccess(storeIIStrengthBG.getStrengthItemCellInfo(),_tipFlag);
         if(_tipFlag)
         {
            info = storeIIStrengthBG.getStrengthItemCellInfo();
            appearHoleTips(info);
            checkHasStrengthLevelThree(info);
         }
      }
      
      private function __showTip(evt:PkgEvent) : void
      {
         _tip.isDisplayerTip = true;
         var success:int = evt.pkg.readByte();
         _tipFlag = evt.pkg.readBoolean();
         var storeIIStrengthBG:StoreIIStrengthBG = _storeview.currentPanel as StoreIIStrengthBG;
         if(success != 0)
         {
            if(success == 1)
            {
               storeIIStrengthBG.starMoviePlay();
            }
            else if(success == 2)
            {
               _tip.showFiveFail();
            }
            else if(success == 3)
            {
               ConsortiaRateManager.instance.reset();
            }
         }
      }
      
      protected function __showExaltTips(event:PkgEvent) : void
      {
         var success:int = event.pkg.readByte();
         var lucky:int = event.pkg.readInt();
         if(success == 0)
         {
            _tip.showSuccess();
            StrengthDataManager.instance.exaltFinish();
         }
         else
         {
            StrengthDataManager.instance.exaltFail(lucky);
         }
      }
      
      private function checkHasStrengthLevelThree(info:InventoryItemInfo) : void
      {
         if(PlayerManager.Instance.Self.Grade < 15 && _model.checkEmbeded() && SharedManager.Instance.hasStrength3[PlayerManager.Instance.Self.ID] == undefined && info.StrengthenLevel == 3)
         {
            SharedManager.Instance.hasStrength3[PlayerManager.Instance.Self.ID] = true;
            SharedManager.Instance.save();
         }
      }
      
      private function __showTipsIII(evt:PkgEvent) : void
      {
         _tip.isDisplayerTip = true;
         var success:int = evt.pkg.readByte();
         if(success == 0)
         {
            var _loc3_:* = evt.type;
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
         else if(success == 1)
         {
            _loc3_ = evt.type;
            if(PkgEvent.format(138) !== _loc3_)
            {
               _tip.showFail();
            }
         }
         else if(success == 3)
         {
            ConsortiaRateManager.instance.reset();
         }
      }
      
      private function __openHoleComplete(evt:PkgEvent) : void
      {
         var embedPannel:* = null;
         _tip.isDisplayerTip = true;
         var success:int = evt.pkg.readByte();
         var isLvUp:Boolean = evt.pkg.readBoolean();
         var hole:int = evt.pkg.readInt();
         if(success == 0)
         {
            embedPannel = _storeview.currentPanel as StoreEmbedBG;
            if(isLvUp)
            {
               SoundManager.instance.pauseMusic();
               SoundManager.instance.play("063",false,false);
               _soundTimer.reset();
               _soundTimer.addEventListener("timerComplete",__soundComplete);
               _soundTimer.start();
               embedPannel.holeLvUp(hole - 1);
            }
         }
         else if(success == 1)
         {
            _tip.showFail();
         }
      }
      
      private function __soundComplete(event:TimerEvent) : void
      {
         _soundTimer.stop();
         _soundTimer.removeEventListener("timerComplete",__soundComplete);
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("063");
         SoundManager.instance.stop("064");
      }
      
      private function __showTipII(evt:CrazyTankSocketEvent) : void
      {
      }
      
      private function appearHoleTips(info:InventoryItemInfo) : void
      {
         SoundManager.instance.play("1001");
      }
      
      private function showHoleTip(info:InventoryItemInfo) : void
      {
         if(info.CategoryID == 1)
         {
            if(info.StrengthenLevel == 3 || info.StrengthenLevel == 9 || info.StrengthenLevel == 12)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.hatOpenProperty"));
            }
            if(info.StrengthenLevel == 6)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.hatOpenDefense"));
            }
         }
         if(info.CategoryID == 5)
         {
            if(info.StrengthenLevel == 3 || info.StrengthenLevel == 9 || info.StrengthenLevel == 12)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.clothOpenProperty"));
            }
            if(info.StrengthenLevel == 6)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.clothOpenDefense"));
            }
         }
         if(info.CategoryID == 7)
         {
            if(info.StrengthenLevel == 3)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.weaponOpenAttack"));
            }
            if(info.StrengthenLevel == 6 || info.StrengthenLevel == 9 || info.StrengthenLevel == 12)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.states.weaponOpenProperty"));
            }
         }
      }
      
      private function assetBtnClickHandler(event:MouseEvent) : void
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
      
      private function embedClickHandler(event:StoreIIEvent) : void
      {
         if(_guideEmbed)
         {
            _guideEmbed.gotoAndStop(6);
         }
      }
      
      private function embedInfoChangeHandler(event:StoreIIEvent) : void
      {
         var alert:* = null;
         if(_guideEmbed)
         {
            _guideEmbed.gotoAndStop(11);
            event.stopImmediatePropagation();
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("store.states.embedTitle"),LanguageMgr.GetTranslation("tank.view.store.matteTips"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,true,2);
            alert.info.showCancel = false;
            alert.moveEnable = false;
            alert.addEventListener("response",_response);
         }
      }
      
      private function _response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",_response);
         if(evt.responseCode == 3 || evt.responseCode == 2 || evt.responseCode == 0 || evt.responseCode == 1 || evt.responseCode == 4)
         {
            okFunction();
         }
         ObjectUtils.disposeObject(evt.target);
      }
      
      private function okFunction() : void
      {
         if(_guideEmbed)
         {
            ObjectUtils.disposeObject(_guideEmbed);
         }
         _guideEmbed = null;
      }
      
      private function _changeConsortia(e:Event) : void
      {
         _consortiaManagerBtn.visible = PlayerManager.Instance.Self.ConsortiaID != 0?true:false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         .super.visible = value;
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
