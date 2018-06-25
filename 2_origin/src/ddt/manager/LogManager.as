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
       
      
      public function LogManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function getInstance() : LogManager
      {
         if(instance == null)
         {
            instance = new LogManager();
         }
         return instance;
      }
      
      public function sendLog(logMsg:String = "") : void
      {
         var req:URLRequest = new URLRequest(PathManager.solveRequestPath("LogClickTip.ashx"));
         var toServerData:URLVariables = new URLVariables();
         toServerData["title"] = logMsg;
         req.data = toServerData;
         var loader:URLLoader = new URLLoader(req);
         loader.load(req);
         loader.addEventListener("ioError",onIOError);
      }
      
      protected function onIOError(event:IOErrorEvent) : void
      {
      }
   }
}
