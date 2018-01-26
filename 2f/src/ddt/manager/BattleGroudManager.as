package ddt.manager
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.utils.AssetModuleLoader;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtActivityIcon.DdtIconTxt;
   import flash.display.MovieClip;
   import flash.utils.getTimer;
   
   public class BattleGroudManager extends CoreManager
   {
      
      public static const BATTLE_OPENVIEW:String = "battleOpenView";
      
      private static var _instance:BattleGroudManager;
       
      
      private var _battleBtn:MovieClip;
      
      private var _lastCreatTime:int;
      
      private var _showModule:String = "";
      
      public var isShow:Boolean;
      
      private var _activityTxt:DdtIconTxt;
      
      public var initBattleIcon:Function;
      
      public var dispBattleIcon:Function;
      
      public function BattleGroudManager(){super();}
      
      public static function get Instance() : BattleGroudManager{return null;}
      
      public function setup() : void{}
      
      public function __onBattleBtnHander() : void{}
      
      private function createBattleRoom() : void{}
      
      private function playAllMc(param1:MovieClip) : void{}
      
      private function stopAllMc(param1:MovieClip) : void{}
      
      public function open(param1:PkgEvent) : void{}
      
      public function over(param1:PkgEvent) : void{}
      
      public function onShow() : void{}
      
      override protected function start() : void{}
   }
}
