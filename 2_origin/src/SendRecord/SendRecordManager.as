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
      
      private function sendRecordUserVersion(param1:String = "") : void
      {
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:Dictionary = new Dictionary();
         if(param1 != "")
         {
            _loc5_ = param1.split("|");
            _loc3_ = _loc5_.length / 2;
            _loc9_ = 0;
            while(_loc9_ < _loc3_)
            {
               _loc6_[_loc5_[_loc9_ * 2]] = _loc5_[_loc9_ * 2 + 1];
               _loc9_++;
            }
         }
         var _loc8_:URLVariables = new URLVariables();
         var _loc2_:URLLoader = new URLLoader();
         _loc8_.Browser = _browserInfo;
         _loc8_.SiteName = StatisticManager.siteName;
         _loc8_.UserName = PlayerManager.Instance.Account.Account;
         _loc8_.Flash = Capabilities.version.split(" ")[1];
         _loc8_.Sys = Capabilities.os;
         _loc8_.Is64Bit = Capabilities.supports64BitProcesses;
         _loc8_.Screen = Capabilities.screenResolutionX + "X" + Capabilities.screenResolutionY;
         var _loc11_:int = 0;
         var _loc10_:* = _loc6_;
         for(var _loc7_ in _loc6_)
         {
            _loc8_[_loc7_] = _loc6_[_loc7_];
         }
         var _loc4_:URLRequest = new URLRequest(PathManager.solveRequestPath("RecordSysInfo.ashx"));
         _loc4_.method = "POST";
         _loc4_.data = _loc8_;
         _loc2_.load(_loc4_);
      }
      
      private function browserInfo(param1:String) : void
      {
         _browserInfo = param1;
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
         var _loc1_:* = null;
         if(ExternalInterface.available)
         {
            _loc1_ = ExternalInterface.call("getBrowserInfo");
            browserInfo(_loc1_);
         }
      }
   }
}
