package starling.utils
{
   import starling.errors.AbstractClassError;
   
   public final class VAlign
   {
      
      public static const TOP:String = "top";
      
      public static const CENTER:String = "center";
      
      public static const BOTTOM:String = "bottom";
       
      
      public function VAlign()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function isValid(vAlign:String) : Boolean
      {
         return vAlign == "top" || vAlign == "center" || vAlign == "bottom";
      }
   }
}
