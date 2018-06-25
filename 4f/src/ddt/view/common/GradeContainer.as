package ddt.view.common{   import com.pickgliss.utils.ClassUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class GradeContainer extends Sprite   {                   private var _timer:TimerJuggler;            private var _grade:MovieClip;            private var _topLayer:Boolean;            public function GradeContainer(topLayer:Boolean = false) { super(); }
            private function init() : void { }
            private function __timerComplete(evt:Event) : void { }
            public function clearGrade() : void { }
            public function setGrade(grade:MovieClip) : void { }
            public function playerGrade() : void { }
            public function dispose() : void { }
   }}