package ddt.view.common.church{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.view.DoubleSelectedItem;   import flash.events.Event;      public class ChurchBuyRingFrame extends BaseAlerFrame   {                   private var _text1:FilterFrameText;            private var _text2:FilterFrameText;            private var _text3:FilterFrameText;            private var _ringInfo:ShopItemInfo;            private var _alertInfo:AlertInfo;            private var _spouseID:int;            private var _proposeStr:String;            private var _useBugle:Boolean;            private var _selectItem:DoubleSelectedItem;            public function ChurchBuyRingFrame() { super(); }
            public function get useBugle() : Boolean { return false; }
            public function set useBugle(value:Boolean) : void { }
            public function get proposeStr() : String { return null; }
            public function set proposeStr(value:String) : void { }
            public function get spouseID() : int { return 0; }
            public function set spouseID(value:int) : void { }
            private function initialize() : void { }
            private function confirmSubmit() : void { }
            protected function onCheckComplete() : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}