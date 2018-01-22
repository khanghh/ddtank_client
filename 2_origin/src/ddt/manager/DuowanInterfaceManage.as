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
      
      private function __userActionNotice(param1:DuowanInterfaceEvent) : void
      {
         var _loc4_:String = "4";
         var _loc3_:String = PlayerManager.Instance.Self.ID.toString();
         _loc3_ = encodeURI(_loc3_);
         var _loc2_:String = MD5.hash(_loc3_ + _loc4_ + key);
         send(_loc4_,_loc3_,_loc2_);
      }
      
      private function __upGradeNotice(param1:DuowanInterfaceEvent) : void
      {
         var _loc4_:String = "1";
         var _loc3_:String = PlayerManager.Instance.Self.ID.toString();
         _loc3_ = encodeURI(_loc3_);
         var _loc2_:String = MD5.hash(_loc3_ + _loc4_ + key);
         send(_loc4_,_loc3_,_loc2_);
      }
      
      private function __onLineNotice(param1:DuowanInterfaceEvent) : void
      {
         var _loc4_:String = "2";
         var _loc3_:String = PlayerManager.Instance.Self.ID.toString();
         _loc3_ = encodeURI(_loc3_);
         var _loc2_:String = MD5.hash(_loc3_ + _loc4_ + key);
         send(_loc4_,_loc3_,_loc2_);
      }
      
      private function __outLineNotice(param1:DuowanInterfaceEvent) : void
      {
         var _loc4_:String = "3";
         var _loc3_:String = PlayerManager.Instance.Self.ID.toString();
         _loc3_ = encodeURI(_loc3_);
         var _loc2_:String = MD5.hash(_loc3_ + _loc4_ + key);
         send(_loc4_,_loc3_,_loc2_);
      }
      
      private function send(param1:String, param2:String, param3:String) : void
      {
         var _loc5_:String = PathManager.userActionNotice();
         if(_loc5_ == "")
         {
            return;
         }
         _loc5_ = _loc5_.replace("{username}",param2);
         _loc5_ = _loc5_.replace("{type}",param1);
         _loc5_ = _loc5_.replace("{sign}",param3);
         var _loc4_:RequestLoader = LoadResourceManager.Instance.createLoader(_loc5_,6,null,"GET",null,false,true);
         _loc4_.addEventListener("complete",__loaderComplete2);
         LoadResourceManager.Instance.startLoad(_loc4_);
      }
      
      private function __loaderComplete2(param1:LoaderEvent) : void
      {
      }
   }
}
