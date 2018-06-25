package homeTemple.event
{
   import flash.events.Event;
   
   public class HomeTempleEvent extends Event
   {
      
      public static const UPDATEPROPERTY:String = "homeTempleUpdateProperty";
      
      public static const UPDATEBLESSINGSTATE:String = "homeTempleUpdateBlessingState";
       
      
      private var _data:Array;
      
      public function HomeTempleEvent(type:String, data:Array = null)
      {
         _data = data;
         super(type,bubbles,cancelable);
      }
      
      public function get data() : Array
      {
         return _data;
      }
   }
}
