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
       
      
      public function FilterWordManager()
      {
         super();
      }
      
      public static function setup(analyzer:FilterWordAnalyzer) : void
      {
         WORDS = analyzer.words;
         SERVER_WORDS = analyzer.serverWords;
         unableChar = analyzer.unableChar;
         clearnUpNaN_Char(WORDS);
         clearnUpNaN_Char(SERVER_WORDS);
      }
      
      private static function clearnUpNaN_Char(source:Array) : void
      {
         var i:int = 0;
         while(i < source.length)
         {
            if(StringHelper.trim(source[i]).length == 0)
            {
               source.splice(i,1);
            }
            else
            {
               i++;
            }
         }
      }
      
      public static function containUnableChar(s:String) : Boolean
      {
         var i:int = 0;
         var len:int = s.length;
         for(i = 0; i < len; )
         {
            if(unableChar.indexOf(s.charAt(i)) > -1)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public static function isGotForbiddenWords(str:String, level:String = "chat") : Boolean
      {
         var i:int = 0;
         var temS:String = StringHelper.trimAll(str.toLocaleLowerCase());
         var count:uint = WORDS.length;
         if(level == "name" || level == "chat" || level == "all")
         {
            for(i = 0; i < count; )
            {
               if(temS.indexOf(WORDS[i]) > -1)
               {
                  return true;
               }
               i++;
            }
         }
         if(level == "server")
         {
            count = SERVER_WORDS.length;
            for(i = 0; i < count; )
            {
               if(temS.indexOf(SERVER_WORDS[i]) > -1)
               {
                  return true;
               }
               i++;
            }
         }
         return false;
      }
      
      private static function formatForbiddenWords(str:String, arr:Array) : String
      {
         var temS:* = null;
         var i:int = 0;
         var obj:* = null;
         if(arr != SERVER_WORDS)
         {
            temS = StringHelper.trimAll(str.toLocaleLowerCase());
         }
         else
         {
            temS = str;
         }
         var count:int = arr.length;
         var isGotForbiddenWord:Boolean = false;
         for(i = 0; i < count; )
         {
            if(temS.indexOf(arr[i]) > -1)
            {
               isGotForbiddenWord = true;
               obj = {};
               obj["word"] = arr[i];
               obj["idx"] = temS.indexOf(arr[i]);
               obj["length"] = obj["word"].length;
               temS = replaceUpperOrLowerCase(temS,obj);
               str = replaceUpperOrLowerCase(str,obj);
               i = 0;
            }
            i++;
         }
         return str;
      }
      
      private static function formatChannelWords(str:String) : String
      {
         var i:int = 0;
         var idx:* = 0;
         var idx1:* = 0;
         var idx2:* = 0;
         if(!str)
         {
            return undefined;
         }
         var count:int = CHANNEL_WORDS.length;
         var isGotChannelWord:Boolean = false;
         for(i = 0; i < count; )
         {
            idx = uint(str.indexOf(CHANNEL_WORDS[i]));
            idx1 = uint(idx - 1);
            idx2 = uint(idx + CHANNEL_WORDS[i].length);
            if(idx > -1)
            {
               if(idx1 > -1 && idx2 <= str.length - 1)
               {
                  if(str.slice(idx1,idx1 + 1) == "[" && str.slice(idx2,idx2 + 1) == "]")
                  {
                     isGotChannelWord = true;
                     str = str.slice(0,idx) + getXXX(CHANNEL_WORDS[i].length) + str.slice(idx2);
                  }
               }
            }
            i++;
         }
         if(isGotChannelWord && str)
         {
            return str;
         }
         return undefined;
      }
      
      private static function replaceUpperOrLowerCase(str:String, obj:Object) : String
      {
         var s:* = null;
         var startIdx:int = obj["idx"];
         var len:int = obj["length"];
         if(startIdx + len >= str.length)
         {
            s = str.slice(startIdx);
         }
         else
         {
            s = str.slice(startIdx,startIdx + len);
         }
         str = str.replace(s,getXXX(len));
         return str;
      }
      
      public static function filterWrod(s:String) : String
      {
         var re_str1:* = null;
         var re_str2:* = null;
         var temS:String = StringHelper.trimAll(s);
         var re_str:String = formatChannelWords(temS);
         if(re_str)
         {
            re_str1 = formatForbiddenWords(re_str,WORDS);
         }
         else
         {
            re_str1 = formatForbiddenWords(temS,WORDS);
         }
         if(re_str2)
         {
            return re_str2;
         }
         if(re_str1)
         {
            return re_str1;
         }
         if(re_str)
         {
            return re_str;
         }
         return temS;
      }
      
      public static function filterWrodFromServer(str:String) : String
      {
         if(isGotForbiddenWords(str,"server"))
         {
            str = formatForbiddenWords(str,SERVER_WORDS);
         }
         return str;
      }
      
      public static function IsNullorEmpty(str:String) : Boolean
      {
         str = StringHelper.trim(str);
         return StringHelper.isNullOrEmpty(str);
      }
      
      private static function getXXX(len:int) : String
      {
         var startIdx:uint = Math.round(Math.random() * (REPLACEWORD.length / 4));
         var str:String = REPLACEWORD.slice(startIdx,startIdx + len);
         return str;
      }
   }
}
