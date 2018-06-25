package foodActivity
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.view.FoodActivityEnterIcon;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import foodActivity.event.FoodActivityEvent;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class FoodActivityManager extends CoreManager
   {
      
      private static var _instance:FoodActivityManager;
       
      
      private var _info:GmActivityInfo;
      
      public var _isStart:Boolean;
      
      public var ripeNum:int;
      
      public var cookingCount:int;
      
      public var state:int;
      
      public var currentSumTime:int;
      
      public var delayTime:int;
      
      private var _timer:Timer;
      
      public var sumTime:int;
      
      private var _actId:String;
      
      private var _foodActivityEnterIcon:FoodActivityEnterIcon;
      
      private var _hallView:HallStateView;
      
      public function FoodActivityManager()
      {
         super();
      }
      
      public static function get Instance() : FoodActivityManager
      {
         if(_instance == null)
         {
            _instance = new FoodActivityManager();
         }
         return _instance;
      }
      
      public function setUp() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(274),pkgHandler);
      }
      
      protected function pkgHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         var _loc4_:* = cmd;
         if(FoodActivityEvent.ACTIVITY_STATE !== _loc4_)
         {
            if(FoodActivityEvent.UPDATE_COUNT !== _loc4_)
            {
               if(FoodActivityEvent.SIMPLE_COOKING !== _loc4_)
               {
                  if(FoodActivityEvent.PAY_COOKING !== _loc4_)
                  {
                     if(FoodActivityEvent.REWARD !== _loc4_)
                     {
                        if(FoodActivityEvent.CLEAN_DATA === _loc4_)
                        {
                           cleanDataHandler(pkg);
                        }
                     }
                     else
                     {
                        dispatchEvent(new FoodActivityEvent(FoodActivityEvent.FOOD_REWARD,pkg));
                     }
                  }
                  else
                  {
                     cookingHanlder(pkg);
                  }
               }
               else
               {
                  cookingHanlder(pkg);
               }
            }
            else
            {
               updateCookingCount(pkg);
            }
         }
         else
         {
            openOrCloseHandler(pkg);
         }
      }
      
      private function cleanDataHandler(pkg:PackageIn) : void
      {
         ripeNum = 0;
         cookingCount = 0;
         currentSumTime = 0;
         sumTime = 0;
         updateView();
         if(!_info)
         {
            return;
         }
         if(info.activityChildType == 0)
         {
            startTime();
         }
      }
      
      private function cookingHanlder(pkg:PackageIn) : void
      {
         cookingCount = pkg.readInt();
         ripeNum = pkg.readInt();
         updateView();
      }
      
      private function updateView() : void
      {
         if(_foodActivityEnterIcon)
         {
            _foodActivityEnterIcon.text = "" + cookingCount;
         }
         dispatchEvent(new FoodActivityEvent(FoodActivityEvent.FOOD_UPDATEVIEW));
      }
      
      private function updateCookingCount(pkg:PackageIn) : void
      {
         cookingCount = pkg.readInt();
         currentSumTime = pkg.readInt();
         delayTime = pkg.readInt();
         if(!_info)
         {
            return;
         }
         if(info.activityChildType == 0)
         {
            if(cookingCount == 0)
            {
               startTime(true);
            }
            else
            {
               endTime();
            }
         }
         updateView();
      }
      
      private function openOrCloseHandler(pkg:PackageIn) : void
      {
         _actId = pkg.readUTF();
         _isStart = pkg.readBoolean();
         cookingCount = pkg.readInt();
         ripeNum = pkg.readInt();
         state = pkg.readInt();
         currentSumTime = pkg.readInt();
         if(_isStart)
         {
            initData();
            if(_info)
            {
               initBtn();
               HallIconManager.instance.updateSwitchHandler("FoodActivity",_isStart);
            }
         }
         else
         {
            info = null;
            sumTime = 0;
            if(_timer)
            {
               _timer.stop();
               _timer.removeEventListener("timer",__timerHandler);
               _timer = null;
            }
            deleteBtn();
            dispatchEvent(new FoodActivityEvent(FoodActivityEvent.FOOD_CLOSEVIEW));
         }
      }
      
      public function checkOpen() : void
      {
         initData();
         if(_info)
         {
            initBtn();
         }
      }
      
      private function initData() : void
      {
         var now:Date = TimeManager.Instance.Now();
         var activityData:Dictionary = WonderfulActivityManager.Instance.activityData;
         var _loc5_:int = 0;
         var _loc4_:* = activityData;
         for each(var item in activityData)
         {
            if(item.activityType == 13 && (item.activityChildType == 0 || item.activityChildType == 1) && now.time >= Date.parse(item.beginTime) && now.time <= Date.parse(item.endShowTime))
            {
               _info = !!activityData[_actId]?activityData[_actId]:null;
               break;
            }
         }
      }
      
      public function initBtn() : void
      {
         if(!_foodActivityEnterIcon)
         {
            _foodActivityEnterIcon = new FoodActivityEnterIcon();
         }
         if(info && info.activityChildType == 0)
         {
            _foodActivityEnterIcon.showTxt();
         }
      }
      
      public function startTime(isUpdateCount:Boolean = false) : void
      {
         if(_foodActivityEnterIcon)
         {
            _foodActivityEnterIcon.startTime(isUpdateCount);
         }
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
         _timer = new Timer(1000,sumTime);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      public function endTime() : void
      {
         if(_timer)
         {
            _timer.stop();
         }
         if(_foodActivityEnterIcon)
         {
            _foodActivityEnterIcon.endTime();
         }
      }
      
      public function stopTime() : void
      {
         if(_timer)
         {
            _timer.stop();
         }
      }
      
      protected function __timerHandler(event:TimerEvent) : void
      {
         sumTime = Number(sumTime) - 1;
         if(_foodActivityEnterIcon)
         {
            _foodActivityEnterIcon.updateTime();
         }
         if(FoodActivityManager.Instance.sumTime == 0)
         {
            stopTime();
            SocketManager.Instance.out.updateCookingCountByTime();
         }
      }
      
      public function deleteBtn() : void
      {
         if(_foodActivityEnterIcon)
         {
            HallIconManager.instance.updateSwitchHandler("FoodActivity",_isStart);
            ObjectUtils.disposeObject(_foodActivityEnterIcon);
            _foodActivityEnterIcon = null;
         }
      }
      
      override protected function start() : void
      {
         dispatchEvent(new FoodActivityEvent(FoodActivityEvent.FOOD_OPENVIEW));
      }
      
      public function get info() : GmActivityInfo
      {
         return _info;
      }
      
      public function set info(value:GmActivityInfo) : void
      {
         _info = value;
      }
      
      public function get isStart() : Boolean
      {
         return _isStart;
      }
      
      public function get foodActivityIcon() : FoodActivityEnterIcon
      {
         return _foodActivityEnterIcon;
      }
   }
}
