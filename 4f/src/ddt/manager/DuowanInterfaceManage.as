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
      
      public function DuowanInterfaceManage(){super();}
      
      public static function get Instance() : DuowanInterfaceManage{return null;}
      
      private function __userActionNotice(param1:DuowanInterfaceEvent) : void{}
      
      private function __upGradeNotice(param1:DuowanInterfaceEvent) : void{}
      
      private function __onLineNotice(param1:DuowanInterfaceEvent) : void{}
      
      private function __outLineNotice(param1:DuowanInterfaceEvent) : void{}
      
      private function send(param1:String, param2:String, param3:String) : void{}
      
      private function __loaderComplete2(param1:LoaderEvent) : void{}
   }
}
