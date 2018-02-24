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
      
      public function RoleRechargeMgr(){super();}
      
      public static function get instance() : RoleRechargeMgr{return null;}
      
      public function setup() : void{}
      
      public function get model() : RoleRechargeModel{return null;}
      
      override protected function start() : void{}
      
      private function onLoaded() : void{}
      
      public function roleRechargeData(param1:Vector.<GiftRewardInfo>, param2:int) : RoleRechargeInfo{return null;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function set isOpen(param1:Boolean) : void{}
   }
}
