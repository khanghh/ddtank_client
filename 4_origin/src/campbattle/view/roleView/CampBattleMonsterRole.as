package campbattle.view.roleView
{
   import campbattle.data.RoleData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CampBattleMonsterRole extends CampBattlePlayer
   {
       
      
      private var walkList:Vector.<Point>;
      
      private var _timer:TimerJuggler;
      
      public function CampBattleMonsterRole(param1:RoleData, param2:Function = null)
      {
         super(param1,param2);
         walkList = new Vector.<Point>();
         walkList.push(new Point(993,901));
         walkList.push(new Point(1208,866));
         walkList.push(new Point(1124,644));
         walkList.push(new Point(1107,803));
         walkList.push(new Point(879,896));
         _timer = TimerManager.getInstance().addTimerJuggler(4000);
         _timer.addEventListener("timer",timerHander);
         _timer.start();
         addEventListener("enterFrame",enterFrameHander);
      }
      
      protected function mouseClickHander(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function timerHander(param1:Event) : void
      {
         if(!scene)
         {
            return;
         }
         var _loc2_:int = Math.random() * walkList.length;
         var _loc3_:Point = walkList[_loc2_];
         walk(_loc3_);
      }
      
      override protected function enterFrameHander(param1:Event) : void
      {
         update();
         playerWalkPath();
         characterMirror();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_timer != null)
         {
            _timer.stop();
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
      }
   }
}
