package superWinner.model
{
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import superWinner.data.SuperWinnerAwardsMode;
   import superWinner.data.SuperWinnerPlayerInfo;
   import superWinner.event.SuperWinnerEvent;
   
   public class SuperWinnerModel extends EventDispatcher
   {
       
      
      private const AWARDSNAME:Array = [LanguageMgr.GetTranslation("ddt.superWinner.award1"),LanguageMgr.GetTranslation("ddt.superWinner.award2"),LanguageMgr.GetTranslation("ddt.superWinner.award3"),LanguageMgr.GetTranslation("ddt.superWinner.award4"),LanguageMgr.GetTranslation("ddt.superWinner.award5"),LanguageMgr.GetTranslation("ddt.superWinner.award6")];
      
      private var _playerlist:DictionaryData;
      
      private var _self:PlayerInfo;
      
      private var _playerNum:uint;
      
      private var _awardArr:Array;
      
      private var _myAwardArr:Array;
      
      private var _isCurrentDiceGetAward:Boolean = false;
      
      private var _currentAwardLevel:uint;
      
      private var _currentDicePoints:Vector.<int>;
      
      private var _lastDicePoints:Vector.<int>;
      
      private var _championDices:Vector.<int>;
      
      private var _championInfo:SuperWinnerPlayerInfo;
      
      private var _roomId:int;
      
      private var _showMsg:Boolean;
      
      private var _endDate:Date;
      
      private var _awardsVector:Vector.<SuperWinnerAwardsMode>;
      
      public function SuperWinnerModel(){super();}
      
      public function setRoomInfo(param1:PackageIn) : void{}
      
      public function formatPlayerList(param1:PackageIn) : void{}
      
      public function formatAwards(param1:PackageIn) : void{}
      
      public function sendGetAwardsMsg(param1:PackageIn) : void{}
      
      public function getAwardNameByLevel(param1:int) : String{return null;}
      
      public function formatMyAwards(param1:PackageIn) : void{}
      
      public function flushChampion(param1:PackageIn, param2:Boolean = false) : void{}
      
      public function get isShowChampionMsg() : Boolean{return false;}
      
      public function joinRoom(param1:PackageIn) : void{}
      
      public function set lastDicePoints(param1:Vector.<int>) : void{}
      
      public function get lastDicePoints() : Vector.<int>{return null;}
      
      public function set currentDicePoints(param1:Vector.<int>) : void{}
      
      public function get currentDicePoints() : Vector.<int>{return null;}
      
      public function set isCurrentDiceGetAward(param1:Boolean) : void{}
      
      public function get isCurrentDiceGetAward() : Boolean{return false;}
      
      public function set currentAwardLevel(param1:uint) : void{}
      
      public function get currentAwardLevel() : uint{return null;}
      
      public function getPlayerList() : DictionaryData{return null;}
      
      public function getSelfPlayerInfo() : PlayerInfo{return null;}
      
      public function set playerNum(param1:uint) : void{}
      
      public function get playerNum() : uint{return null;}
      
      public function set awards(param1:Array) : void{}
      
      public function get awards() : Array{return null;}
      
      public function set myAwards(param1:Array) : void{}
      
      public function get myAwards() : Array{return null;}
      
      public function set championDices(param1:Vector.<int>) : void{}
      
      public function get championDices() : Vector.<int>{return null;}
      
      public function setChampionItem(param1:int) : void{}
      
      public function get championItem() : SuperWinnerPlayerInfo{return null;}
      
      public function get roomId() : int{return 0;}
      
      public function get endData() : Date{return null;}
      
      public function get awardsVector() : Vector.<SuperWinnerAwardsMode>{return null;}
      
      public function set awardsVector(param1:Vector.<SuperWinnerAwardsMode>) : void{}
   }
}
