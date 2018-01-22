package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class WorldBossBeforeTimer extends Sprite implements Disposeable
   {
       
      
      private var _timerMc:MovieClip;
      
      private var _timerMc_1:MovieClip;
      
      private var _timerMc_2:MovieClip;
      
      private var _timerMc_3:MovieClip;
      
      private var _timerMc_4:MovieClip;
      
      private var _total:int;
      
      private var _timer:Timer;
      
      public function WorldBossBeforeTimer(param1:int){super();}
      
      private function initView() : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      private function refreshView(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
