package ddt.manager
{
   import com.pickgliss.utils.StringUtils;
   import flash.utils.Dictionary;
   
   public class LanguageMgr
   {
      
      private static var _dic:Dictionary;
      
      private static var _reg:RegExp = /\{(\d+)\}/;
       
      
      public function LanguageMgr(){super();}
      
      public static function setup(param1:String) : void{}
      
      private static function analyze(param1:String) : void{}
      
      public static function GetTranslation(param1:String, ... rest) : String{return null;}
   }
}
