package petIsland.model
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import petIsland.event.PetIslandEvent;
   
   public class PetIslandModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean;
      
      private var _pList:Array;
      
      public var infoStr:String = "";
      
      private var _openType:int;
      
      private var _playerBlood:int;
      
      private var _npcBlood:int;
      
      private var _playerScore:int;
      
      private var _npcScore:int;
      
      private var _round:int;
      
      private var _step:int;
      
      private var _currentLevel:int;
      
      private var _rewardRecord:String;
      
      private var _saveLifeCount:int;
      
      private var _saveLife2Count:int;
      
      public function PetIslandModel(target:IEventDispatcher = null)
      {
         _pList = [];
         super();
      }
      
      public function get pList() : Array
      {
         return _pList;
      }
      
      public function set pList(value:Array) : void
      {
         _pList = value;
      }
      
      public function get openType() : int
      {
         return _openType;
      }
      
      public function set openType(value:int) : void
      {
         var i:int = _openType;
         _openType = value;
         if(i != value)
         {
            dispatchEvent(new PetIslandEvent("openType"));
         }
      }
      
      public function get playerBlood() : int
      {
         return _playerBlood;
      }
      
      public function set playerBlood(value:int) : void
      {
         var flag:int = _playerBlood - value;
         _playerBlood = value;
         dispatchEvent(new PetIslandEvent("playerBlood",flag));
      }
      
      public function get npcBlood() : int
      {
         return _npcBlood;
      }
      
      public function set npcBlood(value:int) : void
      {
         var flag:int = _npcBlood - value;
         _npcBlood = value;
         dispatchEvent(new PetIslandEvent("npcBlood",flag));
      }
      
      public function get playerScore() : int
      {
         return _playerScore;
      }
      
      public function set playerScore(value:int) : void
      {
         _playerScore = value;
         dispatchEvent(new PetIslandEvent("playerscore"));
      }
      
      public function get npcScore() : int
      {
         return _npcScore;
      }
      
      public function set npcScore(value:int) : void
      {
         _npcScore = value;
         dispatchEvent(new PetIslandEvent("npcscore"));
      }
      
      public function get round() : int
      {
         return _round;
      }
      
      public function set round(value:int) : void
      {
         _round = value;
         dispatchEvent(new PetIslandEvent("round"));
      }
      
      public function get step() : int
      {
         return _step;
      }
      
      public function set step(value:int) : void
      {
         _step = value;
         dispatchEvent(new PetIslandEvent("step"));
      }
      
      public function get currentLevel() : int
      {
         return _currentLevel;
      }
      
      public function set currentLevel(value:int) : void
      {
         var i:int = _currentLevel;
         _currentLevel = value;
         if(i != value)
         {
            dispatchEvent(new PetIslandEvent("currentLevel",_npcBlood));
         }
      }
      
      public function get rewardRecord() : String
      {
         return _rewardRecord;
      }
      
      public function set rewardRecord(value:String) : void
      {
         var str:String = _rewardRecord;
         _rewardRecord = value;
         if(str != value)
         {
            dispatchEvent(new PetIslandEvent("rewardRecord"));
         }
      }
      
      public function get saveLifeCount() : int
      {
         return _saveLifeCount;
      }
      
      public function set saveLifeCount(value:int) : void
      {
         _saveLifeCount = value;
         dispatchEvent(new PetIslandEvent("useSkill"));
      }
      
      public function get saveLife2Count() : int
      {
         return _saveLife2Count;
      }
      
      public function set saveLife2Count(value:int) : void
      {
         _saveLife2Count = value;
         dispatchEvent(new PetIslandEvent("useSkillTwo"));
      }
   }
}
