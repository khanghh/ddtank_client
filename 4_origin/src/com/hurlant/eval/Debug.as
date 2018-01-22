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
      
      public static function set logger(param1:ILogger) : void
      {
         _logger = param1;
      }
      
      static function arrows(param1:*) : String
      {
         var _loc2_:* = "";
         var _loc3_:* = nesting;
         while(_loc3_ > 0)
         {
            _loc2_ = _loc2_ + param1;
            _loc3_ = _loc3_ - 1;
         }
         return nesting + " " + _loc2_ + " ";
      }
      
      public static function exit(param1:*, param2:* = "") : *
      {
         nesting = nesting - 1;
      }
      
      public static function assert(param1:*) : *
      {
         if(!param1)
         {
            throw "Assert failed.";
         }
      }
      
      public static function enter(param1:*, param2:* = "") : *
      {
         nesting = nesting + 1;
      }
      
      public static function print(... rest) : void
      {
         var _loc2_:String = rest.join(" - ");
         if(_logger != null)
         {
            _logger.print(_loc2_);
         }
         trace(_loc2_);
      }
   }
}
