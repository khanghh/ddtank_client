package starling.animation
{
   import flash.utils.Dictionary;
   import starling.errors.AbstractClassError;
   
   public class Transitions
   {
      
      public static const LINEAR:String = "linear";
      
      public static const EASE_IN:String = "easeIn";
      
      public static const EASE_OUT:String = "easeOut";
      
      public static const EASE_IN_OUT:String = "easeInOut";
      
      public static const EASE_OUT_IN:String = "easeOutIn";
      
      public static const EASE_IN_BACK:String = "easeInBack";
      
      public static const EASE_OUT_BACK:String = "easeOutBack";
      
      public static const EASE_IN_OUT_BACK:String = "easeInOutBack";
      
      public static const EASE_OUT_IN_BACK:String = "easeOutInBack";
      
      public static const EASE_IN_ELASTIC:String = "easeInElastic";
      
      public static const EASE_OUT_ELASTIC:String = "easeOutElastic";
      
      public static const EASE_IN_OUT_ELASTIC:String = "easeInOutElastic";
      
      public static const EASE_OUT_IN_ELASTIC:String = "easeOutInElastic";
      
      public static const EASE_IN_BOUNCE:String = "easeInBounce";
      
      public static const EASE_OUT_BOUNCE:String = "easeOutBounce";
      
      public static const EASE_IN_OUT_BOUNCE:String = "easeInOutBounce";
      
      public static const EASE_OUT_IN_BOUNCE:String = "easeOutInBounce";
      
      private static var sTransitions:Dictionary;
       
      
      public function Transitions(){super();}
      
      public static function getTransition(param1:String) : Function{return null;}
      
      public static function register(param1:String, param2:Function) : void{}
      
      private static function registerDefaults() : void{}
      
      protected static function linear(param1:Number) : Number{return 0;}
      
      protected static function easeIn(param1:Number) : Number{return 0;}
      
      protected static function easeOut(param1:Number) : Number{return 0;}
      
      protected static function easeInOut(param1:Number) : Number{return 0;}
      
      protected static function easeOutIn(param1:Number) : Number{return 0;}
      
      protected static function easeInBack(param1:Number) : Number{return 0;}
      
      protected static function easeOutBack(param1:Number) : Number{return 0;}
      
      protected static function easeInOutBack(param1:Number) : Number{return 0;}
      
      protected static function easeOutInBack(param1:Number) : Number{return 0;}
      
      protected static function easeInElastic(param1:Number) : Number{return 0;}
      
      protected static function easeOutElastic(param1:Number) : Number{return 0;}
      
      protected static function easeInOutElastic(param1:Number) : Number{return 0;}
      
      protected static function easeOutInElastic(param1:Number) : Number{return 0;}
      
      protected static function easeInBounce(param1:Number) : Number{return 0;}
      
      protected static function easeOutBounce(param1:Number) : Number{return 0;}
      
      protected static function easeInOutBounce(param1:Number) : Number{return 0;}
      
      protected static function easeOutInBounce(param1:Number) : Number{return 0;}
      
      protected static function easeCombined(param1:Function, param2:Function, param3:Number) : Number{return 0;}
   }
}
