package gameCommon.model
{
   import ddt.events.LivingEvent;
   import flash.utils.Dictionary;
   
   [Event(name="attackingChanged",type="ddt.events.LivingEvent")]
   public class TurnedLiving extends Living
   {
       
      
      protected var _isAttacking:Boolean = false;
      
      private var _fightBuffs:Dictionary;
      
      public function TurnedLiving(param1:int, param2:int, param3:int, param4:int = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get isAttacking() : Boolean
      {
         return _isAttacking;
      }
      
      public function set isAttacking(param1:Boolean) : void
      {
         if(_isAttacking == param1)
         {
            return;
         }
         _isAttacking = param1;
         dispatchEvent(new LivingEvent("attackingChanged"));
      }
      
      override public function beginNewTurn() : void
      {
         super.beginNewTurn();
         isAttacking = false;
         _fightBuffs = new Dictionary();
      }
      
      override public function die(param1:Boolean = true) : void
      {
         if(isLiving)
         {
            if(_isAttacking)
            {
               stopAttacking();
            }
            super.die(param1);
         }
      }
      
      public function hasState(param1:int) : Boolean
      {
         return _fightBuffs[param1] != null;
      }
      
      public function addState(param1:int, param2:String = "") : void
      {
         if(param1 != 0 && _fightBuffs)
         {
            _fightBuffs[param1] = true;
         }
         dispatchEvent(new LivingEvent("addState",param1,0,param2));
      }
      
      public function startAttacking() : void
      {
         isAttacking = true;
      }
      
      public function stopAttacking() : void
      {
         isAttacking = false;
      }
      
      override public function dispose() : void
      {
         _fightBuffs = null;
         super.dispose();
      }
   }
}
