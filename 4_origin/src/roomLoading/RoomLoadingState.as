package roomLoading
{
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import gameCommon.GameControl;
   import gameCommon.model.GameInfo;
   import par.ParticleManager;
   import par.ShapeManager;
   import room.RoomManager;
   import roomLoading.view.RoomLoadingView;
   import roomLoading.view.RoomLoadingView3D;
   import worldboss.WorldBossManager;
   
   public class RoomLoadingState extends BaseStateView
   {
       
      
      protected var _current:GameInfo;
      
      protected var _loadingView:RoomLoadingView;
      
      public function RoomLoadingState()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         StateManager.currentStateType = "gameLoading";
         _current = param2 as GameInfo;
         if(GameControl.Instance.is3DGame)
         {
            _loadingView = new RoomLoadingView3D(_current);
         }
         else
         {
            _loadingView = new RoomLoadingView(_current);
         }
         addChild(_loadingView);
         ChatManager.Instance.state = 9;
         ChatManager.Instance.view.visible = true;
         addChild(ChatManager.Instance.view);
         MainToolBar.Instance.hide();
         RoomManager.Instance.current.resetStates();
         if(RoomManager.Instance.current.selfRoomPlayer && RoomManager.Instance.current.selfRoomPlayer.isHost)
         {
            GameInSocketOut.sendPlayerState(2);
         }
         else
         {
            GameInSocketOut.sendPlayerState(0);
         }
         ChatManager.Instance.setFocus();
         WorldBossManager.Instance.isLoadingState = true;
         if(!StartupResourceLoader.firstEnterHall && !ShapeManager.ready)
         {
            ParticleManager.initPartical(PathManager.FLASHSITE);
         }
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         dispose();
         if(StateManager.isExitRoom(param1.getType()))
         {
            GameInSocketOut.sendGamePlayerExit();
            GameControl.Instance.reset();
            RoomManager.Instance.reset();
         }
         super.leaving(param1);
      }
      
      override public function getType() : String
      {
         return "roomLoading";
      }
      
      override public function dispose() : void
      {
         if(_loadingView)
         {
            _loadingView.dispose();
            _loadingView = null;
         }
         _current = null;
         if(RoomManager.Instance.current.type == 20)
         {
            return;
         }
         MainToolBar.Instance.enableAll();
      }
   }
}
