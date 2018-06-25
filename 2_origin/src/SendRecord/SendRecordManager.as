package SendRecord
{
   import ddt.manager.DesktopManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.StatisticManager;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.system.fscommand;
   import flash.utils.Dictionary;
   
   public class SendRecordManager
   {
      
      private static var _instance:SendRecordManager;
       
      
      private var _browserInfo:String = "";
      
      public function SendRecordManager()
      {
         super();
      }
      
      public static function get Instance() : SendRecordManager
      {
         if(_instance == null)
         {
            _instance = new SendRecordManager();
         }
         return _instance;
      }
      
      private function sendRecordUserVersion(paramStr:String = "") : void
      {
         var data:* = null;
         var paramsCount:int = 0;
         var i:int = 0;
         var userInfo:Dictionary = new Dictionary();
         if(paramStr != "")
         {
            data = paramStr.split("|");
            paramsCount = data.length / 2;
            for(i = 0; i < paramsCount; )
            {
               userInfo[data[i * 2]] = data[i * 2 + 1];
               i++;
            }
         }
         var varialbes:URLVariables = new URLVariables();
         var urlLoader:URLLoader = new URLLoader();
         varialbes.Browser = _browserInfo;
         varialbes.SiteName = StatisticManager.siteName;
         varialbes.UserName = PlayerManager.Instance.Account.Account;
         varialbes.Flash = Capabilities.version.split(" ")[1];
         varialbes.Sys = Capabilities.os;
         varialbes.Is64Bit = Capabilities.supports64BitProcesses;
         varialbes.Screen = Capabilities.screenResolutionX + "X" + Capabilities.screenResolutionY;
         var _loc11_:int = 0;
         var _loc10_:* = userInfo;
         for(var key in userInfo)
         {
            varialbes[key] = userInfo[key];
         }
         var request:URLRequest = new URLRequest(PathManager.solveRequestPath("RecordSysInfo.ashx"));
         request.method = "POST";
         request.data = varialbes;
         urlLoader.load(request);
      }
      
      private function browserInfo(msg:String) : void
      {
         _browserInfo = msg;
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            sendRecordUserVersion();
         }
         else
         {
            ExternalInterface.addCallback("GetUserData",sendRecordUserVersion);
            fscommand("AddUserData");
         }
      }
      
      public function setUp() : void
      {
         var msg:* = null;
         if(ExternalInterface.available)
         {
            msg = ExternalInterface.call("getBrowserInfo");
            browserInfo(msg);
         }
      }
   }
}
