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
      
      private function __onBossRankList(e:PkgEvent) : void
      {
         var i:int = 0;
         var vo:* = null;
         var BYTE:int = e.pkg.readInt();
         var count:int = e.pkg.readInt();
         ConsortiaGuardControl.Instance.model.rankBossList.clear();
         for(i = 0; i < count; )
         {
            vo = new ConsortiaBossDataVo();
            vo.rank = e.pkg.readInt();
            vo.name = e.pkg.readUTF();
            vo.damage = e.pkg.readInt();
            vo.attacksCount = e.pkg.readInt();
            ConsortiaGuardControl.Instance.model.rankBossList.add(vo.rank,vo);
            i++;
         }
         dispatchEvent(new ConsortiaGuardEvent("showBossRank",BYTE));
      }
      
      public function bossLocation(point:Point) : void
      {
         dispatchEvent(new ConsortiaGuardEvent("clickBossIcon",point));
      }
      
      private function __onOpenActivity(e:PkgEvent) : void
      {
         _model.isOpen = e.pkg.readBoolean();
         _model.openTime = e.pkg.readDate();
         _model.openLevel = e.pkg.readInt();
         _model.isFight = e.pkg.readBoolean();
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
      
      private function __onBuyBuff(e:PkgEvent) : void
      {
         var buffLevel:int = e.pkg.readInt();
         _model.buffLevel = buffLevel;
      }
      
      private function __onInitScene(e:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var pkg:PackageIn = e.pkg;
         for(i = 0; i < pkg.extend1; )
         {
            id = pkg.readInt();
            addPlayer(id,pkg);
            i++;
         }
         var bool:Boolean = e.pkg.readBoolean();
         if(bool && StateManager.currentStateType != "consortiaGuard")
         {
            StateManager.setState("consortiaGuard");
         }
      }
      
      private function __onPlayer(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var id:int = pkg.readInt();
         addPlayer(id,pkg);
         dispatchEvent(new ConsortiaGuardEvent("addPlayer",id));
      }
      
      private function addPlayer(id:int, pkg:PackageIn) : void
      {
         var vo:* = null;
         var newPlayer:Boolean = true;
         if(_model.playerList.hasKey(id))
         {
            vo = _model.playerList[id];
            newPlayer = false;
         }
         else
         {
            vo = new FightPlayerVo();
            vo.playerInfo = new PlayerInfo();
         }
         vo.playerInfo.beginChanges();
         vo.playerInfo.ID = id;
         vo.playerInfo.Sex = pkg.readBoolean();
         vo.playerInfo.Style = pkg.readUTF();
         vo.playerInfo.Colors = pkg.readUTF();
         vo.playerInfo.Skin = pkg.readUTF();
         vo.playerInfo.NickName = pkg.readUTF();
         vo.currentWalkStartPoint = new Point(pkg.readInt(),pkg.readInt());
         vo.state = pkg.readInt();
         vo.reviveTime = new Date(pkg.readDate().getTime() + ServerConfigManager.instance.consortiaGuardReviveTime * 1000);
         vo.playerInfo.IsVIP = pkg.readBoolean();
         vo.playerInfo.VIPLevel = pkg.readInt();
         vo.playerInfo.MountsType = pkg.readInt();
         vo.playerInfo.commitChanges();
         if(newPlayer)
         {
            _model.playerList.add(id,vo);
         }
      }
      
      private function __onUpdateBossState(e:PkgEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < 4; )
         {
            _model.setBossMaxHp(i,e.pkg.readDouble());
            _model.setBossHp(i,e.pkg.readDouble());
            _model.setBossState(i,e.pkg.readInt());
            i++;
         }
         _model.statueHp = e.pkg.readDouble();
         _model.statueMaxHp = e.pkg.readDouble();
         dispatchEvent(new ConsortiaGuardEvent("updateBossState"));
      }
      
      private function __onUpdatePlayerState(e:PkgEvent) : void
      {
         var vo:* = null;
         var id:int = e.pkg.readInt();
         if(id == PlayerManager.Instance.Self.ID)
         {
            vo = PlayerManager.Instance.fightVo;
         }
         else
         {
            vo = _model.playerList[id] as FightPlayerVo;
         }
         if(vo == null)
         {
            return;
         }
         vo.state = e.pkg.readInt();
         var time:Number = ServerConfigManager.instance.consortiaGuardReviveTime * 1000;
         vo.reviveTime = new Date(TimeManager.Instance.NowTime() + time);
         dispatchEvent(new ConsortiaGuardEvent("updatePlayerState",id));
      }
      
      private function __onRemovePlayer(e:PkgEvent) : void
      {
         var id:int = e.pkg.readInt();
         _model.playerList.remove(id);
         dispatchEvent(new ConsortiaGuardEvent("removePlayer",id));
      }
      
      private function __onRankList(e:PkgEvent) : void
      {
         var i:int = 0;
         var isSelf:Boolean = e.pkg.readBoolean();
         if(isSelf)
         {
            addRankVo(e.pkg,true);
         }
         else
         {
            ConsortiaGuardControl.Instance.model.rankList.remove(0);
         }
         var count:int = e.pkg.readByte();
         for(i = 0; i < count; )
         {
            addRankVo(e.pkg,false);
            i++;
         }
         dispatchEvent(new ConsortiaGuardEvent("updateRank"));
      }
      
      private function __onGameState(e:PkgEvent) : void
      {
         var isFight:Boolean = e.pkg.readBoolean();
         var isWin:Boolean = e.pkg.readBoolean();
         var endTime:int = e.pkg.readInt();
         _model.isFight = isFight;
         _model.isWin = isWin;
         _model.endTime = TimeManager.Instance.NowTime() + endTime * 60000;
         if(isFight == false)
         {
            if(isWin)
            {
               ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation("tank.consortiaGurad.win"));
            }
            else
            {
               ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation("tank.consortiaGurad.fail1"));
               ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation("tank.consortiaGurad.fail2"));
            }
            ChatManager.Instance.sysChatConsortia(LanguageMgr.GetTranslation("tank.consortiaGurad.closeRoom",endTime));
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
      
      private function __onTimer(e:TimerEvent) : void
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
      
      private function addRankVo(e:PackageIn, isSelf:Boolean = false) : void
      {
         var vo:ConsortiaBossDataVo = new ConsortiaBossDataVo();
         if(isSelf)
         {
            vo.name = PlayerManager.Instance.Self.NickName;
         }
         else
         {
            vo.name = e.readUTF();
         }
         vo.rank = e.readInt();
         vo.damage = e.readInt();
         vo.honor = e.readInt();
         vo.contribution = e.readInt();
         ConsortiaGuardControl.Instance.model.rankList.add(vo.rank,vo);
         if(isSelf)
         {
            ConsortiaGuardControl.Instance.model.rankList.add(0,vo);
         }
      }
      
      public function get showPlayer() : Boolean
      {
         return _showPlayer;
      }
      
      public function set showPlayer(value:Boolean) : void
      {
         if(_showPlayer == value)
         {
            return;
         }
         _showPlayer = value;
         dispatchEvent(new ConsortiaGuardEvent("updatePlayerView"));
      }
      
      public function get model() : ConsortiaGuardModel
      {
         return _model;
      }
   }
}
