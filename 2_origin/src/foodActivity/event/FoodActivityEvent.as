package foodActivity.event
{
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class FoodActivityEvent extends Event
   {
      
      public static var ACTIVITY_STATE:int = 1;
      
      public static var SIMPLE_COOKING:int = 2;
      
      public static var PAY_COOKING:int = 3;
      
      public static var REWARD:int = 4;
      
      public static var UPDATE_COUNT:int = 5;
      
      public static var UPDATE_COUNT_BYTIME:int = 6;
      
      public static var CLEAN_DATA:int = 7;
      
      public static var FOOD_OPENVIEW:String = "foodOpenView";
      
      public static var FOOD_UPDATEVIEW:String = "foodUpdateView";
      
      public static var FOOD_CLOSEVIEW:String = "foodCloseView";
      
      public static var FOOD_REWARD:String = "foodReward";
       
      
      private var _pkg:PackageIn;
      
      public function FoodActivityEvent(type:String, pkg:PackageIn = null)
      {
         super(type,bubbles,cancelable);
         _pkg = pkg;
      }
      
      public function get pkg() : PackageIn
      {
         return _pkg;
      }
   }
}
