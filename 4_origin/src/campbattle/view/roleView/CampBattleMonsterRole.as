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
      
      public function CampBattleMonsterRole(playerInfo:RoleData, callBack:Function = null)
      {
         super(playerInfo,callBack);
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
      
      protected function mouseClickHander(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
      }
      
      private function timerHander(e:Event) : void
      {
         if(!scene)
         {
            return;
         }
         var index:int = Math.random() * walkList.length;
         var p:Point = walkList[index];
         walk(p);
      }
      
      override protected function enterFrameHander(e:Event) : void
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
