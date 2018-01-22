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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("alertInChristmasRoom");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         GameLoadingManager.Instance.hide();
         super.enter(param1,param2);
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
      
      protected function __onTimeOut(param1:Event) : void
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
      
      public function __updatePlayerStauts(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc5_:int = _loc4_.readByte();
         var _loc3_:Point = new Point(_loc4_.readInt(),_loc4_.readInt());
         _view.updatePlayerStauts(_loc2_,_loc5_,_loc3_);
         _sceneModel.updatePlayerStauts(_loc2_,_loc5_,_loc3_);
      }
      
      private function __monstersEvent(param1:CrazyTankSocketEvent) : void
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
               _loc2_ = new MonsterInfo();
               _loc2_.ID = _loc14_.readInt();
               _loc2_.type = _loc14_.readInt();
               switch(int(_loc2_.type))
               {
                  case 0:
                     _loc2_.ActionMovieName = "game.living.Living0012";
                     _loc2_.MissionID = 3101;
                     _loc17_ = "living1";
                     break;
                  case 1:
                     _loc2_.ActionMovieName = "game.living.Living0014";
                     _loc2_.MissionID = 3102;
                     _loc17_ = "living2";
                     break;
                  case 2:
                     _loc2_.ActionMovieName = "game.living.Living0013";
                     _loc2_.MissionID = 3103;
                     _loc17_ = "living3";
               }
               _loc2_.MonsterName = "";
               _loc2_.State = _loc14_.readInt();
               _loc2_.MonsterPos = new Point(_loc14_.readInt(),_loc14_.readInt());
               if(_loc2_.State != 2 && !_sceneModel._mapObjects.hasKey(_loc2_.ID))
               {
                  _loc10_.addLoader(LoadResourceManager.Instance.createLoader(PathManager.solveChristmasMonsterPath(_loc17_),4));
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
      
      public function __addPlayer(param1:CrazyTankSocketEvent) : void
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
      
      public function __removePlayer(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
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
         if(_view == null)
         {
            if(_sceneModel == null)
            {
               _sceneModel = new ChristmasRoomModel();
            }
            _view = new ChristmasRoomView(this,_sceneModel);
            _view.show();
         }
         _view.movePlayer(_loc2_,_loc7_);
      }
      
      override public function getType() : String
      {
         return "christmasroom";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("alertInChristmasRoom");
         CacheSysManager.getInstance().release("alertInChristmasRoom");
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
         CacheSysManager.unlock("alertInChristmasRoom");
         CacheSysManager.getInstance().release("alertInChristmasRoom");
         _isFirstCome = true;
         ChristmasCoreManager.isToRoom = false;
      }
   }
}
