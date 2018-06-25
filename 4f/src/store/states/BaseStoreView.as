package store.states{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import quest.TaskManager;   import store.IStoreViewBG;   import store.StoreController;   import store.StoreMainView;   import store.StoreTips;   import store.StrengthDataManager;   import store.data.StoreModel;   import store.events.ChoosePanelEvnet;   import store.events.StoreDargEvent;   import store.events.StoreIIEvent;   import store.view.Compose.StoreIIComposeBG;   import store.view.ConsortiaRateManager;   import store.view.embed.StoreEmbedBG;   import store.view.fusion.StoreIIFusionBG;   import store.view.storeBag.StoreBagCell;   import store.view.storeBag.StoreBagController;   import store.view.strength.StoreIIStrengthBG;   import store.view.transfer.StoreIITransferBG;      public class BaseStoreView extends Sprite implements Disposeable   {                   protected var _controller:StoreController;            protected var _model:StoreModel;            public var _storeview:StoreMainView;            protected var _tip:StoreTips;            protected var _storeBag:StoreBagController;            private var _soundTimer:Timer;            protected var _guideEmbed:MovieClip;            private var _consortiaManagerBtn:TextButton;            private var _consortiaBtnEffect:MovieImage;            private var _tipFlag:Boolean;            private var _view:DisplayObject;            public function BaseStoreView(controller:StoreController) { super(); }
            private function init() : void { }
            protected function initEvent() : void { }
            protected function removeEvent() : void { }
            public function setAutoLinkNum(num:int) : void { }
            private function refresh(evt:ChoosePanelEvnet) : void { }
            private function __cellDoubleClick(evt:CellEvent) : void { }
            private function autoLink(bagType:int, pos:int) : void { }
            private function startShine(evt:StoreDargEvent) : void { }
            private function stopShine(evt:StoreDargEvent) : void { }
            private function __weaponUpgradesPlay(e:Event) : void { }
            private function __showTip(evt:PkgEvent) : void { }
            protected function __showExaltTips(event:PkgEvent) : void { }
            private function checkHasStrengthLevelThree(info:InventoryItemInfo) : void { }
            private function __showTipsIII(evt:PkgEvent) : void { }
            private function __openHoleComplete(evt:PkgEvent) : void { }
            private function __soundComplete(event:TimerEvent) : void { }
            private function __showTipII(evt:CrazyTankSocketEvent) : void { }
            private function appearHoleTips(info:InventoryItemInfo) : void { }
            private function showHoleTip(info:InventoryItemInfo) : void { }
            private function assetBtnClickHandler(event:MouseEvent) : void { }
            protected function matteGuideEmbed() : void { }
            private function embedClickHandler(event:StoreIIEvent) : void { }
            private function embedInfoChangeHandler(event:StoreIIEvent) : void { }
            private function _response(evt:FrameEvent) : void { }
            private function okFunction() : void { }
            private function _changeConsortia(e:Event) : void { }
            override public function set visible(value:Boolean) : void { }
            public function dispose() : void { }
   }}