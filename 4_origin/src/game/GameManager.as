package game
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class GameManager extends EventDispatcher
   {
      
      public static const START_LOAD:String = "StartLoading";
      
      public static var exploreOver:Boolean;
      
      public static var MinLevelDuplicate:int = 10;
      
      public static var GAME_CAN_NOT_EXIT_SEND_LOG:int;
      
      public static var MinLevelActivity:int = 25;
      
      public static const CAMP_BATTLE_MODEL_PVE:int = 24;
      
      public static const CAMP_BATTLE_MODEL_PVP:int = 23;
      
      public static const RING_STATION_MODEL:int = 26;
      
      public static const CATCH_BEAST_MODEL:int = 28;
      
      public static const BOMB_KING_FIRST_MODEL:int = 28;
      
      public static const BOMB_KING_FINAL_MODEL:int = 29;
      
      public static const FARM_BOSS_MODEL:int = 50;
      
      public static const CHRISTMAS_MODEL:int = 40;
      
      public static const CRYPTBOSS_MODEL:int = 41;
      
      public static const RESCUE_MODEL:int = 31;
      
      public static const CATCH_INSECT_MODEL:int = 52;
      
      public static const TREASURELOST:int = 55;
      
      public static const POLARREGION:int = 68;
      
      public static const SURVIVALMODE:int = 121;
      
      private static var _instance:GameManager;
       
      
      public var isPlaying:Boolean;
      
      public var isStopFocus:Boolean = false;
      
      public function GameManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : GameManager
      {
         if(!_instance)
         {
            _instance = new GameManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
      }
   }
}
