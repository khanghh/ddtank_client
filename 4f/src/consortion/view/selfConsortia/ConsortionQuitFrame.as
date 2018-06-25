package consortion.view.selfConsortia{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;      public class ConsortionQuitFrame extends Frame   {                   private var _bg:MutipleImage;            private var _explain:FilterFrameText;            private var _input:TextInput;            private var _ok:TextButton;            private var _cancel:TextButton;            private var _quitWord:FilterFrameText;            public function ConsortionQuitFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __responseHandler(event:FrameEvent) : void { }
            private function __addToStageHandler(event:Event) : void { }
            private function __clickHandler(event:MouseEvent) : void { }
            private function quit() : void { }
            private function __cancelHandler(event:MouseEvent) : void { }
            private function __inputChangeHandler(event:Event) : void { }
            private function __keyDownHandler(evt:KeyboardEvent) : void { }
            override public function dispose() : void { }
   }}