package starling.animation{   import flash.utils.Dictionary;   import starling.errors.AbstractClassError;      public class Transitions   {            public static const LINEAR:String = "linear";            public static const EASE_IN:String = "easeIn";            public static const EASE_OUT:String = "easeOut";            public static const EASE_IN_OUT:String = "easeInOut";            public static const EASE_OUT_IN:String = "easeOutIn";            public static const EASE_IN_BACK:String = "easeInBack";            public static const EASE_OUT_BACK:String = "easeOutBack";            public static const EASE_IN_OUT_BACK:String = "easeInOutBack";            public static const EASE_OUT_IN_BACK:String = "easeOutInBack";            public static const EASE_IN_ELASTIC:String = "easeInElastic";            public static const EASE_OUT_ELASTIC:String = "easeOutElastic";            public static const EASE_IN_OUT_ELASTIC:String = "easeInOutElastic";            public static const EASE_OUT_IN_ELASTIC:String = "easeOutInElastic";            public static const EASE_IN_BOUNCE:String = "easeInBounce";            public static const EASE_OUT_BOUNCE:String = "easeOutBounce";            public static const EASE_IN_OUT_BOUNCE:String = "easeInOutBounce";            public static const EASE_OUT_IN_BOUNCE:String = "easeOutInBounce";            private static var sTransitions:Dictionary;                   public function Transitions() { super(); }
            public static function getTransition(name:String) : Function { return null; }
            public static function register(name:String, func:Function) : void { }
            private static function registerDefaults() : void { }
            protected static function linear(ratio:Number) : Number { return 0; }
            protected static function easeIn(ratio:Number) : Number { return 0; }
            protected static function easeOut(ratio:Number) : Number { return 0; }
            protected static function easeInOut(ratio:Number) : Number { return 0; }
            protected static function easeOutIn(ratio:Number) : Number { return 0; }
            protected static function easeInBack(ratio:Number) : Number { return 0; }
            protected static function easeOutBack(ratio:Number) : Number { return 0; }
            protected static function easeInOutBack(ratio:Number) : Number { return 0; }
            protected static function easeOutInBack(ratio:Number) : Number { return 0; }
            protected static function easeInElastic(ratio:Number) : Number { return 0; }
            protected static function easeOutElastic(ratio:Number) : Number { return 0; }
            protected static function easeInOutElastic(ratio:Number) : Number { return 0; }
            protected static function easeOutInElastic(ratio:Number) : Number { return 0; }
            protected static function easeInBounce(ratio:Number) : Number { return 0; }
            protected static function easeOutBounce(ratio:Number) : Number { return 0; }
            protected static function easeInOutBounce(ratio:Number) : Number { return 0; }
            protected static function easeOutInBounce(ratio:Number) : Number { return 0; }
            protected static function easeCombined(startFunc:Function, endFunc:Function, ratio:Number) : Number { return 0; }
   }}