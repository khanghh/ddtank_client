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
       
      
      public function AddCommunityFriend($friendId:String, $friendNickName:String)
      {
         super();
         if(StringHelper.isNullOrEmpty(PathManager.solveCommunityFriend))
         {
            return;
         }
         var loader:URLLoader = new URLLoader();
         loader.addEventListener("complete",__addFriendComplete);
         loader.addEventListener("ioError",__addFriendError);
         var url:URLRequest = new URLRequest(PathManager.solveCommunityFriend);
         var obj:URLVariables = new URLVariables();
         obj["fuid"] = PlayerManager.Instance.Self.LoginName;
         obj["fnick"] = PlayerManager.Instance.Self.NickName;
         obj["tuid"] = $friendId;
         obj["tnick"] = $friendNickName;
         url.data = obj;
         loader.load(url);
      }
      
      private function __addFriendComplete(evt:Event) : void
      {
         if((evt.currentTarget as URLLoader).data != "0")
         {
         }
      }
      
      private function __addFriendError(evt:IOErrorEvent) : void
      {
      }
   }
}
