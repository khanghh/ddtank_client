package ddt.utils
{
   import ddt.data.analyze.FilterWordAnalyzer;
   import road7th.utils.StringHelper;
   
   public class FilterWordManager
   {
      
      private static var unableChar:String = "";
      
      private static var CHANNEL_WORDS:Array = ["当前","公会","组队","私聊","小喇叭","大喇叭","跨区大喇叭"];
      
      private static var WORDS:Array = [];
      
      private static var SERVER_WORDS:Array = [];
      
      private static var REPLACEWORD:String = "~!@#$@#$%~!@#$@#%^&@~!@#$@##$%*~!@#$$@#%^&@~!@#$@#@#";
      
      private static const FILTER_TYPE_ALL:String = "all";
      
      private static const FILTER_TYPE_CHAT:String = "chat";
      
      private static const FILTER_TYPE_NAME:String = "name";
      
      private static const FILTER_TYPE_SERVER:String = "server";
       
      
      public function FilterWordManager(){super();}
      
      public static function setup(param1:FilterWordAnalyzer) : void{}
      
      private static function clearnUpNaN_Char(param1:Array) : void{}
      
      public static function containUnableChar(param1:String) : Boolean{return false;}
      
      public static function isGotForbiddenWords(param1:String, param2:String = "chat") : Boolean{return false;}
      
      private static function formatForbiddenWords(param1:String, param2:Array) : String{return null;}
      
      private static function formatChannelWords(param1:String) : String{return null;}
      
      private static function replaceUpperOrLowerCase(param1:String, param2:Object) : String{return null;}
      
      public static function filterWrod(param1:String) : String{return null;}
      
      public static function filterWrodFromServer(param1:String) : String{return null;}
      
      public static function IsNullorEmpty(param1:String) : Boolean{return false;}
      
      private static function getXXX(param1:int) : String{return null;}
   }
}
