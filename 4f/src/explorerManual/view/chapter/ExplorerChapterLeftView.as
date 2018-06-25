package explorerManual.view.chapter{   import baglocked.BaglockedManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.events.BagEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import explorerManual.ExplorerManualController;   import explorerManual.ExplorerManualManager;   import explorerManual.data.ExplorerManualInfo;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import shop.view.BuySingleGoodsView;      public class ExplorerChapterLeftView extends Sprite implements Disposeable   {                   private var _manualIcon:Bitmap;            private var _curPro:ManualPropertyView;            private var _nextPro:ManualPropertyView;            private var _progressBar:ManualPropertyPrgress;            private var _startUpgradeBtn:BaseButton;            private var _autoUpgradeBtn:BaseButton;            private var _materialSelectBtn:SelectedCheckButton;            private var _model:ExplorerManualInfo;            private var _ctrl:ExplorerManualController;            private var _conditionTxt:FilterFrameText;            private var _materialIcon:Bitmap;            private var _materialCount:FilterFrameText;            private var _maxIcon:Bitmap;            private var _clickNum:Number = 0;            private var iconSprite:Sprite;            public function ExplorerChapterLeftView(model:ExplorerManualInfo, ctrl:ExplorerManualController) { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __materialSelectClickHandler(evt:MouseEvent) : void { }
            private function __startUpgradeHandler(evt:MouseEvent) : void { }
            private function __manualUpgradeComplete(evt:Event) : void { }
            private function __autoUpgradeHandler(evt:MouseEvent) : void { }
            private function isCanUpgrade() : Boolean { return false; }
            private function checkCanClick() : Boolean { return false; }
            private function __manualProgressUpdateHandler(evt:Event) : void { }
            private function __manualProUpdateHandler(evt:Event) : void { }
            private function __modelUpdateHandler(evt:Event) : void { }
            private function __manualLevelChangle(evt:Event) : void { }
            private function updateManualConditionDes() : void { }
            private function updateBtn(canClick:Boolean) : void { }
            private function updateManualIcon() : void { }
            private function updateUpgradeMaterial() : void { }
            private function updateMaterialCount() : void { }
            private function get getMaterCountTxt() : String { return null; }
            private function __materialClickHandler(evt:MouseEvent) : void { }
            private function __updateBag(evt:BagEvent) : void { }
            private function updatePro() : void { }
            private function updateProgress() : void { }
            public function dispose() : void { }
   }}