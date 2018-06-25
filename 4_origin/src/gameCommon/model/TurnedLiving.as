package gameCommon.model
{
   import ddt.events.LivingEvent;
   import flash.utils.Dictionary;
   
   [Event(name="attackingChanged",type="ddt.events.LivingEvent")]
   public class TurnedLiving extends Living
   {
       
      
      protected var _isAttacking:Boolean = false;
      
      private var _fightBuffs:Dictionary;
      
      public function TurnedLiving(id:int, team:int, maxBlood:int, templeId:int = 0)
      {
         super(id,team,maxBlood,templeId);
      }
      
      public function get isAttacking() : Boolean
      {
         return _isAttacking;
      }
      
      public function set isAttacking(value:Boolean) : void
      {
         if(_isAttacking == value)
         {
            return;
         }
         _isAttacking = value;
         dispatchEvent(new LivingEvent("attackingChanged"));
      }
      
      override public function beginNewTurn() : void
      {
         super.beginNewTurn();
         isAttacking = false;
         _fightBuffs = new Dictionary();
      }
      
      override public function die(widthAction:Boolean = true) : void
      {
         if(isLiving)
         {
            if(_isAttacking)
            {
               stopAttacking();
            }
            super.die(widthAction);
         }
      }
      
      public function hasState(stateId:int) : Boolean
      {
         return _fightBuffs[stateId] != null;
      }
      
      public function addState(stateId:int, pic:String = "") : void
      {
         if(stateId != 0 && _fightBuffs)
         {
            _fightBuffs[stateId] = true;
         }
         dispatchEvent(new LivingEvent("addState",stateId,0,pic));
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
