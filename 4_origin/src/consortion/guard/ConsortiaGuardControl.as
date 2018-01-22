package consortion.guard
{
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaBossDataVo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   import starling.display.player.FightPlayerVo;
   
   public class ConsortiaGuardControl extends EventDispatcher
   {
      
      private static var _instance:ConsortiaGuardControl;
       
      
      public var notAlertAgain:Boolean = false;
      
      public var bossRankShow:Boolean = false;
      
      private var _showPlayer:Boolean = true;
      
      private var _timer:Timer;
      
      private var _model:ConsortiaGuardModel;
      
      public function ConsortiaGuardControl()
      {
         super();
         _model = new ConsortiaGuardModel();
      }
      
      public static function get Instance() : ConsortiaGuardControl
      {
         if(_instance == null)
         {
            _instance = new ConsortiaGuardControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(316,0),__onOpenActivity);
      }
      
      public function enterGuradScene() : void
      {
         if(checkCanStartGame())
         {
            _model.reset();
            GameInSocketOut.sendSingleRoomBegin(23);
         }
      }
      
      private function checkCanStartGame() : Boolean
      {
         var result:Boolean = true;
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.setFunction(this,function():void
            {
               _model.reset();
               GameInSocketOut.sendSingleRoomBegin(23);
            });
            CheckWeaponManager.instance.showAlert();
            result = false;
         }
         return result;
      }
      
      public function leaveGuardScene() : void
      {
         disposeTimer();
         StateManager.back();
         SocketManager.Instance.out.sendConsortiaGuradLeaveScene();
         RoomManager.Instance.reset();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(316,6),__onInitScene);
         SocketManager.Instance.addEventListener(PkgEvent.format(316,4),__onUpdateBossState);
         SocketManager.Instance.addEventListener(PkgEvent.format(316,1),__onPlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(316,8),__onUpdatePlayerState);
         SocketManager.Instance.addEventListener(PkgEvent.format(316,16),__onRankList);
         SocketManager.Instance.addEventListener(PkgEvent.format(316,12),__onRemovePlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(316,9),__onGameState);
         SocketManager.Instance.addEventListener(PkgEvent.format(316,17),__onBuyBuff);
         SocketManager.Instance.addEventListener(PkgEvent.format(316,19),__onBossRankList);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(316,6),__onInitScene);
         SocketManager.Instance.removeEventListener(PkgEvent.format(316,4),__onUpdateBossState);
         SocketManager.Instance.removeEventListener(PkgEvent.format(316,1),__onPlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(316,8),__onUpdatePlayerState);
         SocketManager.Instance.removeEventListener(PkgEvent.format(316,16),__onRankList);
         SocketManager.Instance.removeEventListener(PkgEvent.format(316,12),__onRemovePlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(316,9),__onGameState);
         SocketManager.Instance.removeEventListener(PkgEvent.format(316,17),__onBuyBuff);
         SocketManager.Instance.removeEventListener(PkgEvent.format(316,19),__onBossRankList);
      }
      
      private function __onBossRankList(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         ConsortiaGuardControl.Instance.model.rankBossList.clear();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new ConsortiaBossDataVo();
            _loc4_.rank = param1.pkg.readInt();
            _loc4_.name = param1.pkg.readUTF();
            _loc4_.damage = param1.pkg.readInt();
            _loc4_.attacksCount = param1.pkg.readInt();
            ConsortiaGuardControl.Instance.model.rankBossList.add(_loc4_.rank,_loc4_);
            _loc5_++;
         }
         dispatchEvent(new ConsortiaGuardEvent("showBossRank",_loc2_));
      }
      
      public function bossLocation(param1:Point) : void
      {
         dispatchEvent(new ConsortiaGuardEvent("clickBossIcon",param1));
      }
      
      private function __onOpenActivity(param1:PkgEvent) : void
      {
         _model.isOpen = param1.pkg.readBoolean();
         _model.openTime = param1.pkg.readDate();
         _model.openLevel = param1.pkg.readInt();
         _model.isFight = param1.pkg.readBoolean();
         removeEvent();
         if(_model.isOpen)
         {
            ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation("tank.consortiaGurad.activityOpen"));
            initEvent();
            updateConsortia();
         }
         dispatchEvent(new ConsortiaGuardEvent("updateActivity"));
      }
      
      private function updateConsortia() : void
      {
         if(StateManager.currentStateType == "consortia")
         {
            ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
         }
      }
      
      private function __onBuyBuff(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         _model.buffLevel = _loc2_;
      }
      
      private function __onInitScene(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.extend1)
         {
            _loc2_ = _loc3_.readInt();
            addPlayer(_loc2_,_loc3_);
            _loc5_++;
         }
         var _loc4_:Boolean = param1.pkg.readBoolean();
         if(_loc4_ && StateManager.currentStateType != "consortiaGuard")
         {
            StateManager.setState("consortiaGuard");
         }
      }
      
      private function __onPlayer(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         addPlayer(_loc2_,_loc3_);
         dispatchEvent(new ConsortiaGuardEvent("addPlayer",_loc2_));
      }
      
      private function addPlayer(param1:int, param2:PackageIn) : void
      {
         var _loc4_:* = null;
         var _loc3_:Boolean = true;
         if(_model.playerList.hasKey(param1))
         {
            _loc4_ = _model.playerList[param1];
            _loc3_ = false;
         }
         else
         {
            _loc4_ = new FightPlayerVo();
            _loc4_.playerInfo = new PlayerInfo();
         }
         _loc4_.playerInfo.beginChanges();
         _loc4_.playerInfo.ID = param1;
         _loc4_.playerInfo.Sex = param2.readBoolean();
         _loc4_.playerInfo.Style = param2.readUTF();
         _loc4_.playerInfo.Colors = param2.readUTF();
         _loc4_.playerInfo.Skin = param2.readUTF();
         _loc4_.playerInfo.NickName = param2.readUTF();
         _loc4_.currentWalkStartPoint = new Point(param2.readInt(),param2.readInt());
         _loc4_.state = param2.readInt();
         _loc4_.reviveTime = new Date(param2.readDate().getTime() + ServerConfigManager.instance.consortiaGuardReviveTime * 1000);
         _loc4_.playerInfo.IsVIP = param2.readBoolean();
         _loc4_.playerInfo.VIPLevel = param2.readInt();
         _loc4_.playerInfo.MountsType = param2.readInt();
         _loc4_.playerInfo.commitChanges();
         if(_loc3_)
         {
            _model.playerList.add(param1,_loc4_);
         }
      }
      
      private function __onUpdateBossState(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _model.setBossMaxHp(_loc2_,param1.pkg.readDouble());
            _model.setBossHp(_loc2_,param1.pkg.readDouble());
            _model.setBossState(_loc2_,param1.pkg.readInt());
            _loc2_++;
         }
         _model.statueHp = param1.pkg.readDouble();
         _model.statueMaxHp = param1.pkg.readDouble();
         dispatchEvent(new ConsortiaGuardEvent("updateBossState"));
      }
      
      private function __onUpdatePlayerState(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:int = param1.pkg.readInt();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            _loc4_ = PlayerManager.Instance.fightVo;
         }
         else
         {
            _loc4_ = _model.playerList[_loc2_] as FightPlayerVo;
         }
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.state = param1.pkg.readInt();
         var _loc3_:Number = ServerConfigManager.instance.consortiaGuardReviveTime * 1000;
         _loc4_.reviveTime = new Date(TimeManager.Instance.NowTime() + _loc3_);
         dispatchEvent(new ConsortiaGuardEvent("updatePlayerState",_loc2_));
      }
      
      private function __onRemovePlayer(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         _model.playerList.remove(_loc2_);
         dispatchEvent(new ConsortiaGuardEvent("removePlayer",_loc2_));
      }
      
      private function __onRankList(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Boolean = param1.pkg.readBoolean();
         if(_loc3_)
         {
            addRankVo(param1.pkg,true);
         }
         else
         {
            ConsortiaGuardControl.Instance.model.rankList.remove(0);
         }
         var _loc2_:int = param1.pkg.readByte();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            addRankVo(param1.pkg,false);
            _loc4_++;
         }
         dispatchEvent(new ConsortiaGuardEvent("updateRank"));
      }
      
      private function __onGameState(param1:PkgEvent) : void
      {
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc2_:Boolean = param1.pkg.readBoolean();
         var _loc4_:int = param1.pkg.readInt();
         _model.isFight = _loc3_;
         _model.isWin = _loc2_;
         _model.endTime = TimeManager.Instance.NowTime() + _loc4_ * 60000;
         if(_loc3_ == false)
         {
            if(_loc2_)
            {
               ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation("tank.consortiaGurad.win"));
            }
            else
            {
               ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation("tank.consortiaGurad.fail1"));
               ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation("tank.consortiaGurad.fail2"));
            }
            ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation("tank.consortiaGurad.closeRoom",_loc4_));
         }
         dispatchEvent(new ConsortiaGuardEvent("updateGameState"));
      }
      
      private function startCloseRoomTimer() : void
      {
         if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "consortiaGuard")
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",__onTimer);
         }
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         if(TimeManager.Instance.NowTime() > _model.endTime)
         {
            leaveGuardScene();
         }
      }
      
      private function disposeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
      }
      
      private function addRankVo(param1:PackageIn, param2:Boolean = false) : void
      {
         var _loc3_:ConsortiaBossDataVo = new ConsortiaBossDataVo();
         if(param2)
         {
            _loc3_.name = PlayerManager.Instance.Self.NickName;
         }
         else
         {
            _loc3_.name = param1.readUTF();
         }
         _loc3_.rank = param1.readInt();
         _loc3_.damage = param1.readInt();
         _loc3_.honor = param1.readInt();
         _loc3_.contribution = param1.readInt();
         ConsortiaGuardControl.Instance.model.rankList.add(_loc3_.rank,_loc3_);
         if(param2)
         {
            ConsortiaGuardControl.Instance.model.rankList.add(0,_loc3_);
         }
      }
      
      public function get showPlayer() : Boolean
      {
         return _showPlayer;
      }
      
      public function set showPlayer(param1:Boolean) : void
      {
         if(_showPlayer == param1)
         {
            return;
         }
         _showPlayer = param1;
         dispatchEvent(new ConsortiaGuardEvent("updatePlayerView"));
      }
      
      public function get model() : ConsortiaGuardModel
      {
         return _model;
      }
   }
}
