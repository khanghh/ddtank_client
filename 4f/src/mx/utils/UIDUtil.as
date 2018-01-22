package mx.utils
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import mx.core.IPropertyChangeNotifier;
   import mx.core.IUIComponent;
   import mx.core.IUID;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class UIDUtil
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static const ALPHA_CHAR_CODES:Array = [48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70];
      
      private static var uidDictionary:Dictionary = new Dictionary(true);
       
      
      public function UIDUtil(){super();}
      
      public static function createUID() : String{return null;}
      
      public static function fromByteArray(param1:ByteArray) : String{return null;}
      
      public static function isUID(param1:String) : Boolean{return false;}
      
      public static function toByteArray(param1:String) : ByteArray{return null;}
      
      public static function getUID(param1:Object) : String{return null;}
      
      private static function getDigit(param1:String) : uint{return null;}
   }
}
