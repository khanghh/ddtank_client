package panicBuying
{
   import ddt.CoreManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.utils.Dictionary;
   import hallIcon.HallIconManager;
   import panicBuying.event.PanicBuyingEvent;
   import road7th.utils.DateUtils;
   import shop.ShopEvent;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class PanicBuyingManager extends CoreManager
   {
      
      private static var _instance:PanicBuyingManager;
       
      
      private var requestArr:Array;
      
      public var levelId:String;
      
      private var _vipId:String;
      
      public var indivId:String;
      
      public var entireId:String;
      
      public var newEntireId:String;
      
      public var showIconFlag:int;
      
      public function PanicBuyingManager()
      {
         super();
         requestArr = [];
      }
      
      public static function get instance() : PanicBuyingManager
      {
         if(!_instance)
         {
            _instance = new PanicBuyingManager();
         }
         return _instance;
      }
      
      public function get vipId() : String
      {
         return _vipId;
      }
      
      public function set vipId(param1:String) : void
      {
         _vipId = param1;
      }
      
      public function setup() : void
      {
      }
      
      protected function __discountChange(param1:ShopEvent) : void
      {
         if(ShopManager.Instance.isHasDisCountGoods(1))
         {
            showIconFlag = showIconFlag | 1;
         }
         else
         {
            showIconFlag = showIconFlag | 0;
         }
         if(showIconFlag > 0)
         {
            showEnterIcon();
         }
         else
         {
            hideEnterIcon();
         }
      }
      
      public function checkOpen() : void
      {
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc1_:Dictionary = WonderfulActivityManager.Instance.activityData;
         showIconFlag = 0;
         levelId = "";
         vipId = "";
         indivId = "";
         entireId = "";
         newEntireId = "";
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc3_ in _loc1_)
         {
            if(_loc3_.activityType == 19 && (_loc3_.activityChildType == 1 || _loc3_.activityChildType == 2 || _loc3_.activityChildType == 3 || _loc3_.activityChildType == 4 || _loc3_.activityChildType == 5))
            {
               if(_loc2_.time < Date.parse(_loc3_.beginTime))
               {
                  if(requestArr.indexOf(_loc3_.beginTime) < 0)
                  {
                     requestArr.push(_loc3_.beginTime);
                  }
               }
               if(_loc2_.time < Date.parse(_loc3_.endShowTime))
               {
                  if(requestArr.indexOf(_loc3_.endShowTime) < 0)
                  {
                     requestArr.push(_loc3_.endShowTime);
                  }
               }
               if(_loc2_.time >= Date.parse(_loc3_.beginTime) && _loc2_.time <= Date.parse(_loc3_.endTime))
               {
                  switch(int(_loc3_.activityChildType) - 1)
                  {
                     case 0:
                        showIconFlag = showIconFlag | 2;
                        levelId = _loc3_.activityId;
                        continue;
                     case 1:
                        showIconFlag = showIconFlag | 4;
                        vipId = _loc3_.activityId;
                        continue;
                     case 2:
                        showIconFlag = showIconFlag | 8;
                        indivId = _loc3_.activityId;
                        continue;
                     case 3:
                        showIconFlag = showIconFlag | 1;
                        entireId = _loc3_.activityId;
                        continue;
                     case 4:
                        showIconFlag = showIconFlag | 16;
                        newEntireId = _loc3_.activityId;
                        continue;
                  }
               }
               else
               {
                  continue;
               }
            }
            else
            {
               continue;
            }
         }
         if(requestArr.length > 0)
         {
            WonderfulActivityManager.Instance.addTimerFun("panicBuyingRequest",reCheck);
         }
         else
         {
            WonderfulActivityManager.Instance.delTimerFun("panicBuyingRequest");
         }
         if(showIconFlag > 0)
         {
            showEnterIcon();
         }
         else
         {
            hideEnterIcon();
         }
      }
      
      public function reCheck() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Number = NaN;
         var _loc2_:Date = TimeManager.Instance.Now();
         _loc4_ = 0;
         while(_loc4_ <= requestArr.length - 1)
         {
            _loc3_ = DateUtils.getDateByStr(requestArr[_loc4_]);
            _loc1_ = Math.round((_loc3_.getTime() - _loc2_.getTime()) / 1000);
            if(_loc1_ <= 0)
            {
               requestArr.splice(_loc4_,1);
               checkOpen();
               SocketManager.Instance.out.requestWonderfulActInit(2);
            }
            _loc4_++;
         }
      }
      
      private function showEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("panicBuying",true);
      }
      
      private function hideEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("panicBuying",false);
      }
      
      public function updateView() : void
      {
         dispatchEvent(new PanicBuyingEvent("updateView"));
      }
      
      override protected function start() : void
      {
         dispatchEvent(new PanicBuyingEvent("panicBuyingOpenView"));
      }
   }
}
