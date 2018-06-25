package baglocked{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.BagEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.utils.setTimeout;      public class BagLockedGetFrame extends Frame   {                   private var _bagLockedController:BagLockedController;            private var _certainBtn:TextButton;            private var _deselectBtn:TextButton;            private var _forgetPwdBtn:TextButton;            private var _text4_0:FilterFrameText;            private var _text4_1:FilterFrameText;            private var _textInput4:TextInput;            public function BagLockedGetFrame() { super(); }
            public function __onTextEnter(event:KeyboardEvent) : void { }
            public function set bagLockedController(value:BagLockedController) : void { }
            override public function dispose() : void { }
            public function show() : void { }
            override protected function __onAddToStage(event:Event) : void { }
            private function getFocus() : void { }
            private function __getFocus(event:KeyboardEvent) : void { }
            override protected function init() : void { }
            private function __certainBtnClick(event:MouseEvent) : void { }
            private function __deselectBtnClick(event:MouseEvent) : void { }
            private function __clearSuccessHandler(event:BagEvent) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            private function __textChange(event:Event) : void { }
            protected function __forgetPwdBtnClick(event:MouseEvent) : void { }
            private function addEvent() : void { }
            private function remvoeEvent() : void { }
   }}