package ddt.manager
{
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.sendToURL;
   
   public class ExternalInterfaceManager
   {
      
      private static var loader:URLLoader;
       
      
      public function ExternalInterfaceManager()
      {
         super();
      }
      
      public static function sendToAgent(param1:int, param2:int = -1, param3:String = "", param4:String = "", param5:int = -1, param6:String = "", param7:String = "") : void
      {
         var _loc8_:URLRequest = new URLRequest(PathManager.solveExternalInterfacePath());
         var _loc9_:URLVariables = new URLVariables();
         _loc9_["op"] = param1;
         if(param2 > -1)
         {
            _loc9_["uid"] = param2;
         }
         if(param3 != "")
         {
            _loc9_["role"] = param3;
         }
         if(param4 != "")
         {
            _loc9_["ser"] = param4;
         }
         if(param5 > -1)
         {
            _loc9_["num"] = param5;
         }
         if(param6 != "")
         {
            _loc9_["pn"] = param6;
         }
         if(param7 != "")
         {
            _loc9_["role2"] = param7;
         }
         _loc8_.data = _loc9_;
      }
      
      public static function sendTo360Agent(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc5_:String = PathManager.solveFillPage();
         var _loc2_:Number = _loc5_.indexOf("server_id=") + 10;
         var _loc7_:Number = _loc5_.indexOf("&uid");
         var _loc4_:String = _loc5_.slice(_loc2_,_loc7_);
         if(PathManager.ExternalInterface360Enabel())
         {
            _loc3_ = new URLRequest(PathManager.ExternalInterface360Path());
            _loc6_ = new URLVariables();
            _loc6_["game"] = "ddt";
            _loc6_["server"] = _loc4_;
            _loc6_["qid"] = PlayerManager.Instance.Account.Account;
            _loc6_["event"] = getEvent(param1);
            _loc6_["time"] = new Date().getTime();
            _loc3_.data = _loc6_;
            sendToURL(_loc3_);
         }
      }
      
      private static function getEvent(param1:int) : String
      {
         switch(int(param1))
         {
            case 0:
               return "pageload";
            case 1:
               return "beforeloadflash";
            case 2:
               return "flashloaded";
            case 3:
               return "playercreated";
            case 4:
               return "entergame";
         }
      }
   }
}
