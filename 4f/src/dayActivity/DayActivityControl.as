package dayActivity{   import campbattle.CampBattleManager;   import catchbeast.CatchBeastManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import consortionBattle.ConsortiaBattleManager;   import dayActivity.items.DayActivieListItem;   import dayActivity.view.DayActivityView;   import ddt.events.PkgEvent;   import ddt.manager.BattleGroudManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import entertainmentMode.EntertainmentModeManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import horseRace.controller.HorseRaceManager;   import lanternriddles.LanternRiddlesManager;   import league.LeagueManager;   import rescue.RescueManager;   import sevenDouble.SevenDoubleManager;   import worldboss.WorldBossManager;      public class DayActivityControl extends EventDispatcher   {            private static var _instance:DayActivityControl;                   private var _activityFrame:ActivityFrame;            public function DayActivityControl(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : DayActivityControl { return null; }
            public function setup() : void { }
            private function initEvent() : void { }
            public function changGoodsBtn(e:PkgEvent) : void { }
            public function addActivityChange(e:PkgEvent) : void { }
            public function send(i:int, id:int) : void { }
            private function updataNum(id:int, count:int) : void { }
            public function addSpeedResp(e:PkgEvent) : void { }
            private function addOverList(bool:Boolean, type:int, count:int = 0) : void { }
            private function checkOverList(type:int) : Boolean { return false; }
            public function initSingleActivity(e:PkgEvent) : void { }
            protected function createActivityFrame(event:Event) : void { }
            public function initActivityStata(_list:Vector.<DayActivieListItem>) : void { }
            private function updateActivityData(str:String, _list:Vector.<DayActivieListItem>, bool:Boolean) : void { }
            public function dispose() : void { }
   }}