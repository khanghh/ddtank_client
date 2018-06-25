package roomList{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.manager.IMEManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;      public class LookupRoomFrame extends BaseAlerFrame implements Disposeable   {                   private var _idInputText:TextInput;            private var _passInputText:TextInput;            private var _idText:FilterFrameText;            private var _checkBox:SelectedCheckButton;            public function LookupRoomFrame() { super(); }
            private function initContainer() : void { }
            private function initEvent() : void { }
            private function __onkeyDown(event:KeyboardEvent) : void { }
            private function __addStage(event:Event) : void { }
            private function __frameEvent(event:FrameEvent) : void { }
            protected function submit() : void { }
            protected function hide() : void { }
            private function __checkBoxClick(event:MouseEvent) : void { }
            private function checkEnable() : void { }
            override public function dispose() : void { }
   }}