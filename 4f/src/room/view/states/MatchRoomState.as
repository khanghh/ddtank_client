package room.view.states
{
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import room.RoomManager;
   import room.view.roomView.MatchRoomView;
   
   public class MatchRoomState extends BaseRoomState
   {
       
      
      public function MatchRoomState(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override protected function __startLoading(param1:Event) : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
   }
}
