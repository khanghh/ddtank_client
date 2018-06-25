package consortion.view.selfConsortia{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.TextArea;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.FilterWordManager;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.ByteArray;   import road7th.utils.StringHelper;      public class ConsortionDeclareFrame extends Frame   {                   private var _bg:Scale9CornerImage;            private var _input:TextArea;            private var _ok:TextButton;            private var _cancel:TextButton;            public function ConsortionDeclareFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __addToStageHandler(event:Event) : void { }
            private function __responseHandler(event:FrameEvent) : void { }
            private function __okHandler(e:MouseEvent) : void { }
            private function sendDeclar() : void { }
            private function __cancelHandler(e:MouseEvent) : void { }
            private function __inputChangeHandler(event:Event) : void { }
            override public function dispose() : void { }
   }}