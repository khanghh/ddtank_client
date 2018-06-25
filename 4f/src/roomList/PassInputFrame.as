package roomList{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.events.Event;   import flash.events.KeyboardEvent;      public class PassInputFrame extends BaseAlerFrame implements Disposeable   {                   private var _passInputText:TextInput;            private var _explainText:FilterFrameText;            private var _ID:int;            public function PassInputFrame() { super(); }
            private function initContainer() : void { }
            private function initEvent() : void { }
            private function __KeyDown(event:KeyboardEvent) : void { }
            private function __addStage(event:Event) : void { }
            private function __frameEvent(event:FrameEvent) : void { }
            private function submit() : void { }
            public function get ID() : int { return 0; }
            public function set ID(value:int) : void { }
            private function hide() : void { }
            private function __input(e:Event) : void { }
            override public function dispose() : void { }
   }}