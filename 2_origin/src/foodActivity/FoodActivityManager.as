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
      
      protected function pkgHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readByte();
         var _loc4_:* = _loc2_;
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
                           cleanDataHandler(_loc3_);
                        }
                     }
                     else
                     {
                        dispatchEvent(new FoodActivityEvent(FoodActivityEvent.FOOD_REWARD,_loc3_));
                     }
                  }
                  else
                  {
                     cookingHanlder(_loc3_);
                  }
               }
               else
               {
                  cookingHanlder(_loc3_);
               }
            }
            else
            {
               updateCookingCount(_loc3_);
            }
         }
         else
         {
            openOrCloseHandler(_loc3_);
         }
      }
      
      private function cleanDataHandler(param1:PackageIn) : void
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
      
      private function cookingHanlder(param1:PackageIn) : void
      {
         cookingCount = param1.readInt();
         ripeNum = param1.readInt();
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
      
      private function updateCookingCount(param1:PackageIn) : void
      {
         cookingCount = param1.readInt();
         currentSumTime = param1.readInt();
         delayTime = param1.readInt();
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
      
      private function openOrCloseHandler(param1:PackageIn) : void
      {
         _actId = param1.readUTF();
         _isStart = param1.readBoolean();
         cookingCount = param1.readInt();
         ripeNum = param1.readInt();
         state = param1.readInt();
         currentSumTime = param1.readInt();
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
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc1_:Dictionary = WonderfulActivityManager.Instance.activityData;
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc3_ in _loc1_)
         {
            if(_loc3_.activityType == 13 && (_loc3_.activityChildType == 0 || _loc3_.activityChildType == 1) && _loc2_.time >= Date.parse(_loc3_.beginTime) && _loc2_.time <= Date.parse(_loc3_.endShowTime))
            {
               _info = !!_loc1_[_actId]?_loc1_[_actId]:null;
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
      
      public function startTime(param1:Boolean = false) : void
      {
         if(_foodActivityEnterIcon)
         {
            _foodActivityEnterIcon.startTime(param1);
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
      
      protected function __timerHandler(param1:TimerEvent) : void
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
      
      public function set info(param1:GmActivityInfo) : void
      {
         _info = param1;
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
