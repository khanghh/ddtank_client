package church.controller
{
   import baglocked.BaglockedManager;
   import church.ChurchManager;
   import church.events.WeddingRoomEvent;
   import church.model.ChurchRoomModel;
   import church.view.weddingRoom.WeddingRoomSwitchMovie;
   import church.view.weddingRoom.WeddingRoomView;
   import church.vo.PlayerVO;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import ddt.view.chat.ChatData;
   import flash.events.Event;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ChurchRoomController extends BaseStateView
   {
      
      private static const RESTART_WEDDING_FEE:int = 300;
      
      private static const RESTART_COSTLYWEDDING_FEE:int = 8000;
       
      
      private var _sceneModel:ChurchRoomModel;
      
      private var _view:WeddingRoomView;
      
      private var timer:TimerJuggler;
      
      private var _baseAlerFrame:BaseAlerFrame;
      
      public function ChurchRoomController()
      {
         super();
      }
      
      override public function prepare() : void
      {
         super.prepare();
      }
      
      override public function getBackType() : String
      {
         return "ddtchurchroomlist";
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         ChurchManager.instance.removeLoadingEvent();
         CacheSysManager.lock("alertInMarry");
         super.enter(param1,param2);
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         SocketManager.Instance.out.sendCurrentState(0);
         MainToolBar.Instance.hide();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _sceneModel = new ChurchRoomModel();
         _view = new WeddingRoomView(this,_sceneModel);
         _view.show();
         resetTimer();
      }
      
      public function resetTimer() : void
      {
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
         {
            _loc3_ = ChurchManager.instance.currentRoom.creactTime;
            _loc2_ = TimeManager.Instance.TotalDaysToNow(_loc3_) * 24;
            _loc1_ = (ChurchManager.instance.currentRoom.valideTimes - _loc2_) * 60;
            if(_loc1_ > 10)
            {
               stopTimer();
               timer = TimerManager.getInstance().addTimerJuggler((_loc1_ - 10) * 60 * 1000,1);
               timer.addEventListener("timerComplete",__timerComplete);
               timer.start();
            }
         }
      }
      
      private function __timerComplete(param1:Event) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneControler.timerComplete"));
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 6;
         _loc2_.msg = LanguageMgr.GetTranslation("church.churchScene.SceneControler.timerComplete.msg");
         ChatManager.Instance.chat(_loc2_);
         stopTimer();
      }
      
      private function stopTimer() : void
      {
         if(timer)
         {
            timer.stop();
            timer.removeEventListener("timerComplete",__timerComplete);
            TimerManager.getInstance().removeJugglerByTimer(timer);
            timer = null;
         }
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(243),__addPlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(244),__removePlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(249,1),__movePlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(249,2),__startWedding);
         SocketManager.Instance.addEventListener(PkgEvent.format(249,3),__continuation);
         SocketManager.Instance.addEventListener(PkgEvent.format(249,9),__stopWedding);
         SocketManager.Instance.addEventListener(PkgEvent.format(249,6),__onUseFire);
         SocketManager.Instance.addEventListener(PkgEvent.format(249,11),__onUseSalute);
         ChurchManager.instance.currentRoom.addEventListener("wedding status change",__updateWeddingStatus);
         ChurchManager.instance.currentRoom.addEventListener("valide time change",__updateValidTime);
         ChurchManager.instance.addEventListener("scene change",__sceneChange);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(243),__addPlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(244),__removePlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(249,1),__movePlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(249,2),__startWedding);
         SocketManager.Instance.removeEventListener(PkgEvent.format(249,3),__continuation);
         SocketManager.Instance.removeEventListener(PkgEvent.format(249,9),__stopWedding);
         SocketManager.Instance.removeEventListener(PkgEvent.format(249,6),__onUseFire);
         SocketManager.Instance.removeEventListener(PkgEvent.format(249,11),__onUseSalute);
         ChurchManager.instance.currentRoom.removeEventListener("wedding status change",__updateWeddingStatus);
         ChurchManager.instance.currentRoom.removeEventListener("valide time change",__updateValidTime);
         ChurchManager.instance.removeEventListener("scene change",__sceneChange);
      }
      
      private function __continuation(param1:PkgEvent) : void
      {
         if(ChurchManager.instance.currentRoom)
         {
            ChurchManager.instance.currentRoom.valideTimes = param1.pkg.readInt();
         }
      }
      
      private function __updateValidTime(param1:WeddingRoomEvent) : void
      {
         resetTimer();
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         dispose();
         ChurchManager.instance.currentRoom = null;
         ChurchManager.instance.currentScene = ChurchManager.instance.lastScene;
         SocketManager.Instance.out.sendExitRoom();
         super.leaving(param1);
      }
      
      override public function getType() : String
      {
         return "churchRoom";
      }
      
      public function __addPlayer(param1:PkgEvent) : void
      {
         var _loc5_:PackageIn = param1.pkg;
         var _loc6_:PlayerInfo = new PlayerInfo();
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
         var _loc4_:int = _loc5_.readInt();
         var _loc2_:int = _loc5_.readInt();
         _loc6_.FightPower = _loc5_.readInt();
         _loc6_.WinCount = _loc5_.readInt();
         _loc6_.TotalCount = _loc5_.readInt();
         _loc6_.Offer = _loc5_.readInt();
         _loc6_.isOld = _loc5_.readBoolean();
         _loc6_.commitChanges();
         var _loc3_:PlayerVO = new PlayerVO();
         _loc3_.playerInfo = _loc6_;
         _loc3_.playerPos = new Point(_loc4_,_loc2_);
         if(_loc6_.ID == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         _sceneModel.addPlayer(_loc3_);
      }
      
      public function __removePlayer(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.clientId;
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            StateManager.setState("ddtchurchroomlist");
         }
         else
         {
            if(ChurchManager.instance.currentRoom.status == "wedding_ing")
            {
               return;
            }
            _sceneModel.removePlayer(_loc2_);
         }
      }
      
      public function __movePlayer(param1:PkgEvent) : void
      {
         var _loc9_:* = 0;
         var _loc6_:* = null;
         var _loc2_:int = param1.pkg.clientId;
         var _loc5_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         var _loc8_:String = param1.pkg.readUTF();
         if(ChurchManager.instance.currentRoom.status == "wedding_ing")
         {
            return;
         }
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
      
      private function __updateWeddingStatus(param1:WeddingRoomEvent) : void
      {
         if(ChurchManager.instance.currentScene != 0)
         {
            _view.switchWeddingView();
         }
      }
      
      public function playWeddingMovie() : void
      {
         _view.playerWeddingMovie();
      }
      
      public function startWedding() : void
      {
         var _loc4_:* = null;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc3_:* = null;
         if(ChurchManager.instance.isAdmin(PlayerManager.Instance.Self) && ChurchManager.instance.currentRoom.status != "wedding_ing")
         {
            _loc4_ = ChurchManager.instance.currentRoom.creactTime;
            _loc2_ = TimeManager.Instance.TotalDaysToNow(_loc4_) * 24;
            _loc1_ = (ChurchManager.instance.currentRoom.valideTimes - _loc2_) * 60;
            if(_loc1_ < 10)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneControler.startWedding.valid"));
               return;
            }
            _loc3_ = _sceneModel.getPlayerFromID(PlayerManager.Instance.Self.SpouseID);
            if(!_loc3_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneControler.startWedding.spouse"));
               return;
            }
            if(ChurchManager.instance.currentRoom.isStarted)
            {
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               _baseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("church.churchScene.SceneControler.startWedding.isStarted",getWeddingMoney()),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
               _baseAlerFrame.addEventListener("response",__frameEvent);
               return;
            }
            SocketManager.Instance.out.sendStartWedding();
         }
      }
      
      private function __frameEvent(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__frameEvent);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         switch(int(param1.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               if(PlayerManager.Instance.Self.Money < 300)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               _loc2_ = _sceneModel.getPlayerFromID(PlayerManager.Instance.Self.SpouseID);
               if(!_loc2_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneControler.startWedding.spouse"));
                  return;
               }
               SocketManager.Instance.out.sendStartWedding();
               break;
            default:
               if(PlayerManager.Instance.Self.Money < 300)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               _loc2_ = _sceneModel.getPlayerFromID(PlayerManager.Instance.Self.SpouseID);
               if(!_loc2_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneControler.startWedding.spouse"));
                  return;
               }
               SocketManager.Instance.out.sendStartWedding();
               break;
         }
      }
      
      private function __startWedding(param1:PkgEvent) : void
      {
         var _loc3_:int = param1.pkg.readInt();
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            ChurchManager.instance.currentRoom.isStarted = true;
            ChurchManager.instance.currentRoom.status = "wedding_ing";
         }
      }
      
      private function __stopWedding(param1:PkgEvent) : void
      {
         ChurchManager.instance.currentRoom.status = "wedding_none";
      }
      
      public function modifyDiscription(param1:String, param2:Boolean, param3:String, param4:String) : void
      {
         SocketManager.Instance.out.sendModifyChurchDiscription(param1,param2,param3,param4);
      }
      
      public function useFire(param1:int, param2:int) : void
      {
         _view.useFire(param1,param2);
      }
      
      private function __onUseFire(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         useFire(_loc2_,_loc3_);
      }
      
      private function __onUseSalute(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         setSaulte(_loc2_);
      }
      
      public function setSaulte(param1:int) : void
      {
         _view.setSaulte(param1);
      }
      
      private function __sceneChange(param1:WeddingRoomEvent) : void
      {
         readyEnterScene();
      }
      
      public function readyEnterScene() : void
      {
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         var _loc1_:WeddingRoomSwitchMovie = new WeddingRoomSwitchMovie(true,0.06);
         addChild(_loc1_);
         _loc1_.playMovie();
         _loc1_.addEventListener("switch complete",__readyEnterOk);
      }
      
      private function __readyEnterOk(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("switch complete",__readyEnterOk);
         enterScene();
      }
      
      public function enterScene() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         _sceneModel.reset();
         if(ChurchManager.instance.currentScene != 0)
         {
            _loc2_ = new Point(514,637);
         }
         _view.setMap(_loc2_);
         switch(int(ChurchManager.instance.currentScene))
         {
            case 0:
               _loc1_ = 0;
               break;
            case 1:
               _loc1_ = 1;
               break;
            case 2:
               _loc1_ = 2;
         }
         SocketManager.Instance.out.sendSceneChange(_loc1_);
      }
      
      public function giftSubmit(param1:uint) : void
      {
         SocketManager.Instance.out.sendChurchLargess(param1);
      }
      
      public function roomContinuation(param1:int) : void
      {
         SocketManager.Instance.out.sendChurchContinuation(param1);
      }
      
      private function getWeddingMoney() : int
      {
         var _loc1_:int = 300;
         if(ChurchManager.instance.currentScene == 3)
         {
            _loc1_ = 8000;
         }
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         stopTimer();
         if(_sceneModel)
         {
            _sceneModel.dispose();
         }
         _sceneModel = null;
         if(_view)
         {
            if(_view.parent)
            {
               _view.parent.removeChild(_view);
            }
            _view.dispose();
         }
         _view = null;
         CacheSysManager.unlock("alertInMarry");
         CacheSysManager.getInstance().release("alertInMarry");
      }
   }
}
