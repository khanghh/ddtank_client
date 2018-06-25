package baglocked.phone4399{   import baglocked.BagLockedController;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.TextInput;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class ConfirmNum4399Frame extends Frame   {                   private var _bagLockedController:BagLockedController;            private var _description:FilterFrameText;            private var _numInput:TextInput;            private var _countDownTxt:FilterFrameText;            private var _remainTxt:FilterFrameText;            private var _confirmBtn:TextButton;            private var remain:int;            private var _timer:TimerJuggler;            public function ConfirmNum4399Frame() { super(); }
            override protected function init() : void { }
            private function onTimer(event:TimerEvent) : void { }
            protected function onTimerComplete(event:TimerEvent) : void { }
            protected function __confirmBtnClick(event:MouseEvent) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            public function set bagLockedController(value:BagLockedController) : void { }
            public function show() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}