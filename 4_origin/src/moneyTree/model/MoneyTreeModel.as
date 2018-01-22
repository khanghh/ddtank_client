package moneyTree.model
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.Helpers;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import moneyTree.MoneyTreeManager;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class MoneyTreeModel extends EventDispatcher
   {
      
      public static const COST_PER_SPEEDUP:int = 200;
      
      public static const TIMER:String = "mt_timer";
       
      
      private var _numRedPkgRemain:int;
      
      private var _numPersonsWillSendRedPkg:Dictionary;
      
      private var _infoList:Vector.<MT_FruitData>;
      
      private var _timer:TimerJuggler;
      
      private var _curTime:Date;
      
      public function MoneyTreeModel()
      {
         var _loc1_:int = 0;
         _numPersonsWillSendRedPkg = new Dictionary();
         super();
         _infoList = new Vector.<MT_FruitData>();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _infoList[_loc1_] = new MT_FruitData();
            _loc1_++;
         }
         _timer = TimerManager.getInstance().addTimerJuggler(1000,0,false);
         _timer.addEventListener("timer",onTimer);
         _timer.start();
         onTimer(null);
      }
      
      protected function onTimer(param1:Event) : void
      {
         _curTime = TimeManager.Instance.Now();
         hasMatureFruit();
         dispatchEvent(new Event("mt_timer"));
      }
      
      private function hasMatureFruit() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _infoList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_infoList[_loc2_].timeGrown && _infoList[_loc2_].timeGrown.time - _curTime.time <= 0)
            {
               MoneyTreeManager.getInstance().becomeMature();
               break;
            }
            _loc2_++;
         }
      }
      
      public function getCountDownString(param1:int) : String
      {
         if(_infoList[param1].timeGrown == null)
         {
            return "00:00:00";
         }
         var _loc2_:Number = _infoList[param1].timeGrown.time - _curTime.time;
         if(_loc2_ <= 0)
         {
            return LanguageMgr.GetTranslation("moneyTree.MoneyTreeModel.TreeOK");
         }
         return Helpers.getTimeString(_loc2_);
      }
      
      public function getCurSlctTimesSpeedUpToMature(param1:int) : int
      {
         if(_infoList[param1].timeGrown == null)
         {
            return 0;
         }
         var _loc2_:Number = _infoList[param1].timeGrown.time - _curTime.time;
         if(_loc2_ <= 0)
         {
            return 0;
         }
         return Math.ceil(_loc2_ / 3600000);
      }
      
      public function isNoMoreRedPkg() : Boolean
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _numPersonsWillSendRedPkg;
         for each(var _loc1_ in _numPersonsWillSendRedPkg)
         {
            _loc2_++;
         }
         return _loc2_ >= _numRedPkgRemain;
      }
      
      public function addFriendsToSend(param1:int) : void
      {
         _numPersonsWillSendRedPkg[param1] = param1;
      }
      
      public function reduceFriendsToSend(param1:int) : void
      {
      }
      
      public function resetWillSendNum() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _numPersonsWillSendRedPkg;
         for(var _loc1_ in _numPersonsWillSendRedPkg)
         {
            delete _numPersonsWillSendRedPkg[_loc1_];
         }
      }
      
      public function getFriendsToSendList() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _numPersonsWillSendRedPkg;
         for(var _loc2_ in _numPersonsWillSendRedPkg)
         {
            _loc1_.push(_numPersonsWillSendRedPkg[_loc2_]);
         }
         return _loc1_;
      }
      
      public function getTimesToGrown(param1:int) : int
      {
         var _loc3_:* = NaN;
         var _loc2_:Number = _infoList[param1].timeGrown.time - new Date().time;
         if(_loc2_ < 0)
         {
            return 0;
         }
         _loc3_ = 3600000;
         return Math.ceil(_loc2_ / _loc3_);
      }
      
      public function getPriceSpeedUp(param1:int) : int
      {
         return _infoList[param1].priceSpeedUp;
      }
      
      public function setNumRedPkgRemain(param1:int) : void
      {
         _numRedPkgRemain = param1;
      }
      
      public function getNumRedPkgRemain() : int
      {
         return _numRedPkgRemain;
      }
      
      public function setInfoAt(param1:int, param2:Date, param3:int) : void
      {
         _infoList[param1].timeGrown = param2;
         _infoList[param1].priceSpeedUp = param3;
      }
      
      public function getInfoAt(param1:int) : MT_FruitData
      {
         if(_infoList)
         {
            return _infoList[param1];
         }
         return null;
      }
      
      public function hasFruitMature() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _infoList;
         for each(var _loc1_ in _infoList)
         {
            if(_loc1_.isGrown)
            {
               return true;
            }
         }
         return false;
      }
      
      public function dispose() : void
      {
         _timer.stop();
         TimerManager.getInstance().removeJugglerByTimer(_timer);
         _timer.removeEventListener("timer",onTimer);
         _timer = null;
      }
   }
}
