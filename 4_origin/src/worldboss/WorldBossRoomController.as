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
      
      private function __onOpenView(param1:CEvent) : void
      {
         new HelperUIModuleLoad().loadUIModule(["worldBoss"],loadComplete);
      }
      
      private function loadComplete() : void
      {
         SocketManager.Instance.out.enterWorldBossRoom();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("alertInBossRoom");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         GameLoadingManager.Instance.hide();
         super.enter(param1,param2);
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
      
      protected function __onTimeOut(param1:Event) : void
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
      
      protected function __onUpdateBlood(param1:Event) : void
      {
         if(_view)
         {
            _view.refreshHpScript();
         }
      }
      
      protected function __onGameInit(param1:Event) : void
      {
         if(_view)
         {
            _view.refreshHpScript();
         }
      }
      
      protected function __onEnteringGame(param1:Event) : void
      {
         _waitingView.visible = true;
         _waitingView.start();
      }
      
      public function checkSelfStatus() : void
      {
         _view.checkSelfStatus();
      }
      
      private function __onSetSelfStatus(param1:CEvent) : void
      {
         setSelfStatus(int(param1.data));
      }
      
      public function setSelfStatus(param1:int) : void
      {
         if(_view)
         {
            _view.updateSelfStatus(param1);
         }
         else
         {
            _callback = setSelfStatus;
            _callbackArg = param1;
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
      
      public function __addPlayer(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         if(param1.pkg.bytesAvailable > 10)
         {
            _loc6_ = new PlayerInfo();
            _loc6_.beginChanges();
            _loc6_.Grade = _loc5_.readInt();
            _loc6_.Hide = _loc5_.readInt();
            _loc6_.Repute = _loc5_.readInt();
            _loc6_.ID = _loc5_.readInt();
            _loc6_.NickName = _loc5_.readUTF();
            _loc6_.typeVIP = _loc5_.readByte();
            _loc6_.VIPLevel = _loc5_.readInt();
            _loc6_.Sex = _loc5_.readBoolean();
            _loc6_.Style = _loc5_.readUTF();
            _loc6_.Colors = _loc5_.readUTF();
            _loc6_.Skin = _loc5_.readUTF();
            _loc4_ = _loc5_.readInt();
            _loc2_ = _loc5_.readInt();
            _loc6_.FightPower = _loc5_.readInt();
            _loc6_.WinCount = _loc5_.readInt();
            _loc6_.TotalCount = _loc5_.readInt();
            _loc6_.Offer = _loc5_.readInt();
            _loc6_.commitChanges();
            _loc3_ = new PlayerVO();
            _loc3_.playerInfo = _loc6_;
            _loc3_.playerPos = new Point(_loc4_,_loc2_);
            _loc3_.playerStauts = _loc5_.readByte();
            _loc5_.readInt();
            _loc3_.playerInfo.MountsType = _loc5_.readInt();
            _loc3_.playerInfo.PetsID = _loc5_.readInt();
            if(_loc6_.ID == PlayerManager.Instance.Self.ID)
            {
               return;
            }
            _sceneModel.addPlayer(_loc3_);
         }
      }
      
      public function __removePlayer(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         _sceneModel.removePlayer(_loc2_);
      }
      
      public function __movePlayer(param1:CrazyTankSocketEvent) : void
      {
         var _loc9_:* = 0;
         var _loc6_:* = null;
         var _loc2_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         var _loc8_:String = param1.pkg.readUTF();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         var _loc4_:Array = _loc8_.split(",");
         var _loc7_:Array = [];
         _loc9_ = uint(0);
         while(_loc9_ < _loc4_.length)
         {
            _loc6_ = new Point(_loc4_[_loc9_],_loc4_[_loc9_ + 1]);
            _loc7_.push(_loc6_);
            _loc9_ = uint(_loc9_ + 2);
         }
         _view.movePlayer(_loc2_,_loc7_);
      }
      
      public function __updatePlayerStauts(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc5_:int = _loc4_.readByte();
         var _loc3_:Point = new Point(_loc4_.readInt(),_loc4_.readInt());
         _view.updatePlayerStauts(_loc2_,_loc5_,_loc3_);
         _sceneModel.updatePlayerStauts(_loc2_,_loc5_,_loc3_);
      }
      
      private function __playerRevive(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _view.playerRevive(_loc2_);
      }
      
      public function __updata(param1:Event) : void
      {
         if(StateManager.currentStateType == "worldboss")
         {
            _view.gameOver();
         }
         _view.timeComplete();
      }
      
      public function __updataRanking(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:Array = [];
         var _loc2_:int = param1.pkg.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = new RankingPersonInfo();
            _loc5_.id = param1.pkg.readInt();
            _loc5_.name = param1.pkg.readUTF();
            _loc5_.damage = param1.pkg.readInt();
            _loc3_.push(_loc5_);
            _loc6_++;
         }
         _view.updataRanking(_loc3_);
      }
      
      private function __onClose(param1:CEvent) : void
      {
         dispose();
      }
      
      private function __onSetSlefStatus(param1:CEvent) : void
      {
      }
      
      override public function getType() : String
      {
         return "worldboss";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("alertInBossRoom");
         CacheSysManager.getInstance().release("alertInBossRoom");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         super.leaving(param1);
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
