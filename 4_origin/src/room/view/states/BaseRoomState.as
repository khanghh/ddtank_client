package room.view.states
{
   import academy.AcademyManager;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import gameCommon.GameControl;
   import hall.tasktrack.HallTaskTrackManager;
   import par.ParticleManager;
   import par.ShapeManager;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.view.roomView.BaseRoomView;
   
   public class BaseRoomState extends BaseStateView
   {
       
      
      protected var _info:RoomInfo;
      
      protected var _roomView:BaseRoomView;
      
      public function BaseRoomState()
      {
         super();
         if(!StartupResourceLoader.firstEnterHall && !ShapeManager.ready)
         {
            ParticleManager.initPartical(PathManager.FLASHSITE);
         }
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         if(!StartupResourceLoader.firstEnterHall)
         {
            SoundManager.instance.playMusic("065");
         }
         _info = RoomManager.Instance.current;
         MainToolBar.Instance.show();
         if(_info.selfRoomPlayer.isViewer)
         {
            MainToolBar.Instance.setRoomStartState();
            MainToolBar.Instance.setReturnEnable(true);
         }
         MainToolBar.Instance.setReturnEnable(true);
         if(PlayerManager.Instance.hasTempStyle)
         {
            PlayerManager.Instance.readAllTempStyleEvent();
         }
         initEvents();
         CacheSysManager.unlock("alertInFight");
         CacheSysManager.getInstance().release("alertInFight",1200);
         addChild(ChatManager.Instance.view);
         ChatManager.Instance.state = 5;
         ChatManager.Instance.setFocus();
         AcademyManager.Instance.showAlert();
         PlayerManager.Instance.Self.sendOverTimeListByBody();
         HallTaskTrackManager.instance.checkOpenCommitView();
      }
      
      protected function initEvents() : void
      {
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_1 = true;
      }
      
      protected function removeEvents() : void
      {
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_8 = true;
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         removeEvents();
         if(_roomView)
         {
            _roomView.dispose();
            _roomView = null;
         }
         _info = null;
         if(StateManager.isExitRoom(param1.getType()))
         {
            GameInSocketOut.sendGamePlayerExit();
            GameControl.Instance.reset();
            RoomManager.Instance.reset();
         }
         MainToolBar.Instance.enableAll();
         super.leaving(param1);
         PlayerManager.Instance.Self.sendOverTimeListByBody();
      }
      
      protected function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function __onFightNpc(param1:CrazyTankSocketEvent) : void
      {
      }
   }
}
