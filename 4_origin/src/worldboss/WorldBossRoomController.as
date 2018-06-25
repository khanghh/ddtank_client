package worldboss
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import flash.geom.Point;
   import hall.GameLoadingManager;
   import invite.InviteManager;
   import road7th.comm.PackageIn;
   import worldboss.model.WorldBossRoomModel;
   import worldboss.player.PlayerVO;
   import worldboss.player.RankingPersonInfo;
   import worldboss.view.WaitingWorldBossView;
   import worldboss.view.WorldBossRoomView;
   
   public class WorldBossRoomController extends BaseStateView
   {
      
      private static var _instance:WorldBossRoomController;
      
      private static var _isFirstCome:Boolean = true;
       
      
      private var _sceneModel:WorldBossRoomModel;
      
      private var _view:WorldBossRoomView;
      
      private var _waitingView:WaitingWorldBossView;
      
      private var _callback:Function;
      
      private var _callbackArg:int;
      
      public function WorldBossRoomController()
      {
         super();
      }
      
      public static function get Instance() : WorldBossRoomController
      {
         if(!_instance)
         {
            _instance = new WorldBossRoomController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         WorldBossManager.Instance.addEventListener("openview",__onOpenView);
      }
      
      private function __onOpenView(e:CEvent) : void
      {
         new HelperUIModuleLoad().loadUIModule(["worldBoss"],loadComplete);
      }
      
      private function loadComplete() : void
      {
         SocketManager.Instance.out.enterWorldBossRoom();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("alertInBossRoom");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         GameLoadingManager.Instance.hide();
         super.enter(prev,data);
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         MainToolBar.Instance.hide();
         addEvent();
         SocketManager.Instance.out.sendCurrentState(2);
         if(_isFirstCome)
         {
            init();
            _isFirstCome = false;
         }
         else if(_view)
         {
            if(WorldBossManager.IsSuccessStartGame)
            {
               WorldBossManager.Instance.bossInfo.myPlayerVO.buffs = [];
               _view.clearBuff();
            }
            checkSelfStatus();
            _view.setViewAgain();
            SocketManager.Instance.out.sendAddAllWorldBossPlayer();
         }
         if(_callback != null)
         {
            _callback(_callbackArg);
         }
      }
      
      private function init() : void
      {
         _sceneModel = new WorldBossRoomModel();
         _view = new WorldBossRoomView(this,_sceneModel);
         _view.show();
         _view.showBuff();
         _waitingView = new WaitingWorldBossView();
         addChild(_waitingView);
         _waitingView.visible = false;
         _waitingView.addEventListener("enterGameTimeOut",__onTimeOut);
      }
      
      protected function __onTimeOut(event:Event) : void
      {
         _waitingView.stop();
         _waitingView.visible = false;
         WorldBossManager.Instance.exitGame();
         checkSelfStatus();
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(102,3),__addPlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,6),__movePlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,4),__removePlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,7),__updatePlayerStauts);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,11),__playerRevive);
         WorldBossManager.Instance.addEventListener("fight_over",__updata);
         WorldBossManager.Instance.addEventListener("worldboss_ranking_inroom",__updataRanking);
         WorldBossManager.Instance.addEventListener("enteringGame",__onEnteringGame);
         WorldBossManager.Instance.addEventListener("gameInit",__onGameInit);
         WorldBossManager.Instance.addEventListener("closeView",__onClose);
         WorldBossManager.Instance.addEventListener("setselfstatus",__onSetSelfStatus);
      }
      
      protected function __onUpdateBlood(event:Event) : void
      {
         if(_view)
         {
            _view.refreshHpScript();
         }
      }
      
      protected function __onGameInit(event:Event) : void
      {
         if(_view)
         {
            _view.refreshHpScript();
         }
      }
      
      protected function __onEnteringGame(event:Event) : void
      {
         _waitingView.visible = true;
         _waitingView.start();
      }
      
      public function checkSelfStatus() : void
      {
         _view.checkSelfStatus();
      }
      
      private function __onSetSelfStatus(e:CEvent) : void
      {
         setSelfStatus(int(e.data));
      }
      
      public function setSelfStatus(value:int) : void
      {
         if(_view)
         {
            _view.updateSelfStatus(value);
         }
         else
         {
            _callback = setSelfStatus;
            _callbackArg = value;
         }
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,3),__addPlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,6),__movePlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,4),__removePlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,7),__updatePlayerStauts);
         SocketManager.Instance.removeEventListener(PkgEvent.format(102,11),__playerRevive);
         WorldBossManager.Instance.removeEventListener("fight_over",__updata);
         WorldBossManager.Instance.removeEventListener("worldboss_ranking_inroom",__updataRanking);
         WorldBossManager.Instance.removeEventListener("enteringGame",__onEnteringGame);
         WorldBossManager.Instance.removeEventListener("gameInit",__onGameInit);
         WorldBossManager.Instance.removeEventListener("boss_hp_updata",__onUpdateBlood);
         WorldBossManager.Instance.removeEventListener("closeView",__onClose);
         WorldBossManager.Instance.removeEventListener("setselfstatus",__onSetSelfStatus);
         if(_waitingView)
         {
            _waitingView.removeEventListener("enterGameTimeOut",__onTimeOut);
         }
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      public function __addPlayer(event:CrazyTankSocketEvent) : void
      {
         var playerInfo:* = null;
         var posx:int = 0;
         var posy:int = 0;
         var playerVO:* = null;
         var pkg:PackageIn = event.pkg;
         if(event.pkg.bytesAvailable > 10)
         {
            playerInfo = new PlayerInfo();
            playerInfo.beginChanges();
            playerInfo.Grade = pkg.readInt();
            playerInfo.Hide = pkg.readInt();
            playerInfo.Repute = pkg.readInt();
            playerInfo.ID = pkg.readInt();
            playerInfo.NickName = pkg.readUTF();
            playerInfo.typeVIP = pkg.readByte();
            playerInfo.VIPLevel = pkg.readInt();
            playerInfo.Sex = pkg.readBoolean();
            playerInfo.Style = pkg.readUTF();
            playerInfo.Colors = pkg.readUTF();
            playerInfo.Skin = pkg.readUTF();
            posx = pkg.readInt();
            posy = pkg.readInt();
            playerInfo.FightPower = pkg.readInt();
            playerInfo.WinCount = pkg.readInt();
            playerInfo.TotalCount = pkg.readInt();
            playerInfo.Offer = pkg.readInt();
            playerInfo.commitChanges();
            playerVO = new PlayerVO();
            playerVO.playerInfo = playerInfo;
            playerVO.playerPos = new Point(posx,posy);
            playerVO.playerStauts = pkg.readByte();
            pkg.readInt();
            playerVO.playerInfo.MountsType = pkg.readInt();
            playerVO.playerInfo.PetsID = pkg.readInt();
            if(playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               return;
            }
            _sceneModel.addPlayer(playerVO);
         }
      }
      
      public function __removePlayer(event:CrazyTankSocketEvent) : void
      {
         var id:int = event.pkg.readInt();
         _sceneModel.removePlayer(id);
      }
      
      public function __movePlayer(event:CrazyTankSocketEvent) : void
      {
         var i:* = 0;
         var p:* = null;
         var id:int = event.pkg.readInt();
         var posX:int = event.pkg.readInt();
         var posY:int = event.pkg.readInt();
         var pathStr:String = event.pkg.readUTF();
         if(id == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         var arr:Array = pathStr.split(",");
         var path:Array = [];
         for(i = uint(0); i < arr.length; )
         {
            p = new Point(arr[i],arr[i + 1]);
            path.push(p);
            i = uint(i + 2);
         }
         _view.movePlayer(id,path);
      }
      
      public function __updatePlayerStauts(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var id:int = pkg.readInt();
         var stauts:int = pkg.readByte();
         var point:Point = new Point(pkg.readInt(),pkg.readInt());
         _view.updatePlayerStauts(id,stauts,point);
         _sceneModel.updatePlayerStauts(id,stauts,point);
      }
      
      private function __playerRevive(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var id:int = pkg.readInt();
         _view.playerRevive(id);
      }
      
      public function __updata(e:Event) : void
      {
         if(StateManager.currentStateType == "worldboss")
         {
            _view.gameOver();
         }
         _view.timeComplete();
      }
      
      public function __updataRanking(evt:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var personInfo:* = null;
         var pkg:PackageIn = evt.pkg;
         var arr:Array = [];
         var count:int = evt.pkg.readInt();
         for(i = 0; i < count; )
         {
            personInfo = new RankingPersonInfo();
            personInfo.id = evt.pkg.readInt();
            personInfo.name = evt.pkg.readUTF();
            personInfo.damage = evt.pkg.readInt();
            arr.push(personInfo);
            i++;
         }
         _view.updataRanking(arr);
      }
      
      private function __onClose(e:CEvent) : void
      {
         dispose();
      }
      
      private function __onSetSlefStatus(e:CEvent) : void
      {
      }
      
      override public function getType() : String
      {
         return "worldboss";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("alertInBossRoom");
         CacheSysManager.getInstance().release("alertInBossRoom");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         super.leaving(next);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_sceneModel)
         {
            _sceneModel.dispose();
         }
         ObjectUtils.disposeAllChildren(this);
         _view = null;
         _sceneModel = null;
         CacheSysManager.unlock("alertInBossRoom");
         CacheSysManager.getInstance().release("alertInBossRoom");
         _isFirstCome = true;
      }
   }
}
