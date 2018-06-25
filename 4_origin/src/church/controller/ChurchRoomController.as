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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         ChurchManager.instance.removeLoadingEvent();
         CacheSysManager.lock("alertInMarry");
         super.enter(prev,data);
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
         var beginDate:* = null;
         var diff:Number = NaN;
         var valid:Number = NaN;
         if(ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
         {
            beginDate = ChurchManager.instance.currentRoom.creactTime;
            diff = TimeManager.Instance.TotalDaysToNow(beginDate) * 24;
            valid = (ChurchManager.instance.currentRoom.valideTimes - diff) * 60;
            if(valid > 10)
            {
               stopTimer();
               timer = TimerManager.getInstance().addTimerJuggler((valid - 10) * 60 * 1000,1);
               timer.addEventListener("timerComplete",__timerComplete);
               timer.start();
            }
         }
      }
      
      private function __timerComplete(event:Event) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneControler.timerComplete"));
         var msg:ChatData = new ChatData();
         msg.channel = 6;
         msg.msg = LanguageMgr.GetTranslation("church.churchScene.SceneControler.timerComplete.msg");
         ChatManager.Instance.chat(msg);
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
      
      private function __continuation(event:PkgEvent) : void
      {
         if(ChurchManager.instance.currentRoom)
         {
            ChurchManager.instance.currentRoom.valideTimes = event.pkg.readInt();
         }
      }
      
      private function __updateValidTime(event:WeddingRoomEvent) : void
      {
         resetTimer();
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         dispose();
         ChurchManager.instance.currentRoom = null;
         ChurchManager.instance.currentScene = ChurchManager.instance.lastScene;
         SocketManager.Instance.out.sendExitRoom();
         super.leaving(next);
      }
      
      override public function getType() : String
      {
         return "churchRoom";
      }
      
      public function __addPlayer(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var playerInfo:PlayerInfo = new PlayerInfo();
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
         var posx:int = pkg.readInt();
         var posy:int = pkg.readInt();
         playerInfo.FightPower = pkg.readInt();
         playerInfo.WinCount = pkg.readInt();
         playerInfo.TotalCount = pkg.readInt();
         playerInfo.Offer = pkg.readInt();
         playerInfo.isOld = pkg.readBoolean();
         playerInfo.commitChanges();
         var playerVO:PlayerVO = new PlayerVO();
         playerVO.playerInfo = playerInfo;
         playerVO.playerPos = new Point(posx,posy);
         if(playerInfo.ID == PlayerManager.Instance.Self.ID)
         {
            return;
         }
         _sceneModel.addPlayer(playerVO);
      }
      
      public function __removePlayer(event:PkgEvent) : void
      {
         var id:int = event.pkg.clientId;
         if(id == PlayerManager.Instance.Self.ID)
         {
            StateManager.setState("ddtchurchroomlist");
         }
         else
         {
            if(ChurchManager.instance.currentRoom.status == "wedding_ing")
            {
               return;
            }
            _sceneModel.removePlayer(id);
         }
      }
      
      public function __movePlayer(event:PkgEvent) : void
      {
         var i:* = 0;
         var p:* = null;
         var id:int = event.pkg.clientId;
         var posX:int = event.pkg.readInt();
         var posY:int = event.pkg.readInt();
         var pathStr:String = event.pkg.readUTF();
         if(ChurchManager.instance.currentRoom.status == "wedding_ing")
         {
            return;
         }
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
      
      private function __updateWeddingStatus(event:WeddingRoomEvent) : void
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
         var beginDate:* = null;
         var diff:Number = NaN;
         var valid:Number = NaN;
         var spouse:* = null;
         if(ChurchManager.instance.isAdmin(PlayerManager.Instance.Self) && ChurchManager.instance.currentRoom.status != "wedding_ing")
         {
            beginDate = ChurchManager.instance.currentRoom.creactTime;
            diff = TimeManager.Instance.TotalDaysToNow(beginDate) * 24;
            valid = (ChurchManager.instance.currentRoom.valideTimes - diff) * 60;
            if(valid < 10)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneControler.startWedding.valid"));
               return;
            }
            spouse = _sceneModel.getPlayerFromID(PlayerManager.Instance.Self.SpouseID);
            if(!spouse)
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
      
      private function __frameEvent(event:FrameEvent) : void
      {
         var spouse:* = null;
         if(_baseAlerFrame)
         {
            _baseAlerFrame.removeEventListener("response",__frameEvent);
            _baseAlerFrame.dispose();
            _baseAlerFrame = null;
         }
         switch(int(event.responseCode))
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
               spouse = _sceneModel.getPlayerFromID(PlayerManager.Instance.Self.SpouseID);
               if(!spouse)
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
               spouse = _sceneModel.getPlayerFromID(PlayerManager.Instance.Self.SpouseID);
               if(!spouse)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.SceneControler.startWedding.spouse"));
                  return;
               }
               SocketManager.Instance.out.sendStartWedding();
               break;
         }
      }
      
      private function __startWedding(event:PkgEvent) : void
      {
         var roomID:int = event.pkg.readInt();
         var result:Boolean = event.pkg.readBoolean();
         if(result)
         {
            ChurchManager.instance.currentRoom.isStarted = true;
            ChurchManager.instance.currentRoom.status = "wedding_ing";
         }
      }
      
      private function __stopWedding(event:PkgEvent) : void
      {
         ChurchManager.instance.currentRoom.status = "wedding_none";
      }
      
      public function modifyDiscription(roomName:String, modifyPSW:Boolean, psw:String, discription:String) : void
      {
         SocketManager.Instance.out.sendModifyChurchDiscription(roomName,modifyPSW,psw,discription);
      }
      
      public function useFire(playerID:int, fireTemplateID:int) : void
      {
         _view.useFire(playerID,fireTemplateID);
      }
      
      private function __onUseFire(e:PkgEvent) : void
      {
         var userID:int = e.pkg.readInt();
         var fireID:int = e.pkg.readInt();
         useFire(userID,fireID);
      }
      
      private function __onUseSalute(event:PkgEvent) : void
      {
         var userID:int = event.pkg.readInt();
         setSaulte(userID);
      }
      
      public function setSaulte(id:int) : void
      {
         _view.setSaulte(id);
      }
      
      private function __sceneChange(event:WeddingRoomEvent) : void
      {
         readyEnterScene();
      }
      
      public function readyEnterScene() : void
      {
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         var switchMovie:WeddingRoomSwitchMovie = new WeddingRoomSwitchMovie(true,0.06);
         addChild(switchMovie);
         switchMovie.playMovie();
         switchMovie.addEventListener("switch complete",__readyEnterOk);
      }
      
      private function __readyEnterOk(event:Event) : void
      {
         event.currentTarget.removeEventListener("switch complete",__readyEnterOk);
         enterScene();
      }
      
      public function enterScene() : void
      {
         var pos:* = null;
         var sceneIndex:int = 0;
         _sceneModel.reset();
         if(ChurchManager.instance.currentScene != 0)
         {
            pos = new Point(514,637);
         }
         _view.setMap(pos);
         switch(int(ChurchManager.instance.currentScene))
         {
            case 0:
               sceneIndex = 0;
               break;
            case 1:
               sceneIndex = 1;
               break;
            case 2:
               sceneIndex = 2;
         }
         SocketManager.Instance.out.sendSceneChange(sceneIndex);
      }
      
      public function giftSubmit(money:uint) : void
      {
         SocketManager.Instance.out.sendChurchLargess(money);
      }
      
      public function roomContinuation(secondType:int) : void
      {
         SocketManager.Instance.out.sendChurchContinuation(secondType);
      }
      
      private function getWeddingMoney() : int
      {
         var money:int = 300;
         if(ChurchManager.instance.currentScene == 3)
         {
            money = 8000;
         }
         return money;
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
