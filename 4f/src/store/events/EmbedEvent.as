package store.events
{
   import flash.events.Event;
   
   public class EmbedEvent extends Event
   {
      
      public static const EMBED:String = "embed";
       
      
      private var _cellID:int;
      
      public function EmbedEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get CellID() : int{return 0;}
   }
}
