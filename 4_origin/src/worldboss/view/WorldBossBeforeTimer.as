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
      
      public function WorldBossBeforeTimer(param1:int)
      {
         super();
         _total = param1;
         initView();
         refreshView(_total);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
      }
      
      private function initView() : void
      {
         _timerMc = ComponentFactory.Instance.creat("asset.worldBoss.beforeTimer");
         _timerMc_1 = _timerMc["timer_1"];
         _timerMc_2 = _timerMc["timer_2"];
         _timerMc_3 = _timerMc["timer_3"];
         _timerMc_4 = _timerMc["timer_4"];
         _timerMc_1.gotoAndStop(10);
         _timerMc_2.gotoAndStop(10);
         _timerMc_3.gotoAndStop(10);
         _timerMc_4.gotoAndStop(10);
         addChild(_timerMc);
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         _total = Number(_total) - 1;
         if(_total <= 0)
         {
            dispatchEvent(new Event("complete"));
            return;
         }
         refreshView(_total);
      }
      
      private function refreshView(param1:int) : void
      {
         var _loc3_:int = param1 / (60000 / 1000);
         var _loc4_:int = _loc3_ / 10;
         _timerMc_1.gotoAndStop(_loc4_ == 0?10:_loc4_);
         var _loc2_:int = _loc3_ % 10;
         _timerMc_2.gotoAndStop(_loc2_ == 0?10:_loc2_);
         var _loc6_:int = param1 % (60000 / 1000);
         var _loc5_:int = _loc6_ / 10;
         _timerMc_3.gotoAndStop(_loc5_ == 0?10:_loc5_);
         var _loc7_:int = _loc6_ % 10;
         _timerMc_4.gotoAndStop(_loc7_ == 0?10:_loc7_);
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",timerHandler);
            _timer.stop();
         }
         _timer = null;
         ObjectUtils.disposeObject(_timerMc);
         _timerMc = null;
         _timerMc_1 = null;
         _timerMc_2 = null;
         _timerMc_3 = null;
         _timerMc_4 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
