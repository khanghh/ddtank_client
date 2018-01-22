package ddt.view.im
{
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import road7th.utils.StringHelper;
   
   public class AddCommunityFriend
   {
       
      
      public function AddCommunityFriend(param1:String, param2:String)
      {
         super();
         if(StringHelper.isNullOrEmpty(PathManager.solveCommunityFriend))
         {
            return;
         }
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener("complete",__addFriendComplete);
         _loc3_.addEventListener("ioError",__addFriendError);
         var _loc5_:URLRequest = new URLRequest(PathManager.solveCommunityFriend);
         var _loc4_:URLVariables = new URLVariables();
         _loc4_["fuid"] = PlayerManager.Instance.Self.LoginName;
         _loc4_["fnick"] = PlayerManager.Instance.Self.NickName;
         _loc4_["tuid"] = param1;
         _loc4_["tnick"] = param2;
         _loc5_.data = _loc4_;
         _loc3_.load(_loc5_);
      }
      
      private function __addFriendComplete(param1:Event) : void
      {
         if((param1.currentTarget as URLLoader).data != "0")
         {
         }
      }
      
      private function __addFriendError(param1:IOErrorEvent) : void
      {
      }
   }
}
