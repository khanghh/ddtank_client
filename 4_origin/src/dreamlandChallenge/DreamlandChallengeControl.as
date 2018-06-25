package dreamlandChallenge
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import dreamlandChallenge.view.logicView.DCMainView;
   import flash.events.Event;
   import room.RoomManager;
   
   public class DreamlandChallengeControl
   {
      
      private static var _instance:DreamlandChallengeControl;
       
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _difficultyForLev:Array;
      
      private var _sendRoomSet:Boolean = false;
      
      private var _mainFrame:DCMainView;
      
      private var _clickNum:Number = 0;
      
      public function DreamlandChallengeControl()
      {
         super();
      }
      
      public static function get instance() : DreamlandChallengeControl
      {
         if(!_instance)
         {
            _instance = new DreamlandChallengeControl();
         }
         return _instance;
      }
      
      public function get difficultyForLev() : Array
      {
         return _difficultyForLev;
      }
      
      public function set difficultyForLev(value:Array) : void
      {
         _difficultyForLev = value;
      }
      
      public function setup() : void
      {
         DreamlandChallengeManager.instance.addEventListener(DreamlandChallengeManager.OPEN_VIEW,__openViewHandler);
         DreamlandChallengeManager.instance.addEventListener(DreamlandChallengeManager.ACTIVE_STATECHANGE,__activeStateChangeHandler);
      }
      
      private function __openViewHandler(evt:CEvent) : void
      {
         _mainFrame = new DCMainView(this);
         _mainFrame.show();
         getViewData();
      }
      
      public function getDupInfoById(index:int) : DungeonInfo
      {
         return MapManager.getDreamLandDupInfoById(index);
      }
      
      public function getAwardsByDiffcultyType(type:int) : Array
      {
         return DreamlandChallengeManager.instance.getAwardsByDiffcultyType(type);
      }
      
      public function startChallenge(difficulty:int, info:DungeonInfo) : void
      {
         if(difficulty < 0)
         {
            MessageTipManager.getInstance().show("未选择副本难度!");
            return;
         }
         if(!checkLevMeet(difficulty))
         {
            cannotChallengeAlert(difficulty);
         }
         else
         {
            sendStart(info.ID,difficulty,info.Type);
         }
      }
      
      public function checkLevMeet(difficulty:int) : Boolean
      {
         var levs:Object = getLevByDifficlty(difficulty);
         var selfLev:int = PlayerManager.Instance.Self.Grade;
         if(selfLev >= levs.minLev && selfLev <= levs.maxLev)
         {
            return true;
         }
         return false;
      }
      
      public function getLevByDifficlty(difficulty:int) : Object
      {
         var index:int = 0;
         var minLev:int = 0;
         var maxLev:int = 0;
         var obj:Object = {};
         obj.minLev = 0;
         obj.maxLev = 0;
         if(_difficultyForLev == null)
         {
            _difficultyForLev = ServerConfigManager.instance.unrealContestLevelLimits;
         }
         if(_difficultyForLev && _difficultyForLev.length >= 6)
         {
            index = (difficulty - 1) * 2;
            minLev = _difficultyForLev[index];
            maxLev = _difficultyForLev[index + 1];
            obj.minLev = minLev;
            obj.maxLev = maxLev;
         }
         return obj;
      }
      
      private function sendStart(mapID:int, difficulty:int, type:int = 0) : void
      {
         mapID = mapID;
         difficulty = difficulty;
         type = type;
         _sendRoomSet = true;
         var timeType:int = 3 - difficulty + 1;
         RoomManager.Instance.addEventListener("gameRoomCreate",function():*
         {
            var /*UnknownSlot*/:* = function(evt:CrazyTankSocketEvent):void
            {
               RoomManager.Instance.removeEventListener("gameRoomCreate",__roomCreateHandler);
               GameInSocketOut.sendGameRoomSetUp(mapID,70,false,"",roomName,timeType,difficulty,0,false,0,false,type);
            };
            return function(evt:CrazyTankSocketEvent):void
            {
               RoomManager.Instance.removeEventListener("gameRoomCreate",__roomCreateHandler);
               GameInSocketOut.sendGameRoomSetUp(mapID,70,false,"",roomName,timeType,difficulty,0,false,0,false,type);
            };
         }());
         var roomName:String = LanguageMgr.GetTranslation("ddt.dreamLand.roomName");
         GameInSocketOut.sendCreateRoom(roomName,70,2,"");
      }
      
      private function cannotChallengeAlert(difficulty:int) : void
      {
         var levs:Object = getLevByDifficlty(difficulty);
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.dreamLand.challenge.powerNotEnoughMsg",levs.minLev,levs.maxLev),LanguageMgr.GetTranslation("ok"),"",true,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.cancelButtonEnable = false;
      }
      
      private function challengeCountBuyAlert() : void
      {
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.dreamLand.challengeCount.buyPrompt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",function():*
         {
            var /*UnknownSlot*/:* = function(evt:FrameEvent):void
            {
               _confirmFrame.removeEventListener("response",__confirmBuy);
               if(evt.responseCode == 3 || evt.responseCode == 2)
               {
                  showBuychallengeCountFrame();
               }
            };
            return function(evt:FrameEvent):void
            {
               _confirmFrame.removeEventListener("response",__confirmBuy);
               if(evt.responseCode == 3 || evt.responseCode == 2)
               {
                  showBuychallengeCountFrame();
               }
            };
         }());
      }
      
      public function showBuychallengeCountFrame() : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var needMoney:int = ServerConfigManager.instance.unrealContestBuyCost;
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.dreamLand.buyChallengeCount.ConfirmTxt",needMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true,1,0);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirmBuy);
      }
      
      private function __confirmBuy(evt:FrameEvent) : void
      {
         evt = evt;
         SoundManager.instance.play("008");
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            var needMoney:int = ServerConfigManager.instance.unrealContestBuyCost;
            CheckMoneyUtils.instance.checkMoney(_confirmFrame.isBand,needMoney,function():*
            {
               var /*UnknownSlot*/:* = function():void
               {
                  SocketManager.Instance.out.sendBuyDreamLandCount(CheckMoneyUtils.instance.isBind);
               };
               return function():void
               {
                  SocketManager.Instance.out.sendBuyDreamLandCount(CheckMoneyUtils.instance.isBind);
               };
            }());
         }
         _confirmFrame.removeEventListener("response",__confirmBuy);
         _confirmFrame = null;
      }
      
      private function __activeStateChangeHandler(evt:Event) : void
      {
         if(_mainFrame)
         {
            _mainFrame.disableChallengeBtn = disableChallengeBtn;
         }
      }
      
      public function get disableChallengeBtn() : Boolean
      {
         var state:int = DreamlandChallengeManager.instance.curState;
         return state >= 2 && state <= 3?true:false;
      }
      
      private function getViewData() : void
      {
         SocketManager.Instance.out.requestDreamLandData();
      }
      
      public function getRankData(pageNum:int, type:int) : void
      {
         SocketManager.Instance.out.requestDreamLandRandData(pageNum,type);
      }
      
      public function get isClick() : Boolean
      {
         var nowTime:Number = new Date().time;
         if(nowTime - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return false;
         }
         _clickNum = nowTime;
         return true;
      }
      
      public function reset() : void
      {
         ObjectUtils.disposeObject(_confirmFrame);
         _confirmFrame = null;
         _mainFrame = null;
      }
   }
}
