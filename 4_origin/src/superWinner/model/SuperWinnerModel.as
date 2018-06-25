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
      
      public function setRoomInfo(pkg:PackageIn) : void
      {
         formatPlayerList(pkg);
         formatAwards(pkg);
         formatMyAwards(pkg);
         flushChampion(pkg);
         _endDate = pkg.readDate();
         _roomId = pkg.readInt();
      }
      
      public function formatPlayerList(pkg:PackageIn) : void
      {
         var i:* = 0;
         var info:* = null;
         playerNum = pkg.readByte();
         for(i = uint(0); i < playerNum; )
         {
            info = new SuperWinnerPlayerInfo();
            info.ID = pkg.readInt();
            info.NickName = pkg.readUTF();
            info.IsVIP = pkg.readBoolean();
            info.Sex = pkg.readBoolean();
            info.IsOnline = pkg.readBoolean();
            info.Grade = pkg.readByte();
            _playerlist.add(info.ID,info);
            i++;
         }
         dispatchEvent(new SuperWinnerEvent("init_players"));
      }
      
      public function formatAwards(pkg:PackageIn) : void
      {
         var ii:* = 0;
         var arr:Array = [];
         for(ii = uint(0); ii < 6; )
         {
            arr.push(pkg.readByte());
            ii++;
         }
         awards = arr;
         dispatchEvent(new SuperWinnerEvent("flush_awards"));
      }
      
      public function sendGetAwardsMsg(pkg:PackageIn) : void
      {
         var i:int = 0;
         var playerName:* = null;
         var lv:* = 0;
         var awardName:* = null;
         var str:* = null;
         var evt:* = null;
         var getAwardsNum:int = pkg.readByte();
         for(i = 0; i < getAwardsNum; )
         {
            playerName = pkg.readUTF();
            lv = uint(pkg.readByte());
            if(lv != 6)
            {
               awardName = getAwardNameByLevel(lv);
               str = LanguageMgr.GetTranslation("ddt.superWinner.someoneGetAward",playerName,awardName);
               evt = new SuperWinnerEvent("notice");
               evt.resultData = str;
               dispatchEvent(evt);
            }
            i++;
         }
      }
      
      public function getAwardNameByLevel(lv:int) : String
      {
         return AWARDSNAME[lv - 1];
      }
      
      public function formatMyAwards(pkg:PackageIn) : void
      {
         var iii:* = 0;
         var arr1:Array = [];
         for(iii = uint(0); iii < 6; )
         {
            arr1.push(pkg.readByte());
            iii++;
         }
         myAwards = arr1;
         dispatchEvent(new SuperWinnerEvent("flush_my_awards"));
      }
      
      public function flushChampion(pkg:PackageIn, showMsg:Boolean = false) : void
      {
         var evt:* = null;
         var hadChampion:Boolean = false;
         var vt:* = undefined;
         var i:int = 0;
         var championId:int = pkg.readInt();
         _showMsg = showMsg;
         if(championId == 0)
         {
            return;
         }
         hadChampion = false;
         vt = new Vector.<int>(6);
         if(championItem)
         {
            hadChampion = true;
         }
         setChampionItem(championId);
         for(i = 0; i < 6; )
         {
            vt[i] = pkg.readByte();
            i++;
         }
         championDices = vt;
         evt = new SuperWinnerEvent("champion_change");
         evt.resultData = hadChampion;
         dispatchEvent(evt);
      }
      
      public function get isShowChampionMsg() : Boolean
      {
         return _showMsg;
      }
      
      public function joinRoom(pkg:PackageIn) : void
      {
         var info:SuperWinnerPlayerInfo = new SuperWinnerPlayerInfo();
         info.ID = pkg.readInt();
         info.NickName = pkg.readUTF();
         info.IsVIP = pkg.readBoolean();
         info.Sex = pkg.readBoolean();
         info.IsOnline = pkg.readBoolean();
         info.Grade = pkg.readByte();
         _playerlist.add(info.ID,info);
      }
      
      public function set lastDicePoints(val:Vector.<int>) : void
      {
         _lastDicePoints = val;
      }
      
      public function get lastDicePoints() : Vector.<int>
      {
         return _lastDicePoints;
      }
      
      public function set currentDicePoints(val:Vector.<int>) : void
      {
         _currentDicePoints = val;
      }
      
      public function get currentDicePoints() : Vector.<int>
      {
         return _currentDicePoints;
      }
      
      public function set isCurrentDiceGetAward(val:Boolean) : void
      {
         _isCurrentDiceGetAward = val;
      }
      
      public function get isCurrentDiceGetAward() : Boolean
      {
         return _isCurrentDiceGetAward;
      }
      
      public function set currentAwardLevel(val:uint) : void
      {
         _currentAwardLevel = val;
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
      
      public function set playerNum($count:uint) : void
      {
         _playerNum = $count;
      }
      
      public function get playerNum() : uint
      {
         return _playerNum;
      }
      
      public function set awards(arr:Array) : void
      {
         _awardArr = arr;
      }
      
      public function get awards() : Array
      {
         return _awardArr;
      }
      
      public function set myAwards(arr:Array) : void
      {
         _myAwardArr = arr;
      }
      
      public function get myAwards() : Array
      {
         return _myAwardArr;
      }
      
      public function set championDices(val:Vector.<int>) : void
      {
         _championDices = val;
      }
      
      public function get championDices() : Vector.<int>
      {
         return _championDices;
      }
      
      public function setChampionItem(val:int) : void
      {
         _championInfo = getPlayerList()[val];
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
      
      public function set awardsVector(val:Vector.<SuperWinnerAwardsMode>) : void
      {
         _awardsVector = val;
      }
   }
}
