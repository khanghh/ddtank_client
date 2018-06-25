package bagAndInfo.bag{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.MouseEvent;   import road7th.data.DictionaryData;      public class OpenBatchView extends BaseAlerFrame   {                   private var _item:InventoryItemInfo;            private var _txt:FilterFrameText;            private var _inputBg:Bitmap;            private var _inputText:FilterFrameText;            private var _maxBtn:SimpleBitmapButton;            public function OpenBatchView() { super(); }
            public function set item(value:InventoryItemInfo) : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function changeMaxHandler(event:MouseEvent) : void { }
            private function inputTextChangeHandler(event:Event) : void { }
            private function getOpenMaxCount() : int { return 0; }
            private function responseHandler(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}