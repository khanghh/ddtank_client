package baglocked.phoneServiceFrames{   import baglocked.BagLockedController;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.MouseEvent;      public class QuestionConfirmFrame extends Frame   {                   private var _bagLockedController:BagLockedController;            private var _bg:ScaleBitmapImage;            private var _question1:FilterFrameText;            private var _answer1:FilterFrameText;            private var _questionTxt1:FilterFrameText;            private var _answerInput1:TextInput;            private var _question2:FilterFrameText;            private var _answer2:FilterFrameText;            private var _questionTxt2:FilterFrameText;            private var _answerInput2:TextInput;            private var _tips:FilterFrameText;            private var _nextBtn:TextButton;            private var _cancelBtn:TextButton;            public function QuestionConfirmFrame() { super(); }
            override protected function init() : void { }
            public function setRestTimes(value:int) : void { }
            protected function __nextBtnClick(event:MouseEvent) : void { }
            protected function __cancelBtnClick(event:MouseEvent) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            public function set bagLockedController(value:BagLockedController) : void { }
            public function show() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}