package room.view.states
{
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import room.RoomManager;
   import room.view.roomView.DreamLandRoomView;
   
   public class DreamLandChallengeRoomState extends BaseRoomState
   {
       
      
      public function DreamLandChallengeRoomState()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         _roomView = new DreamLandRoomView(RoomManager.Instance.current);
         PositionUtils.setPos(_roomView,"asset.ddtroom.matchroomstate.pos");
         addChild(_roomView);
         super.enter(prev,data);
      }
      
      override public function getType() : String
      {
         return "dreamLandRoom";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
   }
}
