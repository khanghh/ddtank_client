package baglocked.phoneServiceFrames{   import baglocked.BagLockedController;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.MouseEvent;      public class DeleteInputFrame extends Frame   {                   private var _bagLockedController:BagLockedController;            private var _BG:ScaleBitmapImage;            private var _description:FilterFrameText;            private var _inputTxt:FilterFrameText;            private var _phoneInput:TextInput;            private var _tips:FilterFrameText;            private var _nextBtn:TextButton;            private var type:int;            public function DeleteInputFrame() { super(); }
            public function init2(value:int) : void { }
            protected function __nextBtnClick(event:MouseEvent) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            public function set bagLockedController(value:BagLockedController) : void { }
            public function show() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}