package roleRecharge
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelperUIModuleLoad;
   import roleRecharge.data.RoleRechargeInfo;
   import roleRecharge.model.RoleRechargeModel;
   import roleRecharge.view.RoleRechargeFrame;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class RoleRechargeMgr extends CoreManager
   {
      
      private static var _instance:RoleRechargeMgr;
       
      
      private var _frame:RoleRechargeFrame;
      
      private var _model:RoleRechargeModel;
      
      private var _isOpen:Boolean = false;
      
      public function RoleRechargeMgr()
      {
         super();
      }
      
      public static function get instance() : RoleRechargeMgr
      {
         if(!_instance)
         {
            _instance = new RoleRechargeMgr();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new RoleRechargeModel();
      }
      
      public function get model() : RoleRechargeModel
      {
         return _model;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["roleRecharge"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         _frame = ComponentFactory.Instance.creatCustomObject("RoleRecharge.RoleRechargeFrame");
         _frame.titleText = LanguageMgr.GetTranslation("ddt.RoleRecharge.title");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      public function roleRechargeData(arr:Vector.<GiftRewardInfo>, index:int) : RoleRechargeInfo
      {
         var i:int = 0;
         var info:* = null;
         var j:int = 0;
         var conInfo:* = null;
         var roleRechargeInfo:RoleRechargeInfo = new RoleRechargeInfo();
         for(i = 0; i < arr.length; )
         {
            info = arr[i] as GiftBagInfo;
            for(j = 0; j < info.giftConditionArr.length; )
            {
               conInfo = info.giftConditionArr[j] as GiftConditionInfo;
               if(conInfo.conditionIndex == 0 && conInfo.conditionValue == index)
               {
                  roleRechargeInfo.beginIndex = conInfo.conditionValue;
                  roleRechargeInfo.endIndex = conInfo.remain1;
                  roleRechargeInfo.giftRewardArr = info.giftRewardArr.slice();
                  return roleRechargeInfo;
               }
               j++;
            }
            i++;
         }
         return roleRechargeInfo;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(value:Boolean) : void
      {
         _isOpen = value;
      }
   }
}
