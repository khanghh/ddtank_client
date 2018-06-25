package roulette
{
   import flash.events.Event;
   
   public class RouletteFrameEvent extends Event
   {
      
      public static const ROULETTE_RESULT:String = "roulette_result";
      
      public static const GUN_VISIBLE:String = "gun_visible";
      
      public static const ROULETTE_VISIBLE:String = "roulette_visible";
      
      public static const LEFTGUN_ENABLE:String = "leftGun_enable";
      
      public static const BUTTON_CLICK:String = "button_click";
       
      
      private var _reward:String;
      
      private var _arr:Array;
      
      public function RouletteFrameEvent(type:String, reward:String = null, arr:Array = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type);
         _reward = reward;
         _arr = arr;
      }
      
      public function get reward() : String
      {
         return _reward;
      }
      
      public function get arr() : Array
      {
         return _arr;
      }
   }
}
