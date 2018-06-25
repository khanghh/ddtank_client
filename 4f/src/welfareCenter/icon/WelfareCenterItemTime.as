package welfareCenter.icon{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.manager.TimeManager;   import flash.events.TimerEvent;   import flash.utils.Timer;   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;      public class WelfareCenterItemTime extends WelfareCenterItem   {                   private var _leftTimeTf:FilterFrameText;            private var _timer:Timer;            private var _firstEnterCdSec:int;            public function WelfareCenterItemTime($type:int) { super(null); }
            override protected function init() : void { }
            private function onTimerTick(evt:TimerEvent) : void { }
            private function updateLeftTimeTf() : void { }
            override public function get canClick() : Boolean { return false; }
            override public function dispose() : void { }
   }}