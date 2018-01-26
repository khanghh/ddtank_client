package road7th.comm
{
   import flash.events.Event;
   
   public class SocketEvent extends Event
   {
      
      public static const DATA:String = "data";
       
      
      private var _data:PackageIn;
      
      public function SocketEvent(param1:String, param2:PackageIn){super(null);}
      
      public function get data() : PackageIn{return null;}
   }
}
