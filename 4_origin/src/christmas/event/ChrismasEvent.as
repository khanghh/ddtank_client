package christmas.event
{
   import flash.events.Event;
   
   public class ChrismasEvent extends Event
   {
      
      public static const SHOW:String = "xmas_show";
      
      public static const PLAYING_SNOWMAN:String = "xmas_playing_snowman";
      
      public static const RE_CONNECT_CHRISTMAS:String = "xmas_reconnect_christmas";
      
      public static const RE_CONNECT:String = "xmas_reconnect";
      
      public static const SNOW_IS_UPDATE:String = "xmas_snow_is_update";
      
      public static const SNOWMAN_ENTER:String = "xmas_snowman_enter";
      
      public static const CLICK_CHRISTMAS_ICON:String = "xmas_click_christmas_icon";
      
      public static const DISPOSE_ENTER_ICON:String = "xmas_dispose_enter_icon";
      
      public static const GAME_START:String = "xmas_game_start";
       
      
      private var _data:Object;
      
      public function ChrismasEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         _data = param2;
         super(param1,param3,param4);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
