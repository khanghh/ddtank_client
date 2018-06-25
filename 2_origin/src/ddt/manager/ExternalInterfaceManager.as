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
      
      public static function sendToAgent(op:int, userID:int = -1, nickName:String = "", serverName:String = "", num:int = -1, pName:String = "", nickName2:String = "") : void
      {
         var ur:URLRequest = new URLRequest(PathManager.solveExternalInterfacePath());
         var variable:URLVariables = new URLVariables();
         variable["op"] = op;
         if(userID > -1)
         {
            variable["uid"] = userID;
         }
         if(nickName != "")
         {
            variable["role"] = nickName;
         }
         if(serverName != "")
         {
            variable["ser"] = serverName;
         }
         if(num > -1)
         {
            variable["num"] = num;
         }
         if(pName != "")
         {
            variable["pn"] = pName;
         }
         if(nickName2 != "")
         {
            variable["role2"] = nickName2;
         }
         ur.data = variable;
      }
      
      public static function sendTo360Agent(type:int) : void
      {
         var ur:* = null;
         var variable:* = null;
         var sitePath:String = PathManager.solveFillPage();
         var start:Number = sitePath.indexOf("server_id=") + 10;
         var end:Number = sitePath.indexOf("&uid");
         var serverID:String = sitePath.slice(start,end);
         if(PathManager.ExternalInterface360Enabel())
         {
            ur = new URLRequest(PathManager.ExternalInterface360Path());
            variable = new URLVariables();
            variable["game"] = "ddt";
            variable["server"] = serverID;
            variable["qid"] = PlayerManager.Instance.Account.Account;
            variable["event"] = getEvent(type);
            variable["time"] = new Date().getTime();
            ur.data = variable;
            sendToURL(ur);
         }
      }
      
      private static function getEvent(type:int) : String
      {
         switch(int(type))
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
