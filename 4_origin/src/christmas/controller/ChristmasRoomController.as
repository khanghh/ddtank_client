package christmas.controller
{
   import christmas.ChristmasCoreManager;
   import christmas.info.MonsterInfo;
   import christmas.model.ChristmasRoomModel;
   import christmas.player.PlayerVO;
   import christmas.view.playingSnowman.ChristmasRoomView;
   import christmas.view.playingSnowman.WaitingChristmasView;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import flash.geom.Point;
   import hall.GameLoadingManager;
   import invite.InviteManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class ChristmasRoomController extends BaseStateView
   {
      
      private static var _instance:ChristmasRoomController;
      
      private static var _isFirstCome:Boolean = true;
       
      
      private var _sceneModel:ChristmasRoomModel;
      
      private var _view:ChristmasRoomView;
      
      private var _waitingView:WaitingChristmasView;
      
      protected var _monsters:DictionaryData;
      
      private var _monsterCount:int = 0;
      
      private var _callback:Function;
      
      private var _callbackArg:int;
      
      public function ChristmasRoomController()
      {
         super();
      }
      
      public static function get Instance() : ChristmasRoomController
      {
         if(!_instance)
         {
            _instance = new ChristmasRoomController();
         }
         return _instance;
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("alertInChristmasRoom");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         GameLoadingManager.Instance.hide();
         super.enter(prev,data);
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         MainToolBar.Instance.hide();
         addEvent();
         if(ChristmasCoreManager.isToRoom)
         {
            setSelfStatus(0);
            SocketManager.Instance.out.enterChristmasRoom(ChristmasCoreManager.instance.christmasInfo.myPlayerVO.playerPos);
         }
         else
         {
            SocketManager.Instance.out.enterChristmasRoom(ChristmasCoreManager.instance.christmasInfo.playerDefaultPos);
         }
         if(_isFirstCome)
         {
            init();
            _isFirstCome = false;
         }
         else if(_view)
         {
            _view.setViewAgain();
         }
         if(_callback != null)
         {
            _callback(_callbackArg);
         }
      }
      
      private function init() : void
      {
         _sceneModel = new ChristmasRoomModel();
         _view = new ChristmasRoomView(this,_sceneModel);
         _view.show();
         _waitingView = new WaitingChristmasView();
         addChild(_waitingView);
         _waitingView.visible = false;
         _waitingView.addEventListener("enterGameTimeOut",__onTimeOut);
      }
      
      protected function __onTimeOut(event:Event) : void
      {
         _waitingView.stop();
         _waitingView.visible = false;
         ChristmasCoreManager.instance.exitGame();
      }
      
      private function addEvent() : void
      {
         ChristmasCoreManager.instance.addEventListener("addplayer_room",__addPlayer);
         ChristmasCoreManager.instance.addEventListener("christmas_move",__movePlayer);
         ChristmasCoreManager.instance.addEventListener("player_statue",__updatePlayerStauts);
         ChristmasCoreManager.instance.addEventListener("christmas_exit",__removePlayer);
         ChristmasCoreManager.instance.addEventListener("christmas_monster",__monstersEvent);
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
      
      private function __monstersEvent(pEvent:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var monsInfo:* = null;
         var id:int = 0;
         var count:int = 0;
         var k:int = 0;
         var monsterID:int = 0;
         var monsterX:int = 0;
         var monsterY:int = 0;
         var monsterState:int = 0;
         var ID:int = 0;
         var state:int = 0;
         var queryLoader:QueueLoader = new QueueLoader();
         var p:PackageIn = pEvent.pkg;
         var select:int = p.readByte();
         var path:String = "";
         if(select == 0)
         {
            _monsterCount = p.readInt();
            for(i = 0; i < _monsterCount; )
            {
               monsInfo = new MonsterInfo();
               monsInfo.ID = p.readInt();
               monsInfo.type = p.readInt();
               switch(int(monsInfo.type))
               {
                  case 0:
                     monsInfo.ActionMovieName = "game.living.Living0012";
                     monsInfo.MissionID = 3101;
                     path = "living1";
                     break;
                  case 1:
                     monsInfo.ActionMovieName = "game.living.Living0014";
                     monsInfo.MissionID = 3102;
                     path = "living2";
                     break;
                  case 2:
                     monsInfo.ActionMovieName = "game.living.Living0013";
                     monsInfo.MissionID = 3103;
                     path = "living3";
               }
               monsInfo.MonsterName = "";
               monsInfo.State = p.readInt();
               monsInfo.MonsterPos = new Point(p.readInt(),p.readInt());
               if(monsInfo.State != 2 && !_sceneModel._mapObjects.hasKey(monsInfo.ID))
               {
                  queryLoader.addLoader(LoadResourceManager.Instance.createLoader(PathManager.solveChristmasMonsterPath(path),4));
                  _sceneModel._mapObjects.add(monsInfo.ID,monsInfo);
               }
               i++;
            }
            queryLoader.addEventListener("complete",__onLoadComplete);
            queryLoader.start();
         }
         else if(select == 1)
         {
            id = p.readInt();
            var _loc19_:int = 0;
            var _loc18_:* = _sceneModel._mapObjects;
            for each(var o in _sceneModel._mapObjects)
            {
               if(o.ID == id)
               {
                  _sceneModel._mapObjects.remove(o.ID);
               }
            }
         }
         else if(select == 2)
         {
            count = p.readInt();
            for(k = 0; k < count; )
            {
               monsterID = p.readInt();
               monsterX = p.readInt();
               monsterY = p.readInt();
               monsterState = p.readInt();
               if(_sceneModel._mapObjects && _sceneModel._mapObjects.hasKey(monsterID) && _sceneModel._mapObjects[monsterID].State != 1)
               {
                  _sceneModel._mapObjects[monsterID].State = monsterState;
                  _sceneModel._mapObjects[monsterID].MonsterNewPos = new Point(monsterX,monsterY);
               }
               k++;
            }
         }
         else if(select == 3)
         {
            ID = p.readInt();
            state = p.readInt();
            if(_sceneModel._mapObjects && _sceneModel._mapObjects.hasKey(ID))
            {
               _sceneModel._mapObjects[ID].State = state;
            }
         }
      }
      
      private function __onLoadComplete(pEvent:Event) : void
      {
         var loaderQueue:QueueLoader = pEvent.currentTarget as QueueLoader;
         if(loaderQueue.completeCount == _monsterCount)
         {
            loaderQueue.removeEvent();
         }
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
         ChristmasCoreManager.instance.removeEventListener("addplayer_room",__addPlayer);
         ChristmasCoreManager.instance.removeEventListener("christmas_move",__movePlayer);
         ChristmasCoreManager.instance.removeEventListener("christmas_exit",__removePlayer);
         ChristmasCoreManager.instance.removeEventListener("christmas_monster",__monstersEvent);
         ChristmasCoreManager.instance.removeEventListener("player_statue",__updatePlayerStauts);
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
         var i:int = 0;
         var playerInfo:* = null;
         var posx:int = 0;
         var posy:int = 0;
         var playerVO:* = null;
         var pkg:PackageIn = event.pkg;
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
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
            playerInfo.FightPower = pkg.readInt();
            playerInfo.WinCount = pkg.readInt();
            playerInfo.TotalCount = pkg.readInt();
            playerInfo.Offer = pkg.readInt();
            playerInfo.commitChanges();
            posx = pkg.readInt();
            posy = pkg.readInt();
            playerVO = new PlayerVO();
            playerVO.playerInfo = playerInfo;
            playerVO.playerPos = new Point(posx,posy);
            playerVO.playerStauts = pkg.readByte();
            if(playerInfo.ID != PlayerManager.Instance.Self.ID)
            {
               _sceneModel.addPlayer(playerVO);
            }
            i++;
         }
      }
      
      public function __removePlayer(event:CrazyTankSocketEvent) : void
      {
         var id:int = event.pkg.readInt();
         if(id == PlayerManager.Instance.Self.ID)
         {
            if(StateManager.currentStateType == "christmasroom")
            {
               _view.removeTimer();
               StateManager.setState("main");
            }
            else
            {
               ChristmasCoreManager.isTimeOver = true;
               _view.removeTimer();
            }
         }
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
         if(_view == null)
         {
            if(_sceneModel == null)
            {
               _sceneModel = new ChristmasRoomModel();
            }
            _view = new ChristmasRoomView(this,_sceneModel);
            _view.show();
         }
         _view.movePlayer(id,path);
      }
      
      override public function getType() : String
      {
         return "christmasroom";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("alertInChristmasRoom");
         CacheSysManager.getInstance().release("alertInChristmasRoom");
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
         CacheSysManager.unlock("alertInChristmasRoom");
         CacheSysManager.getInstance().release("alertInChristmasRoom");
         _isFirstCome = true;
         ChristmasCoreManager.isToRoom = false;
      }
   }
}
