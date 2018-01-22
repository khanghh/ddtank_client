package conRecharge
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import conRecharge.view.ConRechargeFrame;
   import ddt.CoreManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   import wonderfulActivity.data.GiftBagInfo;
   
   public class ConRechargeManager extends CoreManager
   {
      
      private static var _instance:ConRechargeManager;
       
      
      public var isOpen:Boolean;
      
      private var _frame:ConRechargeFrame;
      
      private var _giftbagArray:Array;
      
      public var dayGiftbagArray:Array;
      
      public var longGiftbagArray:Array;
      
      public var beginTime:String;
      
      public var endTime:String;
      
      public var actId:String;
      
      public function ConRechargeManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : ConRechargeManager
      {
         if(!_instance)
         {
            _instance = new ConRechargeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["conRecharge"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         _frame = ComponentFactory.Instance.creatCustomObject("conRecharge.ConRechargeFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      public function showIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("conRecharge",isOpen);
      }
      
      public function set giftbagArray(param1:Array) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         _giftbagArray = param1;
         dayGiftbagArray = [];
         longGiftbagArray = [];
         _loc5_ = 0;
         while(_loc5_ < _giftbagArray.length)
         {
            _loc4_ = _giftbagArray[_loc5_];
            if(_loc4_.giftConditionArr[0].conditionIndex == 1)
            {
               dayGiftbagArray.push(_loc4_);
            }
            else
            {
               _loc2_ = [];
               _loc3_ = 0;
               while(true)
               {
                  if(_loc3_ >= longGiftbagArray.length)
                  {
                     _loc2_.push(_loc4_);
                     longGiftbagArray.push(_loc2_);
                     break;
                  }
                  if(_loc4_.giftConditionArr[0].conditionValue == longGiftbagArray[_loc3_][0].giftConditionArr[0].conditionValue)
                  {
                     longGiftbagArray[_loc3_].push(_loc4_);
                     break;
                  }
                  _loc3_++;
               }
            }
            _loc5_++;
         }
      }
   }
}
