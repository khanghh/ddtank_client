package church.view.churchFire{   import com.pickgliss.utils.ClassUtils;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class ChurchFireEffectPlayer extends Sprite   {            public static const FIER_TIMER:int = 3500;                   private var _fireTemplateID:int;            private var _fireMovie:MovieClip;            private var _playerFramesCount:int = 0;            private var _playerTimer:TimerJuggler;            public var owerID:int;            public function ChurchFireEffectPlayer(fireTemplateID:int) { super(); }
            private function addFire() : void { }
            public function firePlayer(playSound:Boolean = true) : void { }
            public function removeFire() : void { }
            private function timerHander(evt:Event) : void { }
            private function enterFrameHander(e:Event) : void { }
            public function dispose() : void { }
   }}