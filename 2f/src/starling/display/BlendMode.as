package starling.display
{
   import starling.errors.AbstractClassError;
   
   public class BlendMode
   {
      
      private static var sBlendFactors:Array = [{
         "none":["one","zero"],
         "normal":["sourceAlpha","oneMinusSourceAlpha"],
         "add":["sourceAlpha","destinationAlpha"],
         "multiply":["destinationColor","oneMinusSourceAlpha"],
         "screen":["sourceAlpha","one"],
         "erase":["zero","oneMinusSourceAlpha"],
         "mask":["zero","sourceAlpha"],
         "below":["oneMinusDestinationAlpha","destinationAlpha"],
         "alpha":["destinationAlpha","oneMinusSourceAlpha"]
      },{
         "none":["one","zero"],
         "normal":["one","oneMinusSourceAlpha"],
         "add":["one","one"],
         "multiply":["destinationColor","oneMinusSourceAlpha"],
         "screen":["one","oneMinusSourceColor"],
         "erase":["zero","oneMinusSourceAlpha"],
         "mask":["zero","sourceAlpha"],
         "below":["oneMinusDestinationAlpha","destinationAlpha"],
         "alpha":["destinationAlpha","oneMinusSourceAlpha"]
      }];
      
      public static const AUTO:String = "auto";
      
      public static const NONE:String = "none";
      
      public static const NORMAL:String = "normal";
      
      public static const ADD:String = "add";
      
      public static const MULTIPLY:String = "multiply";
      
      public static const SCREEN:String = "screen";
      
      public static const ERASE:String = "erase";
      
      public static const MASK:String = "mask";
      
      public static const BELOW:String = "below";
      
      public static const ALPHA:String = "alpha";
       
      
      public function BlendMode(){super();}
      
      public static function getBlendFactors(param1:String, param2:Boolean = true) : Array{return null;}
      
      public static function register(param1:String, param2:String, param3:String, param4:Boolean = true) : void{}
   }
}
