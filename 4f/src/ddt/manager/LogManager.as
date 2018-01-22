package ddt.manager
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class LogManager extends EventDispatcher
   {
      
      private static var instance:LogManager;
       
      
      public function LogManager(param1:IEventDispatcher = null){super(null);}
      
      public static function getInstance() : LogManager{return null;}
      
      public function sendLog(param1:String = "") : void{}
      
      protected function onIOError(param1:IOErrorEvent) : void{}
   }
}
