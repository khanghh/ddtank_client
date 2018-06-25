package church.view.weddingRoomList.frame{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.data.ChurchRoomInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.KeyboardEvent;      public class WeddingRoomEnterInputPasswordView extends BaseAlerFrame   {                   private var _churchRoomInfo:ChurchRoomInfo;            private var _alertInfo:AlertInfo;            private var _passwordLabel:FilterFrameText;            private var _txtPassword:TextInput;            public function WeddingRoomEnterInputPasswordView() { super(); }
            protected function initialize() : void { }
            public function set churchRoomInfo(value:ChurchRoomInfo) : void { }
            private function setView() : void { }
            private function removeView() : void { }
            private function setEvent() : void { }
            private function removeEvent() : void { }
            private function onKeyDown(evt:KeyboardEvent) : void { }
            private function onTxtPasswordChange(evt:Event) : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            private function enterRoomConfirm() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}