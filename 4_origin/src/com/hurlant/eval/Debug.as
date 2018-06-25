package com.hurlant.eval
{
   import com.hurlant.test.ILogger;
   
   public class Debug
   {
      
      static var nesting = 0;
      
      private static var _logger:ILogger = null;
       
      
      public function Debug()
      {
         super();
      }
      
      public static function set logger(value:ILogger) : void
      {
         _logger = value;
      }
      
      static function arrows(c:*) : String
      {
         var str:* = "";
         for(var n:* = nesting; n > 0; n = n - 1)
         {
            str = str + c;
         }
         return nesting + " " + str + " ";
      }
      
      public static function exit(s:*, a:* = "") : *
      {
         nesting = nesting - 1;
      }
      
      public static function assert(bool:*) : *
      {
         if(!bool)
         {
            throw "Assert failed.";
         }
      }
      
      public static function enter(s:*, a:* = "") : *
      {
         nesting = nesting + 1;
      }
      
      public static function print(... args) : void
      {
         var s:String = args.join(" - ");
         if(_logger != null)
         {
            _logger.print(s);
         }
         trace(s);
      }
   }
}
