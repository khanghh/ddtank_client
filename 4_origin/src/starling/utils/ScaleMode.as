package starling.utils
{
   import starling.errors.AbstractClassError;
   
   public class ScaleMode
   {
      
      public static const NONE:String = "none";
      
      public static const NO_BORDER:String = "noBorder";
      
      public static const SHOW_ALL:String = "showAll";
       
      
      public function ScaleMode()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function isValid(scaleMode:String) : Boolean
      {
         return scaleMode == "none" || scaleMode == "noBorder" || scaleMode == "showAll";
      }
   }
}
