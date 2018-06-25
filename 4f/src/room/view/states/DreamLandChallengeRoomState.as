package room.view.states{   import ddt.states.BaseStateView;   import ddt.utils.PositionUtils;   import room.RoomManager;   import room.view.roomView.DreamLandRoomView;      public class DreamLandChallengeRoomState extends BaseRoomState   {                   public function DreamLandChallengeRoomState() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            override public function getType() : String { return null; }
            override public function getBackType() : String { return null; }
   }}