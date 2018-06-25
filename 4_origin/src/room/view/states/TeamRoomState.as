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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         _roomView = new TeamRoomView(RoomManager.Instance.current);
         PositionUtils.setPos(_roomView,"asset.ddtroom.matchroomstate.pos");
         addChild(_roomView);
         super.enter(prev,data);
      }
      
      override public function getType() : String
      {
         return "teamRoom";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(next);
      }
   }
}
