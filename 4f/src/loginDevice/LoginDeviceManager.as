package loginDevice
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.DDT;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class LoginDeviceManager extends CoreManager
   {
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      public static const HIDEMAINVIEW:String = "hideMainView";
      
      public static const DOWN_VIEW_INDEX:int = 1;
      
      public static const REWARD_VIEW_INDEX:int = 0;
      
      private static var _instance:LoginDeviceManager;
       
      
      public var loginTypeUnCheck:String = "0";
      
      public var loginType:String = "0";
      
      public var isGetDownReward:Boolean = false;
      
      public var isGetDailyReward:Boolean = false;
      
      public var downRewardInfoList:Array;
      
      public var dailyRewardInfoList:Array;
      
      public function LoginDeviceManager(param1:LoginDeviceInstance){super();}
      
      public static function instance() : LoginDeviceManager{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      private function __checkLoginUa(param1:LoginDeviceEvent) : void{}
      
      private function __loginDeviceHandler(param1:CrazyTankSocketEvent) : void{}
      
      override protected function start() : void{}
      
      private function _loginDeviceLoad() : void{}
      
      private function onLoaded() : void{}
      
      public function hide() : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      public function getInventoryItemInfo(param1:LoginDeviceRewardInfo) : InventoryItemInfo{return null;}
      
      public function createCell(param1:LoginDeviceRewardInfo) : BagCell{return null;}
   }
}

class LoginDeviceInstance
{
    
   
   function LoginDeviceInstance(){super();}
}
