package baglocked{   import baglocked.data.BagLockedInfo;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.utils.setTimeout;      public class SetPassFrame1 extends Frame   {                   private var _bagLockedController:BagLockedController;            private var _inputTextInfo1_1:FilterFrameText;            private var _inputTextInfo1_2:FilterFrameText;            private var _inputTextInfo1_3:FilterFrameText;            private var _inputTextInfo1_4:FilterFrameText;            private var _inputTextInfo1_5:FilterFrameText;            private var _nextBtn1:TextButton;            private var _subtitle:Image;            private var _textinput1:TextInput;            private var _textinput2:TextInput;            private var _titText1_0:FilterFrameText;            public function SetPassFrame1() { super(); }
            public function __onTextEnter(event:KeyboardEvent) : void { }
            public function set bagLockedController(value:BagLockedController) : void { }
            override public function dispose() : void { }
            public function show() : void { }
            override protected function init() : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            private function __nextBtn1Click(event:MouseEvent) : void { }
            private function __textChange(event:Event) : void { }
            private function addEvent() : void { }
            private function remvoeEvent() : void { }
   }}