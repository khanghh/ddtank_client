package ddt.manager
{
   import ddt.view.chat.ChatEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   
   public class SystemPostManager extends EventDispatcher
   {
      
      public static var SYSTEMPOST_UPDATE:String = "systemPostUpdate";
      
      private static var instance:SystemPostManager;
       
      
      private var _postInfo:Object;
      
      public function SystemPostManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get Instance() : SystemPostManager
      {
         if(instance == null)
         {
            instance = new SystemPostManager();
         }
         return instance;
      }
      
      public function setup() : void
      {
         ChatManager.Instance.addEventListener("systemPost",__onReceivePost);
      }
      
      protected function __onReceivePost(event:ChatEvent) : void
      {
         var msg:String = event.data.msg;
         var pkg:PackageIn = event.data.pkg;
         var turnType:int = pkg.readInt();
         addInfo(msg,turnType);
         dispatchEvent(new Event(SYSTEMPOST_UPDATE));
      }
      
      private function addInfo(msg:String, type:int) : void
      {
         if(!_postInfo)
         {
            _postInfo = {};
         }
         _postInfo["msg"] = msg;
         _postInfo["type"] = type;
      }
      
      public function get postInfo() : Object
      {
         return _postInfo;
      }
   }
}
