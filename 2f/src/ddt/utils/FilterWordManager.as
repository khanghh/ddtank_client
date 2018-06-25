package ddt.utils{   import ddt.data.analyze.FilterWordAnalyzer;   import road7th.utils.StringHelper;      public class FilterWordManager   {            private static var unableChar:String = "";            private static var CHANNEL_WORDS:Array = ["当前","公会","组队","私聊","小喇叭","大喇叭","跨区大喇叭"];            private static var WORDS:Array = [];            private static var SERVER_WORDS:Array = [];            private static var REPLACEWORD:String = "~!@#$@#$%~!@#$@#%^&@~!@#$@##$%*~!@#$$@#%^&@~!@#$@#@#";            private static const FILTER_TYPE_ALL:String = "all";            private static const FILTER_TYPE_CHAT:String = "chat";            private static const FILTER_TYPE_NAME:String = "name";            private static const FILTER_TYPE_SERVER:String = "server";                   public function FilterWordManager() { super(); }
            public static function setup(analyzer:FilterWordAnalyzer) : void { }
            private static function clearnUpNaN_Char(source:Array) : void { }
            public static function containUnableChar(s:String) : Boolean { return false; }
            public static function isGotForbiddenWords(str:String, level:String = "chat") : Boolean { return false; }
            private static function formatForbiddenWords(str:String, arr:Array) : String { return null; }
            private static function formatChannelWords(str:String) : String { return null; }
            private static function replaceUpperOrLowerCase(str:String, obj:Object) : String { return null; }
            public static function filterWrod(s:String) : String { return null; }
            public static function filterWrodFromServer(str:String) : String { return null; }
            public static function IsNullorEmpty(str:String) : Boolean { return false; }
            private static function getXXX(len:int) : String { return null; }
   }}