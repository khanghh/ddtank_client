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
      
      public function CampBattleMonsterRole(param1:RoleData, param2:Function = null){super(null,null);}
      
      protected function mouseClickHander(param1:MouseEvent) : void{}
      
      private function timerHander(param1:Event) : void{}
      
      override protected function enterFrameHander(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
