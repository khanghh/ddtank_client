package road7th.comm
{
   import flash.events.Event;
   
   public class SocketEvent extends Event
   {
      
      public static const DATA:String = "data";
       
      
      private var _data:PackageIn;
      
      public function SocketEvent(type:String, data:PackageIn)
      {
         super(type);
         _data = data;
      }
      
      public function get data() : PackageIn
      {
         return _data;
      }
   }
}
