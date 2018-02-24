package room.view.states
{
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import room.RoomManager;
   import room.view.roomView.TeamRoomView;
   
   public class TeamRoomState extends BaseRoomState
   {
       
      
      public function TeamRoomState(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
   }
}
