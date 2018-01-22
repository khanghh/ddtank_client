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
      
      public function roleRechargeData(param1:Vector.<GiftRewardInfo>, param2:int) : RoleRechargeInfo
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:RoleRechargeInfo = new RoleRechargeInfo();
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc6_ = param1[_loc7_] as GiftBagInfo;
            _loc5_ = 0;
            while(_loc5_ < _loc6_.giftConditionArr.length)
            {
               _loc3_ = _loc6_.giftConditionArr[_loc5_] as GiftConditionInfo;
               if(_loc3_.conditionIndex == 0 && _loc3_.conditionValue == param2)
               {
                  _loc4_.beginIndex = _loc3_.conditionValue;
                  _loc4_.endIndex = _loc3_.remain1;
                  _loc4_.giftRewardArr = _loc6_.giftRewardArr.slice();
                  return _loc4_;
               }
               _loc5_++;
            }
            _loc7_++;
         }
         return _loc4_;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
   }
}
