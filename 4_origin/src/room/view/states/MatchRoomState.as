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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         _roomView = new MatchRoomView(RoomManager.Instance.current);
         PositionUtils.setPos(_roomView,"asset.ddtroom.matchroomstate.pos");
         addChild(_roomView);
         super.enter(prev,data);
      }
      
      override protected function __startLoading(e:Event) : void
      {
         super.__startLoading(e);
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
      
      override public function leaving(next:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(next);
      }
   }
}
