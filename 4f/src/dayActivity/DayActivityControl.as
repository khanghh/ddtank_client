package dayActivity
{
   import campbattle.CampBattleManager;
   import catchbeast.CatchBeastManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortionBattle.ConsortiaBattleManager;
   import dayActivity.items.DayActivieListItem;
   import dayActivity.view.DayActivityView;
   import ddt.events.PkgEvent;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import entertainmentMode.EntertainmentModeManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import horseRace.controller.HorseRaceManager;
   import lanternriddles.LanternRiddlesManager;
   import league.LeagueManager;
   import rescue.RescueManager;
   import sevenDouble.SevenDoubleManager;
   import worldboss.WorldBossManager;
   
   public class DayActivityControl extends EventDispatcher
   {
      
      private static var _instance:DayActivityControl;
       
      
      private var _activityFrame:ActivityFrame;
      
      public function DayActivityControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : DayActivityControl{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      public function changGoodsBtn(param1:PkgEvent) : void{}
      
      public function addActivityChange(param1:PkgEvent) : void{}
      
      public function send(param1:int, param2:int) : void{}
      
      private function updataNum(param1:int, param2:int) : void{}
      
      public function addSpeedResp(param1:PkgEvent) : void{}
      
      private function addOverList(param1:Boolean, param2:int, param3:int = 0) : void{}
      
      private function checkOverList(param1:int) : Boolean{return false;}
      
      public function initSingleActivity(param1:PkgEvent) : void{}
      
      protected function createActivityFrame(param1:Event) : void{}
      
      public function initActivityStata(param1:Vector.<DayActivieListItem>) : void{}
      
      private function updateActivityData(param1:String, param2:Vector.<DayActivieListItem>, param3:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
