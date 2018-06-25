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
         var i:int = 0;
         _numPersonsWillSendRedPkg = new Dictionary();
         super();
         _infoList = new Vector.<MT_FruitData>();
         for(i = 0; i < 4; )
         {
            _infoList[i] = new MT_FruitData();
            i++;
         }
         _timer = TimerManager.getInstance().addTimerJuggler(1000,0,false);
         _timer.addEventListener("timer",onTimer);
         _timer.start();
         onTimer(null);
      }
      
      protected function onTimer(e:Event) : void
      {
         _curTime = TimeManager.Instance.Now();
         hasMatureFruit();
         dispatchEvent(new Event("mt_timer"));
      }
      
      private function hasMatureFruit() : void
      {
         var i:int = 0;
         var len:int = _infoList.length;
         for(i = 0; i < len; )
         {
            if(_infoList[i].timeGrown && _infoList[i].timeGrown.time - _curTime.time <= 0)
            {
               MoneyTreeManager.getInstance().becomeMature();
               break;
            }
            i++;
         }
      }
      
      public function getCountDownString(index:int) : String
      {
         if(_infoList[index].timeGrown == null)
         {
            return "00:00:00";
         }
         var remain:Number = _infoList[index].timeGrown.time - _curTime.time;
         if(remain <= 0)
         {
            return LanguageMgr.GetTranslation("moneyTree.MoneyTreeModel.TreeOK");
         }
         return Helpers.getTimeString(remain);
      }
      
      public function getCurSlctTimesSpeedUpToMature(index:int) : int
      {
         if(_infoList[index].timeGrown == null)
         {
            return 0;
         }
         var remain:Number = _infoList[index].timeGrown.time - _curTime.time;
         if(remain <= 0)
         {
            return 0;
         }
         return Math.ceil(remain / 3600000);
      }
      
      public function isNoMoreRedPkg() : Boolean
      {
         var num:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _numPersonsWillSendRedPkg;
         for each(var v in _numPersonsWillSendRedPkg)
         {
            num++;
         }
         return num >= _numRedPkgRemain;
      }
      
      public function addFriendsToSend(id:int) : void
      {
         _numPersonsWillSendRedPkg[id] = id;
      }
      
      public function reduceFriendsToSend(id:int) : void
      {
      }
      
      public function resetWillSendNum() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _numPersonsWillSendRedPkg;
         for(var k in _numPersonsWillSendRedPkg)
         {
            delete _numPersonsWillSendRedPkg[k];
         }
      }
      
      public function getFriendsToSendList() : Array
      {
         var arr:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _numPersonsWillSendRedPkg;
         for(var k in _numPersonsWillSendRedPkg)
         {
            arr.push(_numPersonsWillSendRedPkg[k]);
         }
         return arr;
      }
      
      public function getTimesToGrown(position:int) : int
      {
         var hour:* = NaN;
         var time:Number = _infoList[position].timeGrown.time - new Date().time;
         if(time < 0)
         {
            return 0;
         }
         hour = 3600000;
         return Math.ceil(time / hour);
      }
      
      public function getPriceSpeedUp(position:int) : int
      {
         return _infoList[position].priceSpeedUp;
      }
      
      public function setNumRedPkgRemain(value:int) : void
      {
         _numRedPkgRemain = value;
      }
      
      public function getNumRedPkgRemain() : int
      {
         return _numRedPkgRemain;
      }
      
      public function setInfoAt(index:int, timeGrown:Date, priceSpeedUp:int) : void
      {
         _infoList[index].timeGrown = timeGrown;
         _infoList[index].priceSpeedUp = priceSpeedUp;
      }
      
      public function getInfoAt(index:int) : MT_FruitData
      {
         if(_infoList)
         {
            return _infoList[index];
         }
         return null;
      }
      
      public function hasFruitMature() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _infoList;
         for each(var f in _infoList)
         {
            if(f.isGrown)
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
