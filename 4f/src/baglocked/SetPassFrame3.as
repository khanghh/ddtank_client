package baglocked{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;      public class SetPassFrame3 extends Frame   {                   private var _backBtn1:TextButton;            private var _bagLockedController:BagLockedController;            private var _completeBtn:TextButton;            private var _subtitle:Image;            private var _textInfo3_1:FilterFrameText;            private var _textInfo3_2:FilterFrameText;            private var _textInfo3_3:FilterFrameText;            private var _textInfo3_4:FilterFrameText;            private var _textInfo3_5:FilterFrameText;            private var _textInfo3_6:FilterFrameText;            private var _textInfo3_7:FilterFrameText;            private var _textinput3_1:TextInput;            private var _textinput3_2:TextInput;            private var _titText3_0:FilterFrameText;            public function SetPassFrame3() { super(); }
            public function __onTextEnter(event:KeyboardEvent) : void { }
            public function set bagLockedController(value:BagLockedController) : void { }
            override public function dispose() : void { }
            public function show() : void { }
            override protected function init() : void { }
            private function __backBtn1Click(event:MouseEvent) : void { }
            private function __completeBtnClick(event:MouseEvent) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            private function __textChange(event:Event) : void { }
            private function addEvent() : void { }
            private function remvoeEvent() : void { }
   }}