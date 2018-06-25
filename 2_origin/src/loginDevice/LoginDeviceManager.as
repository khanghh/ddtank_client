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
      
      public function LoginDeviceManager(instance:LoginDeviceInstance)
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
      
      private function __checkLoginUa(e:LoginDeviceEvent) : void
      {
         loginTypeUnCheck = DDT.REQUEST_BY_DEVICE;
         SocketManager.Instance.out.loginDeviceSendUaToCheck(loginTypeUnCheck == "3");
      }
      
      private function __loginDeviceHandler(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var b:Boolean = pkg.readBoolean();
         loginType = !!b?"3":"0";
         var getDownCount:int = pkg.readInt();
         isGetDownReward = getDownCount > 0;
         var getDailyCount:int = pkg.readInt();
         if(getDailyCount > 0 != isGetDailyReward)
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
      
      public function templateDataSetup(dataList:Array) : void
      {
         var i:int = 0;
         var info:* = null;
         if(dataList)
         {
            downRewardInfoList = [];
            dailyRewardInfoList = [];
            for(i = 0; i < dataList.length; )
            {
               info = dataList[i];
               if(info.Quality == 1)
               {
                  downRewardInfoList.push(info);
               }
               else
               {
                  dailyRewardInfoList.push(info);
               }
               i++;
            }
         }
      }
      
      public function getInventoryItemInfo(info:LoginDeviceRewardInfo) : InventoryItemInfo
      {
         var tempInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(info.TemplateID);
         var tInfo:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(tInfo,tempInfo);
         tInfo.LuckCompose = info.TemplateID;
         tInfo.ValidDate = info.ValidDate;
         tInfo.Count = info.Count;
         tInfo.IsBinds = info.IsBind;
         tInfo.StrengthenLevel = info.StrengthLevel;
         tInfo.AttackCompose = info.AttackCompose;
         tInfo.DefendCompose = info.DefendCompose;
         tInfo.AgilityCompose = info.AgilityCompose;
         tInfo.LuckCompose = info.LuckCompose;
         return tInfo;
      }
      
      public function createCell(info:LoginDeviceRewardInfo) : BagCell
      {
         var itemInfo:InventoryItemInfo = LoginDeviceManager.instance().getInventoryItemInfo(info);
         if(itemInfo == null)
         {
            return null;
         }
         var _cell:BagCell = new BagCell(0,itemInfo,true,ComponentFactory.Instance.creatBitmap("loginDevice.rewards.itemBg"));
         _cell.width = 64;
         _cell.height = 64;
         _cell.setCount(itemInfo.Count);
         return _cell;
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
