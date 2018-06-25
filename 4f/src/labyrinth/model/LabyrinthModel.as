package labyrinth.model{   import ddt.manager.ServerConfigManager;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.data.DictionaryData;      public class LabyrinthModel extends EventDispatcher   {                   private var _myProgress:int;            private var _nightmareProgress:int;            private var _myRanking:int;            private var _completeChallenge:Boolean;            private var _isDoubleAward:Boolean = true;            private var _rankingList:Array;            private var _currentFloor:int;            private var _accumulateExp:int;            private var _cleanOutInfos:DictionaryData;            private var _remainTime:int;            private var _currentRemainTime:int;            private var _cleanOutAllTime:int;            private var _cleanOutGold:int;            private var _tryAgainComplete:Boolean;            private var _isInGame:Boolean;            private var _isCleanOut:Boolean;            private var _serverMultiplyingPower:Boolean;            private var _sType:int;            private var _isSelectedDoubleChange:Boolean = false;            private var _doubleMagic:Boolean = true;            private var _doubleWarrior:Boolean = true;            public function LabyrinthModel(target:IEventDispatcher = null) { super(null); }
            public function get myRanking() : int { return 0; }
            public function set myRanking(value:int) : void { }
            public function get myProgress() : int { return 0; }
            public function set myProgress(value:int) : void { }
            public function get completeChallenge() : Boolean { return false; }
            public function set completeChallenge(value:Boolean) : void { }
            public function getMaxLevel() : int { return 0; }
            public function get isDoubleAward() : Boolean { return false; }
            public function set isDoubleAward(value:Boolean) : void { }
            public function getIsDoubleAwardFromServer() : Boolean { return false; }
            public function useDoubleAward(selected:Boolean) : void { }
            private function get getDouble() : Boolean { return false; }
            public function get rankingList() : Array { return null; }
            public function set rankingList(value:Array) : void { }
            public function get currentFloor() : int { return 0; }
            public function set currentFloor(value:int) : void { }
            public function get accumulateExp() : int { return 0; }
            public function set accumulateExp(value:int) : void { }
            public function get cleanOutInfos() : DictionaryData { return null; }
            public function set cleanOutInfos(value:DictionaryData) : void { }
            public function get remainTime() : int { return 0; }
            public function set remainTime(value:int) : void { }
            public function get cleanOutAllTime() : int { return 0; }
            public function set cleanOutAllTime(value:int) : void { }
            public function get cleanOutGold() : int { return 0; }
            public function set cleanOutGold(value:int) : void { }
            public function get currentRemainTime() : int { return 0; }
            public function set currentRemainTime(value:int) : void { }
            public function get tryAgainComplete() : Boolean { return false; }
            public function set tryAgainComplete(value:Boolean) : void { }
            public function get isInGame() : Boolean { return false; }
            public function set isInGame(value:Boolean) : void { }
            public function get isCleanOut() : Boolean { return false; }
            public function set isCleanOut(value:Boolean) : void { }
            public function get serverMultiplyingPower() : Boolean { return false; }
            public function set serverMultiplyingPower(value:Boolean) : void { }
            public function get nightmareProgress() : int { return 0; }
            public function set nightmareProgress(value:int) : void { }
            public function get sType() : int { return 0; }
            public function set sType(value:int) : void { }
   }}