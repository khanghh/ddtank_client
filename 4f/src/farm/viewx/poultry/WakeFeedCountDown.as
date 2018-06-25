package farm.viewx.poultry{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import farm.FarmModelController;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import flash.utils.getTimer;      public class WakeFeedCountDown extends Sprite implements Disposeable   {                   private var _bg:ScaleBitmapImage;            private var _wakeFeed:ScaleFrameImage;            private var _timeText:FilterFrameText;            private var _cdTime:Number;            private var _feedTimer:Timer;            private var _lastClick:Number = 0;            public function WakeFeedCountDown() { super(); }
            private function initView() : void { }
            private function creatTimer() : void { }
            protected function __onTimer(event:TimerEvent) : void { }
            public function setCountDownTime(countDownTime:Date) : void { }
            private function transSecond(num:Number) : String { return null; }
            protected function __onWakeFeedClick(event:MouseEvent) : void { }
            protected function __onFeedOver(event:PkgEvent) : void { }
            public function setFrame(frameIndex:int) : void { }
            public function set tipData(value:*) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}