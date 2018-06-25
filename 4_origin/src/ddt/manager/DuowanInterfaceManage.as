package ddt.manager
{
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.utils.MD5;
   import ddt.events.DuowanInterfaceEvent;
   import flash.events.EventDispatcher;
   
   public class DuowanInterfaceManage extends EventDispatcher
   {
      
      private static var _instance:DuowanInterfaceManage;
       
      
      private var key:String;
      
      public function DuowanInterfaceManage()
      {
         super();
         key = "sdkxccjlqaoehtdwjkdycdrw";
         addEventListener("addRole",__userActionNotice);
         addEventListener("upGrade",__upGradeNotice);
         addEventListener("onLine",__onLineNotice);
         addEventListener("outLine",__outLineNotice);
      }
      
      public static function get Instance() : DuowanInterfaceManage
      {
         if(_instance == null)
         {
            _instance = new DuowanInterfaceManage();
         }
         return _instance;
      }
      
      private function __userActionNotice(event:DuowanInterfaceEvent) : void
      {
         var op:String = "4";
         var username:String = PlayerManager.Instance.Self.ID.toString();
         username = encodeURI(username);
         var sign:String = MD5.hash(username + op + key);
         send(op,username,sign);
      }
      
      private function __upGradeNotice(event:DuowanInterfaceEvent) : void
      {
         var op:String = "1";
         var username:String = PlayerManager.Instance.Self.ID.toString();
         username = encodeURI(username);
         var sign:String = MD5.hash(username + op + key);
         send(op,username,sign);
      }
      
      private function __onLineNotice(event:DuowanInterfaceEvent) : void
      {
         var op:String = "2";
         var username:String = PlayerManager.Instance.Self.ID.toString();
         username = encodeURI(username);
         var sign:String = MD5.hash(username + op + key);
         send(op,username,sign);
      }
      
      private function __outLineNotice(event:DuowanInterfaceEvent) : void
      {
         var op:String = "3";
         var username:String = PlayerManager.Instance.Self.ID.toString();
         username = encodeURI(username);
         var sign:String = MD5.hash(username + op + key);
         send(op,username,sign);
      }
      
      private function send(op:String, username:String, sign:String) : void
      {
         var requestURL:String = PathManager.userActionNotice();
         if(requestURL == "")
         {
            return;
         }
         requestURL = requestURL.replace("{username}",username);
         requestURL = requestURL.replace("{type}",op);
         requestURL = requestURL.replace("{sign}",sign);
         var loader:RequestLoader = LoadResourceManager.Instance.createLoader(requestURL,6,null,"GET",null,false,true);
         loader.addEventListener("complete",__loaderComplete2);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __loaderComplete2(event:LoaderEvent) : void
      {
      }
   }
}
