package campbattle.view.roleView{   import campbattle.data.RoleData;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class CampBattleMonsterRole extends CampBattlePlayer   {                   private var walkList:Vector.<Point>;            private var _timer:TimerJuggler;            public function CampBattleMonsterRole(playerInfo:RoleData, callBack:Function = null) { super(null,null); }
            protected function mouseClickHander(e:MouseEvent) : void { }
            private function timerHander(e:Event) : void { }
            override protected function enterFrameHander(e:Event) : void { }
            override public function dispose() : void { }
   }}