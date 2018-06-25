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
      
      public function GradeContainer(topLayer:Boolean = false)
      {
         super();
         _topLayer = topLayer;
         init();
      }
      
      private function init() : void
      {
         _timer = TimerManager.getInstance().addTimerJuggler(6000,1);
         _timer.addEventListener("timerComplete",__timerComplete);
      }
      
      private function __timerComplete(evt:Event) : void
      {
         clearGrade();
      }
      
      public function clearGrade() : void
      {
         if(_grade != null)
         {
            if(_grade.parent)
            {
               _grade.stop();
               _grade["lv_mc"]["lv_mc_init"]["video"].clear();
               _grade.parent.removeChild(_grade);
            }
            _grade = null;
         }
         if(_timer)
         {
            _timer.stop();
         }
      }
      
      public function setGrade(grade:MovieClip) : void
      {
         clearGrade();
         _grade = grade;
         if(_grade != null)
         {
            _timer.reset();
            _timer.start();
            addChild(_grade);
         }
      }
      
      public function playerGrade() : void
      {
         var mvClass:Class = ClassUtils.uiSourceDomain.getDefinition("asset.core.playerLevelUpFaileAsset") as Class;
         var mv:MovieClip = new mvClass() as MovieClip;
         setGrade(mv);
      }
      
      public function dispose() : void
      {
         _timer.removeEventListener("timerComplete",__timerComplete);
         TimerManager.getInstance().removeJugglerByTimer(_timer);
         _timer = null;
         clearGrade();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
