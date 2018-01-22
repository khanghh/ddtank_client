package littleGame.model
{
   import ddt.data.player.SelfInfo;
   import ddt.ddt_internal;
   import littleGame.actions.LittleAction;
   import littleGame.actions.LittleSelfMoveAction;
   import littleGame.data.Node;
   import littleGame.events.LittleLivingEvent;
   
   use namespace ddt_internal;
   
   [Event(name="inhaledChanged",type="littleGame.events.LittleLivingEvent")]
   [Event(name="getscore",type="littleGame.events.LittleLivingEvent")]
   [Event(name="collide",type="littleGame.events.LittleLivingEvent")]
   public class LittleSelf extends LittlePlayer
   {
       
      
      private var _inhaled:Boolean = false;
      
      public function LittleSelf(param1:SelfInfo, param2:int, param3:int, param4:int, param5:int)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function stand() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _actionMgr._queue;
         for each(var _loc1_ in _actionMgr._queue)
         {
            if(_loc1_ is LittleSelfMoveAction)
            {
               _loc1_.cancel();
            }
         }
      }
      
      public function collideByNode(param1:Node) : Boolean
      {
         return false;
      }
      
      override public function get isSelf() : Boolean
      {
         return true;
      }
      
      override public function toString() : String
      {
         return "LittleSelf_" + playerInfo.NickName;
      }
      
      public function getScore(param1:int) : void
      {
         dispatchEvent(new LittleLivingEvent("getscore",param1));
      }
      
      public function get inhaled() : Boolean
      {
         return _inhaled;
      }
      
      public function set inhaled(param1:Boolean) : void
      {
         if(_inhaled == param1)
         {
            return;
         }
         _inhaled = param1;
         dispatchEvent(new LittleLivingEvent("inhaledChanged"));
      }
   }
}
