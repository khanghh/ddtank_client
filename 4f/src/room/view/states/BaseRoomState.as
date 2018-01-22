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
      
      public function BaseRoomState(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      protected function initEvents() : void{}
      
      protected function removeEvents() : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      protected function __startLoading(param1:Event) : void{}
      
      private function __onFightNpc(param1:CrazyTankSocketEvent) : void{}
   }
}
