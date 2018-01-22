package signActivity
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelperUIModuleLoad;
   import hallIcon.HallIconManager;
   import signActivity.model.SignActivityModel;
   import signActivity.view.SignActivityFrame;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class SignActivityMgr extends CoreManager
   {
      
      private static var _instance:SignActivityMgr;
       
      
      private var _frame:SignActivityFrame;
      
      private var _model:SignActivityModel;
      
      private var _isOpen:Boolean = false;
      
      public function SignActivityMgr()
      {
         super();
      }
      
      public static function get instance() : SignActivityMgr
      {
         if(!_instance)
         {
            _instance = new SignActivityMgr();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new SignActivityModel();
      }
      
      public function get model() : SignActivityModel
      {
         return _model;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["signActivity"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         var _loc2_:GmActivityInfo = WonderfulActivityManager.Instance.getActivityDataById(SignActivityMgr.instance.model.actId);
         var _loc1_:int = findSignActivityType(_loc2_.giftbagArray);
         _frame = ComponentFactory.Instance.creatCustomObject("SignActivity.SignActivityFrame",[_loc1_]);
         _frame.titleText = LanguageMgr.GetTranslation("ddt.SignActivity.title");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function findSignActivityType(param1:Array) : int
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_] as GiftBagInfo;
            if(_loc3_.giftConditionArr[0].conditionIndex == 2)
            {
               _loc2_ = _loc3_.giftConditionArr[0].conditionValue;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function showIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("signActivity",_isOpen);
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
