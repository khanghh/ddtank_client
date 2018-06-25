package room.view.states{   import battleSkill.BattleSkillManager;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.states.BaseStateView;   import room.RoomManager;   import room.view.roomView.ChallengeRoomView;      public class ChallengeRoomState extends BaseRoomState   {                   public function ChallengeRoomState() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            override public function getType() : String { return null; }
            override public function getBackType() : String { return null; }
   }}