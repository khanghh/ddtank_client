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
      
      public function set vipId(value:String) : void
      {
         _vipId = value;
      }
      
      public function setup() : void
      {
      }
      
      protected function __discountChange(event:ShopEvent) : void
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
         var now:Date = TimeManager.Instance.Now();
         var activityData:Dictionary = WonderfulActivityManager.Instance.activityData;
         showIconFlag = 0;
         levelId = "";
         vipId = "";
         indivId = "";
         entireId = "";
         newEntireId = "";
         var _loc5_:int = 0;
         var _loc4_:* = activityData;
         for each(var item in activityData)
         {
            if(item.activityType == 19 && (item.activityChildType == 1 || item.activityChildType == 2 || item.activityChildType == 3 || item.activityChildType == 4 || item.activityChildType == 5))
            {
               if(now.time < Date.parse(item.beginTime))
               {
                  if(requestArr.indexOf(item.beginTime) < 0)
                  {
                     requestArr.push(item.beginTime);
                  }
               }
               if(now.time < Date.parse(item.endShowTime))
               {
                  if(requestArr.indexOf(item.endShowTime) < 0)
                  {
                     requestArr.push(item.endShowTime);
                  }
               }
               if(now.time >= Date.parse(item.beginTime) && now.time <= Date.parse(item.endTime))
               {
                  switch(int(item.activityChildType) - 1)
                  {
                     case 0:
                        showIconFlag = showIconFlag | 2;
                        levelId = item.activityId;
                        continue;
                     case 1:
                        showIconFlag = showIconFlag | 4;
                        vipId = item.activityId;
                        continue;
                     case 2:
                        showIconFlag = showIconFlag | 8;
                        indivId = item.activityId;
                        continue;
                     case 3:
                        showIconFlag = showIconFlag | 1;
                        entireId = item.activityId;
                        continue;
                     case 4:
                        showIconFlag = showIconFlag | 16;
                        newEntireId = item.activityId;
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
         var i:int = 0;
         var endDate:* = null;
         var diff:Number = NaN;
         var nowDate:Date = TimeManager.Instance.Now();
         for(i = 0; i <= requestArr.length - 1; )
         {
            endDate = DateUtils.getDateByStr(requestArr[i]);
            diff = Math.round((endDate.getTime() - nowDate.getTime()) / 1000);
            if(diff <= 0)
            {
               requestArr.splice(i,1);
               checkOpen();
               SocketManager.Instance.out.requestWonderfulActInit(2);
            }
            i++;
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
