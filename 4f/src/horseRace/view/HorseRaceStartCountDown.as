package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HorseRaceStartCountDown extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _func:Function;
      
      public function HorseRaceStartCountDown(param1:int, param2:String = "begin", param3:Function = null){super();}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      private function refreshMc() : void{}
      
      public function dispose() : void{}
   }
}
