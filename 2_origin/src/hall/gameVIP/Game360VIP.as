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
         var _loc2_:int = TimeManager.Instance.Now().getTime() / 1000;
         var _loc1_:String = PlayerManager.Instance.Self.LoginName + "Er-TpyPLa8cI5oKSOqgkjg==" + _loc2_.toString();
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener("complete",__addComplete);
         _loc3_.addEventListener("ioError",__addError);
         var _loc5_:URLRequest = new URLRequest("http://public.api.360game.vn/script/sdk/get-vip-info");
         var _loc4_:URLVariables = new URLVariables();
         _loc4_["zingAccount"] = PlayerManager.Instance.Self.LoginName;
         _loc4_["authKey"] = MD5.hash(_loc1_);
         _loc4_["time"] = _loc2_;
         _loc5_.data = _loc4_;
         _loc3_.load(_loc5_);
      }
      
      private function __addComplete(param1:Event) : void
      {
         var _loc5_:String = JSON.stringify((param1.currentTarget as URLLoader).data);
         var _loc6_:Object = (param1.currentTarget as URLLoader).data;
         var _loc3_:Array = _loc5_.split(",");
         var _loc4_:int = _loc3_[2].toString().split(":")[1];
         var _loc2_:int = _loc3_[1].toString().split(":")[1];
         if(_loc4_ == 0)
         {
            vipLevel = _loc2_;
         }
      }
      
      private function __addError(param1:IOErrorEvent) : void
      {
      }
   }
}
