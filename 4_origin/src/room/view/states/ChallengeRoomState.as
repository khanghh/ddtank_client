package room.view.states
{
   import battleSkill.BattleSkillManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.states.BaseStateView;
   import room.RoomManager;
   import room.view.roomView.ChallengeRoomView;
   
   public class ChallengeRoomState extends BaseRoomState
   {
       
      
      public function ChallengeRoomState()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         prev = param1;
         data = param2;
         _roomView = new ChallengeRoomView(RoomManager.Instance.current);
         addChild(_roomView);
         ChatManager.Instance.state = 5;
         BattleSkillManager.instance.loadTempleResource(function():*
         {
            var /*UnknownSlot*/:* = function():void
            {
            };
            return function():void
            {
            };
         }());
         if(RoomManager.Instance.haveTempInventPlayer())
         {
            GameInSocketOut.sendInviteGame(RoomManager.Instance.tempInventPlayerID);
            RoomManager.Instance.tempInventPlayerID = -1;
         }
         super.enter(prev,data);
      }
      
      override public function getType() : String
      {
         return "challengeRoom";
      }
      
      override public function getBackType() : String
      {
         return "roomlist";
      }
   }
}
