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
      
      public function LoginDeviceManager(param1:LoginDeviceInstance)
      {
         super();
      }
      
      public static function instance() : LoginDeviceManager
      {
         if(_instance == null)
         {
            _instance = new LoginDeviceManager(new LoginDeviceInstance());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("check_ua",__checkLoginUa);
         SocketManager.Instance.addEventListener("login_device",__loginDeviceHandler);
      }
      
      private function __checkLoginUa(param1:LoginDeviceEvent) : void
      {
         loginTypeUnCheck = DDT.REQUEST_BY_DEVICE;
         SocketManager.Instance.out.loginDeviceSendUaToCheck(loginTypeUnCheck == "3");
      }
      
      private function __loginDeviceHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc5_.readBoolean();
         loginType = !!_loc2_?"3":"0";
         var _loc4_:int = _loc5_.readInt();
         isGetDownReward = _loc4_ > 0;
         var _loc3_:int = _loc5_.readInt();
         if(_loc3_ > 0 != isGetDailyReward)
         {
            isGetDailyReward = !isGetDailyReward;
            dispatchEvent(new LoginDeviceEvent("reward_view_update"));
         }
      }
      
      override protected function start() : void
      {
         _loginDeviceLoad();
      }
      
      private function _loginDeviceLoad() : void
      {
         new HelperUIModuleLoad().loadUIModule(["loginDevice"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showMainView"));
      }
      
      public function hide() : void
      {
         dispatchEvent(new Event("hideMainView"));
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1)
         {
            downRewardInfoList = [];
            dailyRewardInfoList = [];
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_ = param1[_loc3_];
               if(_loc2_.Quality == 1)
               {
                  downRewardInfoList.push(_loc2_);
               }
               else
               {
                  dailyRewardInfoList.push(_loc2_);
               }
               _loc3_++;
            }
         }
      }
      
      public function getInventoryItemInfo(param1:LoginDeviceRewardInfo) : InventoryItemInfo
      {
         var _loc3_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1.TemplateID);
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc2_.LuckCompose = param1.TemplateID;
         _loc2_.ValidDate = param1.ValidDate;
         _loc2_.Count = param1.Count;
         _loc2_.IsBinds = param1.IsBind;
         _loc2_.StrengthenLevel = param1.StrengthLevel;
         _loc2_.AttackCompose = param1.AttackCompose;
         _loc2_.DefendCompose = param1.DefendCompose;
         _loc2_.AgilityCompose = param1.AgilityCompose;
         _loc2_.LuckCompose = param1.LuckCompose;
         return _loc2_;
      }
      
      public function createCell(param1:LoginDeviceRewardInfo) : BagCell
      {
         var _loc3_:InventoryItemInfo = LoginDeviceManager.instance().getInventoryItemInfo(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc2_:BagCell = new BagCell(0,_loc3_,true,ComponentFactory.Instance.creatBitmap("loginDevice.rewards.itemBg"));
         _loc2_.width = 64;
         _loc2_.height = 64;
         _loc2_.setCount(_loc3_.Count);
         return _loc2_;
      }
   }
}

class LoginDeviceInstance
{
    
   
   function LoginDeviceInstance()
   {
      super();
   }
}
