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
      
      public function LabyrinthModel(target:IEventDispatcher = null)
      {
         _cleanOutInfos = new DictionaryData();
         super(target);
      }
      
      public function get myRanking() : int
      {
         return _myRanking;
      }
      
      public function set myRanking(value:int) : void
      {
         _myRanking = value;
      }
      
      public function get myProgress() : int
      {
         return _myProgress;
      }
      
      public function set myProgress(value:int) : void
      {
         _myProgress = value;
      }
      
      public function get completeChallenge() : Boolean
      {
         return _completeChallenge;
      }
      
      public function set completeChallenge(value:Boolean) : void
      {
         _completeChallenge = value;
      }
      
      public function getMaxLevel() : int
      {
         var level:int = 0;
         switch(int(_sType))
         {
            case 0:
               level = ServerConfigManager.instance.getWarriorHighFamMaxLevel();
               break;
            case 1:
               level = ServerConfigManager.instance.getMagicHighFamMaxLevel();
         }
         return level;
      }
      
      public function get isDoubleAward() : Boolean
      {
         return getDouble;
      }
      
      public function set isDoubleAward(value:Boolean) : void
      {
         _isDoubleAward = value;
      }
      
      public function getIsDoubleAwardFromServer() : Boolean
      {
         return _isDoubleAward;
      }
      
      public function useDoubleAward(selected:Boolean) : void
      {
         _isSelectedDoubleChange = true;
         switch(int(_sType))
         {
            case 0:
               _doubleWarrior = selected;
               break;
            case 1:
               _doubleMagic = selected;
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
      
      public function set rankingList(value:Array) : void
      {
         _rankingList = value;
      }
      
      public function get currentFloor() : int
      {
         return _currentFloor;
      }
      
      public function set currentFloor(value:int) : void
      {
         _currentFloor = value;
      }
      
      public function get accumulateExp() : int
      {
         return _accumulateExp;
      }
      
      public function set accumulateExp(value:int) : void
      {
         _accumulateExp = value;
      }
      
      public function get cleanOutInfos() : DictionaryData
      {
         return _cleanOutInfos;
      }
      
      public function set cleanOutInfos(value:DictionaryData) : void
      {
         _cleanOutInfos = value;
      }
      
      public function get remainTime() : int
      {
         return _remainTime;
      }
      
      public function set remainTime(value:int) : void
      {
         _remainTime = value;
      }
      
      public function get cleanOutAllTime() : int
      {
         return _cleanOutAllTime;
      }
      
      public function set cleanOutAllTime(value:int) : void
      {
         _cleanOutAllTime = value;
      }
      
      public function get cleanOutGold() : int
      {
         return _cleanOutGold;
      }
      
      public function set cleanOutGold(value:int) : void
      {
         _cleanOutGold = value;
      }
      
      public function get currentRemainTime() : int
      {
         return _currentRemainTime;
      }
      
      public function set currentRemainTime(value:int) : void
      {
         _currentRemainTime = value;
      }
      
      public function get tryAgainComplete() : Boolean
      {
         return _tryAgainComplete;
      }
      
      public function set tryAgainComplete(value:Boolean) : void
      {
         _tryAgainComplete = value;
      }
      
      public function get isInGame() : Boolean
      {
         return _isInGame;
      }
      
      public function set isInGame(value:Boolean) : void
      {
         _isInGame = value;
      }
      
      public function get isCleanOut() : Boolean
      {
         return _isCleanOut;
      }
      
      public function set isCleanOut(value:Boolean) : void
      {
         _isCleanOut = value;
      }
      
      public function get serverMultiplyingPower() : Boolean
      {
         return _serverMultiplyingPower;
      }
      
      public function set serverMultiplyingPower(value:Boolean) : void
      {
         _serverMultiplyingPower = value;
      }
      
      public function get nightmareProgress() : int
      {
         return _nightmareProgress;
      }
      
      public function set nightmareProgress(value:int) : void
      {
         _nightmareProgress = value;
      }
      
      public function get sType() : int
      {
         return _sType;
      }
      
      public function set sType(value:int) : void
      {
         _sType = value;
      }
   }
}
