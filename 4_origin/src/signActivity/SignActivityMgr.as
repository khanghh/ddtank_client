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
         var _xmlData:GmActivityInfo = WonderfulActivityManager.Instance.getActivityDataById(SignActivityMgr.instance.model.actId);
         var index:int = findSignActivityType(_xmlData.giftbagArray);
         _frame = ComponentFactory.Instance.creatCustomObject("SignActivity.SignActivityFrame",[index]);
         _frame.titleText = LanguageMgr.GetTranslation("ddt.SignActivity.title");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function findSignActivityType(array:Array) : int
      {
         var i:int = 0;
         var info:* = null;
         var index:int = 0;
         for(i = 0; i < array.length; )
         {
            info = array[i] as GiftBagInfo;
            if(info.giftConditionArr[0].conditionIndex == 2)
            {
               index = info.giftConditionArr[0].conditionValue;
            }
            i++;
         }
         return index;
      }
      
      public function showIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("signActivity",_isOpen);
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
