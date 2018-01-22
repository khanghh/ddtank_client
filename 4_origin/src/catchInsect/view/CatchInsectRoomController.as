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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("catchInsectScene");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         GameLoadingManager.Instance.hide();
         super.enter(param1,param2);
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
         var _loc1_:Object = {};
         _loc1_["view"] = this;
         _loc1_["model"] = _sceneModel;
         _roomViewFlag = true;
         CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectCreatRoomView",_loc1_));
         _waitingView = new WaitingCatchInsectView();
         addChild(_waitingView);
         _waitingView.visible = false;
         _waitingView.addEventListener("enterGameTimeOut",__onTimeOut);
      }
      
      protected function __onTimeOut(param1:Event) : void
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
      
      public function __updatePlayerStauts(param1:CatchInsectEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Object = {};
         _loc2_["id"] = _loc3_.readInt();
         _loc2_["stauts"] = _loc3_.readByte();
         _loc2_["point"] = new Point(_loc3_.readInt(),_loc3_.readInt());
         CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectUpdatePlayerState",_loc2_));
         _sceneModel.updatePlayerStauts(_loc2_["id"],_loc2_["stauts"],_loc2_["point"]);
      }
      
      private function __monstersEvent(param1:CatchInsectEvent) : void
      {
         var _loc12_:int = 0;
         var _loc2_:* = null;
         var _loc13_:int = 0;
         var _loc3_:int = 0;
         var _loc11_:int = 0;
         var _loc15_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc16_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:QueueLoader = new QueueLoader();
         var _loc14_:PackageIn = param1.pkg;
         var _loc4_:int = _loc14_.readByte();
         var _loc17_:String = "";
         if(_loc4_ == 0)
         {
            _monsterCount = _loc14_.readInt();
            _loc12_ = 0;
            while(_loc12_ < _monsterCount)
            {
               _loc2_ = new InsectInfo();
               _loc2_.ID = _loc14_.readInt();
               _loc2_.type = _loc14_.readInt();
               switch(int(_loc2_.type))
               {
                  case 0:
                     _loc2_.ActionMovieName = "game.living.Living387";
                     _loc2_.MissionID = 70007;
                     _loc17_ = "living387";
                     break;
                  case 1:
                     _loc2_.ActionMovieName = "game.living.Living389";
                     _loc2_.MissionID = 70009;
                     _loc17_ = "living389";
                     break;
                  case 2:
                     _loc2_.ActionMovieName = "game.living.Living388";
                     _loc2_.MissionID = 70008;
                     _loc17_ = "living388";
               }
               _loc2_.MonsterName = "";
               _loc2_.State = _loc14_.readInt();
               _loc2_.MonsterPos = new Point(_loc14_.readInt(),_loc14_.readInt());
               if(_loc2_.State != 2 && !_sceneModel._mapObjects.hasKey(_loc2_.ID))
               {
                  _loc10_.addLoader(LoadResourceManager.Instance.createLoader(CatchInsectManager.instance.solveMonsterPath(_loc17_),4));
                  _sceneModel._mapObjects.add(_loc2_.ID,_loc2_);
               }
               _loc12_++;
            }
            _loc10_.addEventListener("complete",__onLoadComplete);
            _loc10_.start();
         }
         else if(_loc4_ == 1)
         {
            _loc13_ = _loc14_.readInt();
            var _loc19_:int = 0;
            var _loc18_:* = _sceneModel._mapObjects;
            for each(var _loc6_ in _sceneModel._mapObjects)
            {
               if(_loc6_.ID == _loc13_)
               {
                  _sceneModel._mapObjects.remove(_loc6_.ID);
               }
            }
         }
         else if(_loc4_ == 2)
         {
            _loc3_ = _loc14_.readInt();
            _loc11_ = 0;
            while(_loc11_ < _loc3_)
            {
               _loc15_ = _loc14_.readInt();
               _loc8_ = _loc14_.readInt();
               _loc9_ = _loc14_.readInt();
               _loc7_ = _loc14_.readInt();
               if(_sceneModel._mapObjects && _sceneModel._mapObjects.hasKey(_loc15_) && _sceneModel._mapObjects[_loc15_].State != 1)
               {
                  _sceneModel._mapObjects[_loc15_].State = _loc7_;
                  _sceneModel._mapObjects[_loc15_].MonsterNewPos = new Point(_loc8_,_loc9_);
               }
               _loc11_++;
            }
         }
         else if(_loc4_ == 3)
         {
            _loc16_ = _loc14_.readInt();
            _loc5_ = _loc14_.readInt();
            if(_sceneModel._mapObjects && _sceneModel._mapObjects.hasKey(_loc16_))
            {
               _sceneModel._mapObjects[_loc16_].State = _loc5_;
            }
         }
      }
      
      private function __fightMonsterEvent(param1:CatchInsectEvent) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(CatchInsectControl.instance.refMonsID != 0)
         {
            _sceneModel._mapObjects.remove(CatchInsectControl.instance.refMonsID);
         }
         var _loc3_:int = param1.pkg.readInt();
         var _loc6_:QueueLoader = new QueueLoader();
         var _loc2_:InsectInfo = new InsectInfo();
         _loc2_.ID = param1.pkg.readInt();
         _loc2_.type = param1.pkg.readInt();
         CatchInsectControl.instance.refMonsID = _loc2_.ID;
         CatchInsectControl.instance.isUnicorn = param1.pkg.readBoolean();
         if(_loc2_.ID != 0)
         {
            CatchInsectControl.instance.isRefreshMonster = true;
            _loc5_ = "";
            switch(int(_loc2_.type))
            {
               case 0:
                  _loc2_.ActionMovieName = "game.living.Living387";
                  _loc2_.MissionID = 70007;
                  _loc5_ = "living387";
                  break;
               case 1:
                  _loc2_.ActionMovieName = "game.living.Living389";
                  _loc2_.MissionID = 70009;
                  _loc5_ = "living389";
                  break;
               case 2:
                  _loc2_.ActionMovieName = "game.living.Living388";
                  _loc2_.MissionID = 70008;
                  _loc5_ = "living388";
            }
            _loc2_.MonsterName = "";
            _loc4_ = CatchInsectManager.instance.catchInsectInfo.myPlayerVO.currentWalkStartPoint;
            _loc2_.MonsterPos = _loc4_;
            if(_loc2_.State != 2 && !_sceneModel._mapObjects.hasKey(_loc2_.ID))
            {
               _loc6_.addLoader(LoadResourceManager.Instance.createLoader(CatchInsectManager.instance.solveMonsterPath(_loc5_),4));
               _sceneModel._mapObjects.add(_loc2_.ID,_loc2_);
            }
            _loc6_.addEventListener("complete",__onLoadComplete);
            _loc6_.start();
         }
         else
         {
            CatchInsectControl.instance.isRefreshMonster = false;
         }
         CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("updatefightMonster"));
      }
      
      private function __onLoadComplete(param1:Event) : void
      {
         var _loc2_:QueueLoader = param1.currentTarget as QueueLoader;
         if(_loc2_.completeCount == _monsterCount)
         {
            _loc2_.removeEvent();
         }
      }
      
      public function setSelfStatus(param1:int) : void
      {
         if(_roomViewFlag)
         {
            CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectUpdateSelfState",param1));
         }
         else
         {
            _callback = setSelfStatus;
            _callbackArg = param1;
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
      
      public function __addPlayer(param1:CatchInsectEvent) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc6_:int = _loc5_.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = new PlayerInfo();
            _loc7_.beginChanges();
            _loc7_.Grade = _loc5_.readInt();
            _loc7_.Hide = _loc5_.readInt();
            _loc7_.Repute = _loc5_.readInt();
            _loc7_.ID = _loc5_.readInt();
            _loc7_.NickName = _loc5_.readUTF();
            _loc7_.typeVIP = _loc5_.readByte();
            _loc7_.VIPLevel = _loc5_.readInt();
            _loc7_.Sex = _loc5_.readBoolean();
            _loc7_.Style = _loc5_.readUTF();
            _loc7_.Colors = _loc5_.readUTF();
            _loc7_.Skin = _loc5_.readUTF();
            _loc7_.FightPower = _loc5_.readInt();
            _loc7_.WinCount = _loc5_.readInt();
            _loc7_.TotalCount = _loc5_.readInt();
            _loc7_.Offer = _loc5_.readInt();
            _loc7_.commitChanges();
            _loc4_ = _loc5_.readInt();
            _loc2_ = _loc5_.readInt();
            _loc3_ = new PlayerVO();
            _loc3_.playerInfo = _loc7_;
            _loc3_.playerPos = new Point(_loc4_,_loc2_);
            _loc3_.playerStauts = _loc5_.readByte();
            if(_loc7_.ID != PlayerManager.Instance.Self.ID)
            {
               _sceneModel.addPlayer(_loc3_);
            }
            _loc8_++;
         }
      }
      
      public function __removePlayer(param1:CatchInsectEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
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
         _sceneModel.removePlayer(_loc2_);
      }
      
      public function __movePlayer(param1:CatchInsectEvent) : void
      {
         var _loc11_:* = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc2_:int = param1.pkg.readInt();
         var _loc6_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         var _loc10_:String = param1.pkg.readUTF();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         var _loc5_:Array = _loc10_.split(",");
         var _loc9_:Array = [];
         _loc11_ = uint(0);
         while(_loc11_ < _loc5_.length)
         {
            _loc7_ = new Point(_loc5_[_loc11_],_loc5_[_loc11_ + 1]);
            _loc9_.push(_loc7_);
            _loc11_ = uint(_loc11_ + 2);
         }
         if(!_roomViewFlag)
         {
            if(_sceneModel == null)
            {
               _sceneModel = new CatchInsectRoomModel();
            }
            _roomViewFlag = true;
            _loc8_ = {};
            _loc8_["view"] = this;
            _loc8_["model"] = _sceneModel;
            CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectCreatRoomView",_loc8_));
         }
         var _loc4_:Object = {};
         _loc4_["id"] = _loc2_;
         _loc4_["path"] = _loc9_;
         CatchInsectManager.instance.dispatchEvent(new CatchInsectRoomEvent("catchInsectMovePlayer",_loc4_));
      }
      
      override public function getType() : String
      {
         return "catchInsect";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("catchInsectScene");
         CacheSysManager.getInstance().release("catchInsectScene");
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
         _roomViewFlag = false;
         _sceneModel = null;
         CacheSysManager.unlock("catchInsectScene");
         CacheSysManager.getInstance().release("catchInsectScene");
         _isFirstCome = true;
         CatchInsectManager.isToRoom = false;
      }
   }
}
