package gameCommon.model
{
   import ddt.events.LivingEvent;
   import flash.utils.Dictionary;
   
   [Event(name="attackingChanged",type="ddt.events.LivingEvent")]
   public class TurnedLiving extends Living
   {
       
      
      protected var _isAttacking:Boolean = false;
      
      private var _fightBuffs:Dictionary;
      
      public function TurnedLiving(param1:int, param2:int, param3:int, param4:int = 0){super(null,null,null,null);}
      
      public function get isAttacking() : Boolean{return false;}
      
      public function set isAttacking(param1:Boolean) : void{}
      
      override public function beginNewTurn() : void{}
      
      override public function die(param1:Boolean = true) : void{}
      
      public function hasState(param1:int) : Boolean{return false;}
      
      public function addState(param1:int, param2:String = "") : void{}
      
      public function startAttacking() : void{}
      
      public function stopAttacking() : void{}
      
      override public function dispose() : void{}
   }
}
