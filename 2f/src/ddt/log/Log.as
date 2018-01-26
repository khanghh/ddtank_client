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
      
      public function Log(){super();}
      
      public static function get instance() : Log{return null;}
      
      public function init(param1:Stage) : void{}
      
      private function onKeyUp(param1:KeyboardEvent) : void{}
      
      private function onFileComplete(param1:Event) : void{}
      
      public function log(param1:*, param2:String = null) : void{}
      
      private function getDateString(param1:Date) : String{return null;}
      
      private function fixTwoDigit(param1:int) : String{return null;}
      
      private function pushMsg(param1:String) : void{}
   }
}
