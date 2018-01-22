package homeTemple.event
{
   import flash.events.Event;
   
   public class HomeTempleEvent extends Event
   {
      
      public static const UPDATEPROPERTY:String = "homeTempleUpdateProperty";
      
      public static const UPDATEBLESSINGSTATE:String = "homeTempleUpdateBlessingState";
       
      
      private var _data:Array;
      
      public function HomeTempleEvent(param1:String, param2:Array = null)
      {
         _data = param2;
         super(param1,bubbles,cancelable);
      }
      
      public function get data() : Array
      {
         return _data;
      }
   }
}
