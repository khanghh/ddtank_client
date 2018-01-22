package ddt.view.common
{
   import com.pickgliss.utils.ClassUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class GradeContainer extends Sprite
   {
       
      
      private var _timer:TimerJuggler;
      
      private var _grade:MovieClip;
      
      private var _topLayer:Boolean;
      
      public function GradeContainer(param1:Boolean = false){super();}
      
      private function init() : void{}
      
      private function __timerComplete(param1:Event) : void{}
      
      public function clearGrade() : void{}
      
      public function setGrade(param1:MovieClip) : void{}
      
      public function playerGrade() : void{}
      
      public function dispose() : void{}
   }
}
