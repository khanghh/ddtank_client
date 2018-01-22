package ddt.log
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.net.FileReference;
   
   public class Log
   {
      
      private static var _instance:Log;
       
      
      private const ENABLE_TRACE:Boolean = false;
      
      private const MSG_MAX_NUM:int = 1000;
      
      private const REMOVE_COUNT:int = 10;
      
      private var _stage:Stage;
      
      private var _file:FileReference;
      
      private var _msgArr:Array;
      
      public function Log()
      {
         super();
      }
      
      public static function get instance() : Log
      {
         if(!_instance)
         {
            _instance = new Log();
         }
         return _instance;
      }
      
      public function init(param1:Stage) : void
      {
         _stage = param1;
         _stage.addEventListener("keyUp",onKeyUp);
         _file = new FileReference();
         _file.addEventListener("complete",onFileComplete);
         _msgArr = [];
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:uint = param1.keyCode;
         if(_loc2_ == 192 && param1.shiftKey)
         {
            _loc5_ = _msgArr.join("\r\n");
            _loc4_ = new Date();
            _loc3_ = getDateString(_loc4_);
            _file.save(_loc5_,_loc3_ + " log.txt");
         }
      }
      
      private function onFileComplete(param1:Event) : void
      {
         _msgArr = [];
      }
      
      public function log(param1:*, param2:String = null) : void
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         false && trace(param1);
         if(param1 is String)
         {
            _loc3_ = param1;
         }
         else
         {
            _loc3_ = JSON.stringify(param1,null,"  ");
         }
         var _loc5_:Date = new Date();
         var _loc4_:String = "[" + getDateString(_loc5_) + "]";
         if(param2 == null)
         {
            _loc3_ = _loc4_ + " " + _loc3_;
         }
         else
         {
            _loc3_ = _loc4_ + " [" + param2 + "] " + _loc3_;
         }
         pushMsg(_loc3_);
      }
      
      private function getDateString(param1:Date) : String
      {
         return param1.fullYear + "-" + fixTwoDigit(param1.month + 1) + "-" + fixTwoDigit(param1.date) + " " + fixTwoDigit(param1.hours) + "-" + fixTwoDigit(param1.minutes) + "-" + fixTwoDigit(param1.seconds);
      }
      
      private function fixTwoDigit(param1:int) : String
      {
         return param1 < 10?"0" + param1:param1.toString();
      }
      
      private function pushMsg(param1:String) : void
      {
         _msgArr.push(param1);
         if(_msgArr.length > 1000 + 10)
         {
            _msgArr.splice(0,10);
         }
      }
   }
}
