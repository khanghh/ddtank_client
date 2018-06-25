package room.view.states{   import battleSkill.BattleSkillManager;   import bones.BoneMovieFactory;   import bones.loader.BonesLoaderManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import ddt.states.BaseStateView;   import ddt.utils.PositionUtils;   import ddt.view.MainToolBar;   import flash.events.Event;   import room.RoomManager;   import room.view.roomView.BattleRoomView;      public class BattleRoomState extends BaseRoomState   {                   public function BattleRoomState() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            override protected function __startLoading(e:Event) : void { }
            override public function getType() : String { return null; }
            override public function getBackType() : String { return null; }
            override public function leaving(next:BaseStateView) : void { }
   }}