package hall.gameVIP
{
   import com.pickgliss.utils.MD5;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class Game360VIP
   {
      
      public static var vipLevel:int;
       
      
      public function Game360VIP()
      {
         super();
         var time:int = TimeManager.Instance.Now().getTime() / 1000;
         var strMd5:String = PlayerManager.Instance.Self.LoginName + "Er-TpyPLa8cI5oKSOqgkjg==" + time.toString();
         var loader:URLLoader = new URLLoader();
         loader.addEventListener("complete",__addComplete);
         loader.addEventListener("ioError",__addError);
         var url:URLRequest = new URLRequest("http://public.api.360game.vn/script/sdk/get-vip-info");
         var obj:URLVariables = new URLVariables();
         obj["zingAccount"] = PlayerManager.Instance.Self.LoginName;
         obj["authKey"] = MD5.hash(strMd5);
         obj["time"] = time;
         url.data = obj;
         loader.load(url);
      }
      
      private function __addComplete(evt:Event) : void
      {
         var data:String = JSON.stringify((evt.currentTarget as URLLoader).data);
         var obj:Object = (evt.currentTarget as URLLoader).data;
         var dataArr:Array = data.split(",");
         var errCode:int = dataArr[2].toString().split(":")[1];
         var _vipLevel:int = dataArr[1].toString().split(":")[1];
         if(errCode == 0)
         {
            vipLevel = _vipLevel;
         }
      }
      
      private function __addError(evt:IOErrorEvent) : void
      {
      }
   }
}
