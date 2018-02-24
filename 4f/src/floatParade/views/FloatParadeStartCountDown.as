package floatParade.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class FloatParadeStartCountDown extends Sprite implements Disposeable
   {
       
      
      private var _mc:MovieClip;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _func:Function;
      
      private var _funcParams:Array;
      
      public function FloatParadeStartCountDown(param1:Function, param2:Array){super();}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      private function refreshMc() : void{}
      
      public function dispose() : void{}
   }
}
