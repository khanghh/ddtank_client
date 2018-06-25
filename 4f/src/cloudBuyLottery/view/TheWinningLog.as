package cloudBuyLottery.view{   import cloudBuyLottery.CloudBuyLotteryManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;      public class TheWinningLog extends Frame   {                   private var SHOP_ITEM_NUM:int;            private var itemList:Array;            private var _list:VBox;            private var _panel:ScrollPanel;            private var _logArr:Array;            private var _bg:Bitmap;            public function TheWinningLog() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function loadList() : void { }
            private function setList(list:Vector.<WinningLogItemInfo>) : void { }
            private function clearitems() : void { }
            private function disposeItems() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}