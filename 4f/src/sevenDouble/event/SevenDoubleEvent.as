package sevenDouble.event
{
   import flash.events.Event;
   
   public class SevenDoubleEvent extends Event
   {
       
      
      public var data:Object;
      
      public function SevenDoubleEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
