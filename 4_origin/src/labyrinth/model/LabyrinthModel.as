package labyrinth.model
{
   import ddt.manager.ServerConfigManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   
   public class LabyrinthModel extends EventDispatcher
   {
       
      
      private var _myProgress:int;
      
      private var _nightmareProgress:int;
      
      private var _myRanking:int;
      
      private var _completeChallenge:Boolean;
      
      private var _isDoubleAward:Boolean = true;
      
      private var _rankingList:Array;
      
      private var _currentFloor:int;
      
      private var _accumulateExp:int;
      
      private var _cleanOutInfos:DictionaryData;
      
      private var _remainTime:int;
      
      private var _currentRemainTime:int;
      
      private var _cleanOutAllTime:int;
      
      private var _cleanOutGold:int;
      
      private var _tryAgainComplete:Boolean;
      
      private var _isInGame:Boolean;
      
      private var _isCleanOut:Boolean;
      
      private var _serverMultiplyingPower:Boolean;
      
      private var _sType:int;
      
      private var _isSelectedDoubleChange:Boolean = false;
      
      private var _doubleMagic:Boolean = true;
      
      private var _doubleWarrior:Boolean = true;
      
      public function LabyrinthModel(param1:IEventDispatcher = null)
      {
         _cleanOutInfos = new DictionaryData();
         super(param1);
      }
      
      public function get myRanking() : int
      {
         return _myRanking;
      }
      
      public function set myRanking(param1:int) : void
      {
         _myRanking = param1;
      }
      
      public function get myProgress() : int
      {
         return _myProgress;
      }
      
      public function set myProgress(param1:int) : void
      {
         _myProgress = param1;
      }
      
      public function get completeChallenge() : Boolean
      {
         return _completeChallenge;
      }
      
      public function set completeChallenge(param1:Boolean) : void
      {
         _completeChallenge = param1;
      }
      
      public function getMaxLevel() : int
      {
         var _loc1_:int = 0;
         switch(int(_sType))
         {
            case 0:
               _loc1_ = ServerConfigManager.instance.getWarriorHighFamMaxLevel();
               break;
            case 1:
               _loc1_ = ServerConfigManager.instance.getMagicHighFamMaxLevel();
         }
         return _loc1_;
      }
      
      public function get isDoubleAward() : Boolean
      {
         return getDouble;
      }
      
      public function set isDoubleAward(param1:Boolean) : void
      {
         _isDoubleAward = param1;
      }
      
      public function getIsDoubleAwardFromServer() : Boolean
      {
         return _isDoubleAward;
      }
      
      public function useDoubleAward(param1:Boolean) : void
      {
         _isSelectedDoubleChange = true;
         switch(int(_sType))
         {
            case 0:
               _doubleWarrior = param1;
               break;
            case 1:
               _doubleMagic = param1;
         }
      }
      
      private function get getDouble() : Boolean
      {
         switch(int(_sType))
         {
            case 0:
               return _doubleWarrior;
            case 1:
               return _doubleMagic;
         }
      }
      
      public function get rankingList() : Array
      {
         return _rankingList;
      }
      
      public function set rankingList(param1:Array) : void
      {
         _rankingList = param1;
      }
      
      public function get currentFloor() : int
      {
         return _currentFloor;
      }
      
      public function set currentFloor(param1:int) : void
      {
         _currentFloor = param1;
      }
      
      public function get accumulateExp() : int
      {
         return _accumulateExp;
      }
      
      public function set accumulateExp(param1:int) : void
      {
         _accumulateExp = param1;
      }
      
      public function get cleanOutInfos() : DictionaryData
      {
         return _cleanOutInfos;
      }
      
      public function set cleanOutInfos(param1:DictionaryData) : void
      {
         _cleanOutInfos = param1;
      }
      
      public function get remainTime() : int
      {
         return _remainTime;
      }
      
      public function set remainTime(param1:int) : void
      {
         _remainTime = param1;
      }
      
      public function get cleanOutAllTime() : int
      {
         return _cleanOutAllTime;
      }
      
      public function set cleanOutAllTime(param1:int) : void
      {
         _cleanOutAllTime = param1;
      }
      
      public function get cleanOutGold() : int
      {
         return _cleanOutGold;
      }
      
      public function set cleanOutGold(param1:int) : void
      {
         _cleanOutGold = param1;
      }
      
      public function get currentRemainTime() : int
      {
         return _currentRemainTime;
      }
      
      public function set currentRemainTime(param1:int) : void
      {
         _currentRemainTime = param1;
      }
      
      public function get tryAgainComplete() : Boolean
      {
         return _tryAgainComplete;
      }
      
      public function set tryAgainComplete(param1:Boolean) : void
      {
         _tryAgainComplete = param1;
      }
      
      public function get isInGame() : Boolean
      {
         return _isInGame;
      }
      
      public function set isInGame(param1:Boolean) : void
      {
         _isInGame = param1;
      }
      
      public function get isCleanOut() : Boolean
      {
         return _isCleanOut;
      }
      
      public function set isCleanOut(param1:Boolean) : void
      {
         _isCleanOut = param1;
      }
      
      public function get serverMultiplyingPower() : Boolean
      {
         return _serverMultiplyingPower;
      }
      
      public function set serverMultiplyingPower(param1:Boolean) : void
      {
         _serverMultiplyingPower = param1;
      }
      
      public function get nightmareProgress() : int
      {
         return _nightmareProgress;
      }
      
      public function set nightmareProgress(param1:int) : void
      {
         _nightmareProgress = param1;
      }
      
      public function get sType() : int
      {
         return _sType;
      }
      
      public function set sType(param1:int) : void
      {
         _sType = param1;
      }
   }
}
