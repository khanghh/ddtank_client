package room.view.states
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import room.RoomManager;
   import room.view.roomView.MissionRoomView;
   
   public class MissionRoomState extends BaseRoomState
   {
       
      
      public function MissionRoomState()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         _roomView = new MissionRoomView(RoomManager.Instance.current);
         addChild(_roomView);
         MainToolBar.Instance.backFunction = leaveAlert;
         super.enter(param1,param2);
      }
      
      private function leaveAlert() : void
      {
         var _loc1_:* = null;
         if(RoomManager.Instance.current.selfRoomPlayer.isViewer)
         {
            StateManager.setState("dungeon");
         }
         else
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.missionsettle.dungeon.leaveConfirm.contents"),"",LanguageMgr.GetTranslation("cancel"),true,true,false,1);
            _loc1_.moveEnable = false;
            _loc1_.addEventListener("response",__onResponse);
         }
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            StateManager.setState("dungeon");
         }
      }
      
      override public function getType() : String
      {
         return "missionResult";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         MainToolBar.Instance.backFunction = null;
         super.leaving(param1);
      }
      
      override public function getBackType() : String
      {
         return "dungeon";
      }
   }
}
