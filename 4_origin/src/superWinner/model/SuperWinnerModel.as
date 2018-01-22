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
      
      public function SuperWinnerModel()
      {
         _awardArr = [];
         _myAwardArr = [];
         super();
         _playerlist = new DictionaryData(true);
         _self = PlayerManager.Instance.Self;
      }
      
      public function setRoomInfo(param1:PackageIn) : void
      {
         formatPlayerList(param1);
         formatAwards(param1);
         formatMyAwards(param1);
         flushChampion(param1);
         _endDate = param1.readDate();
         _roomId = param1.readInt();
      }
      
      public function formatPlayerList(param1:PackageIn) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         playerNum = param1.readByte();
         _loc3_ = uint(0);
         while(_loc3_ < playerNum)
         {
            _loc2_ = new SuperWinnerPlayerInfo();
            _loc2_.ID = param1.readInt();
            _loc2_.NickName = param1.readUTF();
            _loc2_.IsVIP = param1.readBoolean();
            _loc2_.Sex = param1.readBoolean();
            _loc2_.IsOnline = param1.readBoolean();
            _loc2_.Grade = param1.readByte();
            _playerlist.add(_loc2_.ID,_loc2_);
            _loc3_++;
         }
         dispatchEvent(new SuperWinnerEvent("init_players"));
      }
      
      public function formatAwards(param1:PackageIn) : void
      {
         var _loc3_:* = 0;
         var _loc2_:Array = [];
         _loc3_ = uint(0);
         while(_loc3_ < 6)
         {
            _loc2_.push(param1.readByte());
            _loc3_++;
         }
         awards = _loc2_;
         dispatchEvent(new SuperWinnerEvent("flush_awards"));
      }
      
      public function sendGetAwardsMsg(param1:PackageIn) : void
      {
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = 0;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:int = param1.readByte();
         _loc8_ = 0;
         while(_loc8_ < _loc2_)
         {
            _loc4_ = param1.readUTF();
            _loc6_ = uint(param1.readByte());
            if(_loc6_ != 6)
            {
               _loc7_ = getAwardNameByLevel(_loc6_);
               _loc3_ = LanguageMgr.GetTranslation("ddt.superWinner.someoneGetAward",_loc4_,_loc7_);
               _loc5_ = new SuperWinnerEvent("notice");
               _loc5_.resultData = _loc3_;
               dispatchEvent(_loc5_);
            }
            _loc8_++;
         }
      }
      
      public function getAwardNameByLevel(param1:int) : String
      {
         return AWARDSNAME[param1 - 1];
      }
      
      public function formatMyAwards(param1:PackageIn) : void
      {
         var _loc2_:* = 0;
         var _loc3_:Array = [];
         _loc2_ = uint(0);
         while(_loc2_ < 6)
         {
            _loc3_.push(param1.readByte());
            _loc2_++;
         }
         myAwards = _loc3_;
         dispatchEvent(new SuperWinnerEvent("flush_my_awards"));
      }
      
      public function flushChampion(param1:PackageIn, param2:Boolean = false) : void
      {
         var _loc3_:* = null;
         var _loc6_:Boolean = false;
         var _loc4_:* = undefined;
         var _loc7_:int = 0;
         var _loc5_:int = param1.readInt();
         _showMsg = param2;
         if(_loc5_ == 0)
         {
            return;
         }
         _loc6_ = false;
         _loc4_ = new Vector.<int>(6);
         if(championItem)
         {
            _loc6_ = true;
         }
         setChampionItem(_loc5_);
         _loc7_ = 0;
         while(_loc7_ < 6)
         {
            _loc4_[_loc7_] = param1.readByte();
            _loc7_++;
         }
         championDices = _loc4_;
         _loc3_ = new SuperWinnerEvent("champion_change");
         _loc3_.resultData = _loc6_;
         dispatchEvent(_loc3_);
      }
      
      public function get isShowChampionMsg() : Boolean
      {
         return _showMsg;
      }
      
      public function joinRoom(param1:PackageIn) : void
      {
         var _loc2_:SuperWinnerPlayerInfo = new SuperWinnerPlayerInfo();
         _loc2_.ID = param1.readInt();
         _loc2_.NickName = param1.readUTF();
         _loc2_.IsVIP = param1.readBoolean();
         _loc2_.Sex = param1.readBoolean();
         _loc2_.IsOnline = param1.readBoolean();
         _loc2_.Grade = param1.readByte();
         _playerlist.add(_loc2_.ID,_loc2_);
      }
      
      public function set lastDicePoints(param1:Vector.<int>) : void
      {
         _lastDicePoints = param1;
      }
      
      public function get lastDicePoints() : Vector.<int>
      {
         return _lastDicePoints;
      }
      
      public function set currentDicePoints(param1:Vector.<int>) : void
      {
         _currentDicePoints = param1;
      }
      
      public function get currentDicePoints() : Vector.<int>
      {
         return _currentDicePoints;
      }
      
      public function set isCurrentDiceGetAward(param1:Boolean) : void
      {
         _isCurrentDiceGetAward = param1;
      }
      
      public function get isCurrentDiceGetAward() : Boolean
      {
         return _isCurrentDiceGetAward;
      }
      
      public function set currentAwardLevel(param1:uint) : void
      {
         _currentAwardLevel = param1;
      }
      
      public function get currentAwardLevel() : uint
      {
         return _currentAwardLevel;
      }
      
      public function getPlayerList() : DictionaryData
      {
         return _playerlist;
      }
      
      public function getSelfPlayerInfo() : PlayerInfo
      {
         return _self;
      }
      
      public function set playerNum(param1:uint) : void
      {
         _playerNum = param1;
      }
      
      public function get playerNum() : uint
      {
         return _playerNum;
      }
      
      public function set awards(param1:Array) : void
      {
         _awardArr = param1;
      }
      
      public function get awards() : Array
      {
         return _awardArr;
      }
      
      public function set myAwards(param1:Array) : void
      {
         _myAwardArr = param1;
      }
      
      public function get myAwards() : Array
      {
         return _myAwardArr;
      }
      
      public function set championDices(param1:Vector.<int>) : void
      {
         _championDices = param1;
      }
      
      public function get championDices() : Vector.<int>
      {
         return _championDices;
      }
      
      public function setChampionItem(param1:int) : void
      {
         _championInfo = getPlayerList()[param1];
      }
      
      public function get championItem() : SuperWinnerPlayerInfo
      {
         return _championInfo;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get endData() : Date
      {
         return _endDate;
      }
      
      public function get awardsVector() : Vector.<SuperWinnerAwardsMode>
      {
         return _awardsVector;
      }
      
      public function set awardsVector(param1:Vector.<SuperWinnerAwardsMode>) : void
      {
         _awardsVector = param1;
      }
   }
}
