package worldBossHelper
{
   import ddt.CoreManager;
   import ddt.data.ServerConfigInfo;
   import ddt.events.CEvent;
   import ddt.manager.ServerConfigManager;
   import invite.InviteManager;
   import worldBossHelper.event.WorldBossHelperEvent;
   
   public class WorldBossHelperManager extends CoreManager
   {
      
      public static const WORLDBOSSHELPER_OPENVIEW:String = "worldBossHelperOpenView";
      
      public static const BOSS_OPEN:String = "wldboss_boss_open";
      
      private static var _instance:WorldBossHelperManager;
       
      
      public var helperOpen:Boolean;
      
      public var isInWorldBossHelperFrame:Boolean;
      
      public var isHelperOnlyOnce:Boolean;
      
      public var isHelperInited:Boolean;
      
      private var _isFightOver:Boolean;
      
      public var isFighting:Boolean;
      
      public var allHonor:int;
      
      public var allMoney:int;
      
      public var allMedal:int;
      
      public var num:int;
      
      public var WorldBossAssistantTimeInfo1:ServerConfigInfo;
      
      public var WorldBossAssistantTimeInfo2:ServerConfigInfo;
      
      public var WorldBossAssistantTimeInfo3:ServerConfigInfo;
      
      public function WorldBossHelperManager(){super();}
      
      public static function get Instance() : WorldBossHelperManager{return null;}
      
      public function setup() : void{}
      
      override protected function start() : void{}
      
      private function initData() : void{}
      
      protected function __bossOpenHandler(param1:WorldBossHelperEvent) : void{}
   }
}
