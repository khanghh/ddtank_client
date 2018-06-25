package levelFund.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import levelFund.LevelFundManager;   import levelFund.event.LevelFundEvent;      public class LevelFundView extends Sprite implements Disposeable   {                   private var _panel:ScrollPanel;            private var _itemsSprite:Sprite;            private var _items:Array;            private var _buyLevelTxt:FilterFrameText;            private var _buyFundBtn1:BaseButton;            private var _buyFundBtn2:BaseButton;            private var _buyFundBtn3:BaseButton;            private var _buyCompleteIcon:Bitmap;            private var _buyType:int = 0;            private var _buyPrice:int = 0;            public function LevelFundView() { super(); }
            private function initView() : void { }
            private function setBuyCompleteState(type:int = 0) : void { }
            private function addItems() : void { }
            private function updateItems(buyMultiple:int) : void { }
            private function initEvent() : void { }
            private function __buyFundBtnClickHandler(event:MouseEvent) : void { }
            private function showBuyTipFrame(buyType:int) : void { }
            private function confirmResponse(e:FrameEvent) : void { }
            protected function onCheckComplete() : void { }
            private function __buyFundBtnOverHandler(event:MouseEvent) : void { }
            private function __buyFundBtnOutHandler(event:MouseEvent) : void { }
            private function __updateViewHandler(event:LevelFundEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}