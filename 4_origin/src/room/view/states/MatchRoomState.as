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
       
      
      public function MatchRoomState()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         _roomView = new MatchRoomView(RoomManager.Instance.current);
         PositionUtils.setPos(_roomView,"asset.ddtroom.matchroomstate.pos");
         addChild(_roomView);
         super.enter(param1,param2);
      }
      
      override protected function __startLoading(param1:Event) : void
      {
         super.__startLoading(param1);
         SocketManager.Instance.out.syncWeakStep(46);
      }
      
      override public function getType() : String
      {
         return "matchRoom";
      }
      
      override public function getBackType() : String
      {
         if(RoomManager.Instance.current.type == 41 || RoomManager.Instance.current.type == 42)
         {
            return "main";
         }
         return "roomlist";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(param1);
      }
   }
}
