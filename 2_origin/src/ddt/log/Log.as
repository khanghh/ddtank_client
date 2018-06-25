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
      
      public function init(stage:Stage) : void
      {
         _stage = stage;
         _stage.addEventListener("keyUp",onKeyUp);
         _file = new FileReference();
         _file.addEventListener("complete",onFileComplete);
         _msgArr = [];
      }
      
      private function onKeyUp(evt:KeyboardEvent) : void
      {
         var msg:* = null;
         var date:* = null;
         var dateString:* = null;
         var keyCode:uint = evt.keyCode;
         if(keyCode == 192 && evt.shiftKey)
         {
            msg = _msgArr.join("\r\n");
            date = new Date();
            dateString = getDateString(date);
            _file.save(msg,dateString + " log.txt");
         }
      }
      
      private function onFileComplete(evt:Event) : void
      {
         _msgArr = [];
      }
      
      public function log(msg:*, tag:String = null) : void
      {
         var tranMsg:* = null;
         if(msg == null)
         {
            return;
         }
         false && trace(msg);
         if(msg is String)
         {
            tranMsg = msg;
         }
         else
         {
            tranMsg = JSON.stringify(msg,null,"  ");
         }
         var date:Date = new Date();
         var dateString:String = "[" + getDateString(date) + "]";
         if(tag == null)
         {
            tranMsg = dateString + " " + tranMsg;
         }
         else
         {
            tranMsg = dateString + " [" + tag + "] " + tranMsg;
         }
         pushMsg(tranMsg);
      }
      
      private function getDateString(date:Date) : String
      {
         return date.fullYear + "-" + fixTwoDigit(date.month + 1) + "-" + fixTwoDigit(date.date) + " " + fixTwoDigit(date.hours) + "-" + fixTwoDigit(date.minutes) + "-" + fixTwoDigit(date.seconds);
      }
      
      private function fixTwoDigit(digit:int) : String
      {
         return digit < 10?"0" + digit:digit.toString();
      }
      
      private function pushMsg(msg:String) : void
      {
         _msgArr.push(msg);
         if(_msgArr.length > 1000 + 10)
         {
            _msgArr.splice(0,10);
         }
      }
   }
}
