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
      
      public function ConRechargeManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function set giftbagArray(value:Array) : void
      {
         var arr:* = null;
         var i:int = 0;
         var info:* = null;
         var j:int = 0;
         _giftbagArray = value;
         dayGiftbagArray = [];
         longGiftbagArray = [];
         for(i = 0; i < _giftbagArray.length; )
         {
            info = _giftbagArray[i];
            if(info.giftConditionArr[0].conditionIndex == 1)
            {
               dayGiftbagArray.push(info);
            }
            else
            {
               arr = [];
               j = 0;
               while(true)
               {
                  if(j >= longGiftbagArray.length)
                  {
                     arr.push(info);
                     longGiftbagArray.push(arr);
                     break;
                  }
                  if(info.giftConditionArr[0].conditionValue == longGiftbagArray[j][0].giftConditionArr[0].conditionValue)
                  {
                     longGiftbagArray[j].push(info);
                     break;
                  }
                  j++;
               }
            }
            i++;
         }
      }
   }
}
