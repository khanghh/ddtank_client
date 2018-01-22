package gameCommon.model
{
   import ddt.events.LivingEvent;
   
   [Event(name="modelChanged",type="tank.events.LivingEvent")]
   public class SmallEnemy extends Living
   {
       
      
      public var stateType:int;
      
      private var _modelID:int;
      
      public function SmallEnemy(param1:int, param2:int, param3:int){super(null,null,null);}
      
      public function set modelID(param1:int) : void{}
      
      public function get modelID() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
