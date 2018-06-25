package ddt.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;      public class LuckeyLotteryDrawIcon extends Sprite implements Disposeable   {                   private var _activityIcon:Bitmap;            private var _leftTimeTf:FilterFrameText;            private var _timer:Timer;            private var _firstEnterCdSec:int;            public function LuckeyLotteryDrawIcon() { super(); }
            private function initView() : void { }
            private function onTimerTick(evt:TimerEvent) : void { }
            private function updateLeftTimeTf() : void { }
            private function initEvent() : void { }
            protected function showFrame(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}