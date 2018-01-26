package newYearRice.events
{
   import flash.events.Event;
   
   public class NewYearRiceEvent extends Event
   {
      
      public static const ISOPEN_FRAME:String = "isopenframe";
       
      
      public var data:Array;
      
      public function NewYearRiceEvent(param1:String, param2:Array = null){super(null,null,null);}
   }
}
