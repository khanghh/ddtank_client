package catchInsect.view
{
   import catchInsect.CatchInsectControl;
   import catchInsect.CatchInsectManager;
   import catchInsect.CatchInsectRoomModel;
   import catchInsect.PlayerVO;
   import catchInsect.data.InsectInfo;
   import catchInsect.event.CatchInsectEvent;
   import catchInsect.event.CatchInsectRoomEvent;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.KeyboardShortcutsManager;
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
   
   public class CatchInsectRoomController extends BaseStateView
   {
      
      private static var _isFirstCome:Boolean = true;
      
      public static var isTimeOver:Boolean;
      
      private static var _instance:CatchInsectRoomController;
       
      
      private var _sceneModel:CatchInsectRoomModel;
      
      private var _waitingView:WaitingCatchInsectView;
      
      protected var _monsters:DictionaryData;
      
      private var _monsterCount:int = 0;
      
      private var _callback:Function;
      
      private var _callbackArg:int;
      
      private var _roomViewFlag:Boolean;
      
      public function CatchInsectRoomController()
      {
         super();
      }
      
      public static function get Instance() : CatchInsectRoomController
      {
         if(!_instance)
         {
            _instance = new CatchInsectRoomController();
         }
         return _instance;
      }
      
      public function get sceneModel() : CatchInsectRoomModel
      {
         return _sceneModel;
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("catchInsectScene");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         GameLoadingManager.Instance.hide();
         super.enter(prev,data);
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         MainToolBar.Instance.hide();
         addEvent();
         if(CatchInsectManager.isToRoom)
         {
            setSelfStatus(0);
            SocketManager.Instance.out.enterOrLeaveInsectScene(2,CatchInsectManager.instance.catchInsectInfo.myPlayerVO.playerPos);
         }
         else
         {
            SocketManager.Instance.out.enterOrLeaveInsectScene(2,CatchInsectManager.instance.catchInsectInfo.playerDefaultPos);
         }
         if(_isFirstCome)
         {
            init();
            _isFirstCome = false;
         }
         else if(_roomViewFlag)
         {
            CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectSetViewAgain"));
         }
         if(_callback != null)
         {
            _callback(_callbackArg);
         }
      }
      
      private function init() : void
      {
         _sceneModel = new CatchInsectRoomModel();
         var data:Object = {};
         data["view"] = this;
         data["model"] = _sceneModel;
         _roomViewFlag = true;
         CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectCreatRoomView",data));
         _waitingView = new WaitingCatchInsectView();
         addChild(_waitingView);
         _waitingView.visible = false;
         _waitingView.addEventListener("enterGameTimeOut",__onTimeOut);
      }
      
      protected function __onTimeOut(event:Event) : void
      {
         _waitingView.stop();
         _waitingView.visible = false;
         CatchInsectManager.instance.exitGame();
      }
      
      private function addEvent() : void
      {
         CatchInsectManager.instance.addEventListener("addplayer_room",__addPlayer);
         CatchInsectManager.instance.addEventListener("move",__movePlayer);
         CatchInsectManager.instance.addEventListener("player_statue",__updatePlayerStauts);
         CatchInsectManager.instance.addEventListener("removePlayer",__removePlayer);
         CatchInsectManager.instance.addEventListener("addMonster",__monstersEvent);
         CatchInsectManager.instance.addEventListener("fightMonster",__fightMonsterEvent);
      }
      
      public function __updatePlayerStauts(event:CatchInsectEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var data:Object = {};
         data["id"] = pkg.readInt();
         data["stauts"] = pkg.readByte();
         data["point"] = new Point(pkg.readInt(),pkg.readInt());
         CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectUpdatePlayerState",data));
         _sceneModel.updatePlayerStauts(data["id"],data["stauts"],data["point"]);
      }
      
      private function __monstersEvent(pEvent:CatchInsectEvent) : void
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
               monsInfo = new InsectInfo();
               monsInfo.ID = p.readInt();
               monsInfo.type = p.readInt();
               switch(int(monsInfo.type))
               {
                  case 0:
                     monsInfo.ActionMovieName = "game.living.Living387";
                     monsInfo.MissionID = 70007;
                     path = "living387";
                     break;
                  case 1:
                     monsInfo.ActionMovieName = "game.living.Living389";
                     monsInfo.MissionID = 70009;
                     path = "living389";
                     break;
                  case 2:
                     monsInfo.ActionMovieName = "game.living.Living388";
                     monsInfo.MissionID = 70008;
                     path = "living388";
               }
               monsInfo.MonsterName = "";
               monsInfo.State = p.readInt();
               monsInfo.MonsterPos = new Point(p.readInt(),p.readInt());
               if(monsInfo.State != 2 && !_sceneModel._mapObjects.hasKey(monsInfo.ID))
               {
                  queryLoader.addLoader(LoadResourceManager.Instance.createLoader(CatchInsectManager.instance.solveMonsterPath(path),4));
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
      
      private function __fightMonsterEvent(pEvent:CatchInsectEvent) : void
      {
         var path:* = null;
         var bornPos:* = null;
         if(CatchInsectControl.instance.refMonsID != 0)
         {
            _sceneModel._mapObjects.remove(CatchInsectControl.instance.refMonsID);
         }
         var preIsRef:int = pEvent.pkg.readInt();
         var queryLoader:QueueLoader = new QueueLoader();
         var monsInfo:InsectInfo = new InsectInfo();
         monsInfo.ID = pEvent.pkg.readInt();
         monsInfo.type = pEvent.pkg.readInt();
         CatchInsectControl.instance.refMonsID = monsInfo.ID;
         CatchInsectControl.instance.isUnicorn = pEvent.pkg.readBoolean();
         if(monsInfo.ID != 0)
         {
            CatchInsectControl.instance.isRefreshMonster = true;
            path = "";
            switch(int(monsInfo.type))
            {
               case 0:
                  monsInfo.ActionMovieName = "game.living.Living387";
                  monsInfo.MissionID = 70007;
                  path = "living387";
                  break;
               case 1:
                  monsInfo.ActionMovieName = "game.living.Living389";
                  monsInfo.MissionID = 70009;
                  path = "living389";
                  break;
               case 2:
                  monsInfo.ActionMovieName = "game.living.Living388";
                  monsInfo.MissionID = 70008;
                  path = "living388";
            }
            monsInfo.MonsterName = "";
            bornPos = CatchInsectManager.instance.catchInsectInfo.myPlayerVO.currentWalkStartPoint;
            monsInfo.MonsterPos = bornPos;
            if(monsInfo.State != 2 && !_sceneModel._mapObjects.hasKey(monsInfo.ID))
            {
               queryLoader.addLoader(LoadResourceManager.Instance.createLoader(CatchInsectManager.instance.solveMonsterPath(path),4));
               _sceneModel._mapObjects.add(monsInfo.ID,monsInfo);
            }
            queryLoader.addEventListener("complete",__onLoadComplete);
            queryLoader.start();
         }
         else
         {
            CatchInsectControl.instance.isRefreshMonster = false;
         }
         CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("updatefightMonster"));
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
         if(_roomViewFlag)
         {
            CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectUpdateSelfState",value));
         }
         else
         {
            _callback = setSelfStatus;
            _callbackArg = value;
         }
      }
      
      private function removeEvent() : void
      {
         CatchInsectManager.instance.removeEventListener("addplayer_room",__addPlayer);
         CatchInsectManager.instance.removeEventListener("move",__movePlayer);
         CatchInsectManager.instance.removeEventListener("removePlayer",__removePlayer);
         CatchInsectManager.instance.removeEventListener("addMonster",__monstersEvent);
         CatchInsectManager.instance.removeEventListener("fightMonster",__fightMonsterEvent);
         CatchInsectManager.instance.removeEventListener("player_statue",__updatePlayerStauts);
         if(_waitingView)
         {
            _waitingView.removeEventListener("enterGameTimeOut",__onTimeOut);
         }
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      public function __addPlayer(event:CatchInsectEvent) : void
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
      
      public function __removePlayer(event:CatchInsectEvent) : void
      {
         var id:int = event.pkg.readInt();
         if(id == PlayerManager.Instance.Self.ID)
         {
            if(StateManager.currentStateType == "catchInsect")
            {
               StateManager.setState("main");
            }
            else
            {
               isTimeOver = true;
            }
         }
         _sceneModel.removePlayer(id);
      }
      
      public function __movePlayer(event:CatchInsectEvent) : void
      {
         var i:* = 0;
         var p:* = null;
         var data:* = null;
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
         if(!_roomViewFlag)
         {
            if(_sceneModel == null)
            {
               _sceneModel = new CatchInsectRoomModel();
            }
            _roomViewFlag = true;
            data = {};
            data["view"] = this;
            data["model"] = _sceneModel;
            CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectCreatRoomView",data));
         }
         var moveData:Object = {};
         moveData["id"] = id;
         moveData["path"] = path;
         CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectMovePlayer",moveData));
      }
      
      override public function getType() : String
      {
         return "catchInsect";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("catchInsectScene");
         CacheSysManager.getInstance().release("catchInsectScene");
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
         _roomViewFlag = false;
         _sceneModel = null;
         CacheSysManager.unlock("catchInsectScene");
         CacheSysManager.getInstance().release("catchInsectScene");
         _isFirstCome = true;
         CatchInsectManager.isToRoom = false;
      }
   }
}
