package room.view.states
{
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import room.RoomManager;
   import room.view.roomView.TeamRoomView;
   
   public class TeamRoomState extends BaseRoomState
   {
       
      
      public function TeamRoomState()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         _roomView = new TeamRoomView(RoomManager.Instance.current);
         PositionUtils.setPos(_roomView,"asset.ddtroom.matchroomstate.pos");
         addChild(_roomView);
         super.enter(param1,param2);
      }
      
      override public function getType() : String
      {
         return "teamRoom";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(param1);
      }
   }
}
