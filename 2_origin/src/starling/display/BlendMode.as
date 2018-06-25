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
       
      
      public function BlendMode()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function getBlendFactors(mode:String, premultipliedAlpha:Boolean = true) : Array
      {
         var modes:Object = sBlendFactors[int(premultipliedAlpha)];
         if(mode in modes)
         {
            return modes[mode];
         }
         throw new ArgumentError("Invalid blend mode");
      }
      
      public static function register(name:String, sourceFactor:String, destFactor:String, premultipliedAlpha:Boolean = true) : void
      {
         var modes:Object = sBlendFactors[int(premultipliedAlpha)];
         modes[name] = [sourceFactor,destFactor];
         var otherModes:Object = sBlendFactors[int(!premultipliedAlpha)];
         if(!(name in otherModes))
         {
            otherModes[name] = [sourceFactor,destFactor];
         }
      }
   }
}
