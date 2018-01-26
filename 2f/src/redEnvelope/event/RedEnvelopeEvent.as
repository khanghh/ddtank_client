package redEnvelope.event
{
   import flash.events.Event;
   
   public class RedEnvelopeEvent extends Event
   {
      
      public static const SELECT:String = "select";
      
      public static const CHOOSE:String = "choose";
       
      
      public var resultData:int;
      
      public function RedEnvelopeEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
   }
}
