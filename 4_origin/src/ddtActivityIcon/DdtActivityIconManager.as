package ddtActivityIcon
{
   import dayActivity.DayActiveData;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.TimeManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import lanternriddles.event.LanternEvent;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class DdtActivityIconManager extends EventDispatcher
   {
      
      private static var _instance:DdtActivityIconManager;
      
      private static const MINI:int = 10000;
      
      private static const HOURS:int = 3600000;
      
      public static const READY_START:String = "ready_start";
      
      public static const START:String = "start";
      
      private static const NO_START:String = "no_start";
       
      
      private var _timerList:Vector.<DayActiveData>;
      
      private var _timer:Timer;
      
      private var todayActList:Array;
      
      private var _isOneOpen:Boolean;
      
      private var _isAlreadyOpen:Boolean;
      
      public var currObj:Array;
      
      public function DdtActivityIconManager(param1:IEventDispatcher = null)
      {
         super(param1);
         _timer = new Timer(10000);
         _timer.addEventListener("timer",timerHander);
      }
      
      public static function get Instance() : DdtActivityIconManager
      {
         if(_instance == null)
         {
            _instance = new DdtActivityIconManager();
         }
         return _instance;
      }
      
      private function timerHander(param1:TimerEvent) : void
      {
         checkTodayActList();
         checkSpecialActivity();
      }
      
      private function checkSpecialActivity() : void
      {
         var _loc6_:* = null;
         if(_isAlreadyOpen)
         {
            return;
         }
         var _loc4_:Date = TimeManager.Instance.Now();
         var _loc7_:String = _loc4_.getFullYear().toString() + "/" + (_loc4_.month + 1).toString() + "/" + _loc4_.date.toString() + " ";
         var _loc3_:DictionaryData = ServerConfigManager.instance.serverConfigInfo;
         var _loc2_:Date = DateUtils.getDateByStr(_loc3_["LightRiddleBeginDate"].Value);
         var _loc1_:Date = DateUtils.getDateByStr(transformTime(_loc7_,_loc3_["LightRiddleBeginTime"].Value));
         var _loc5_:Date = DateUtils.getDateByStr(_loc3_["LightRiddleEndDate"].Value);
         if(PlayerManager.Instance.Self.Grade >= 15)
         {
            if(_loc4_.time > _loc2_.time && _loc4_.time < _loc5_.time)
            {
               if(_loc1_.time > _loc4_.time && _loc1_.time - _loc4_.time <= 3600000)
               {
                  _isAlreadyOpen = true;
                  _loc6_ = addO(_loc1_.hours) + ":" + addO(_loc1_.minutes) + LanguageMgr.GetTranslation("ddt.activityIcon.timePreStartTxt");
                  dispatchEvent(new LanternEvent("lanternSettime",_loc6_));
               }
            }
         }
      }
      
      private function transformTime(param1:String, param2:String) : String
      {
         var _loc3_:Array = param2.split(" ");
         return param1 + _loc3_[1];
      }
      
      public function set timerList(param1:Vector.<DayActiveData>) : void
      {
         _timerList = param1;
      }
      
      public function setup() : void
      {
         _timer.reset();
         initToDayActivie();
         _timer.start();
      }
      
      public function startTime() : void
      {
         _timer.start();
      }
      
      public function stopTime() : void
      {
         _timer.stop();
      }
      
      private function initToDayActivie() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_timerList)
         {
            todayActList = [];
            _loc1_ = _timerList.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(checkToday(_timerList[_loc2_].DayOfWeek))
               {
                  if(!(int(_timerList[_loc2_].JumpType) == 1 && int(_timerList[_loc2_].LevelLimit) > PlayerManager.Instance.Self.Grade))
                  {
                     if(!(int(_timerList[_loc2_].JumpType) == 10 && int(_timerList[_loc2_].LevelLimit) > PlayerManager.Instance.Self.Grade))
                     {
                        todayActList.push(strToDataArray(_timerList[_loc2_].ActiveTime,int(_timerList[_loc2_].JumpType)));
                     }
                  }
               }
               _loc2_++;
            }
         }
         return todayActList;
      }
      
      public function get isOneOpen() : Boolean
      {
         return _isOneOpen;
      }
      
      public function set isOneOpen(param1:Boolean) : void
      {
         _isOneOpen = param1;
      }
      
      private function checkTodayActList() : void
      {
         var _loc10_:int = 0;
         var _loc2_:* = null;
         var _loc9_:* = null;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(!todayActList)
         {
            return;
         }
         var _loc7_:int = todayActList.length;
         var _loc1_:Date = TimeManager.Instance.Now();
         _loc10_ = 0;
         while(_loc10_ < _loc7_)
         {
            _loc2_ = todayActList[_loc10_][0];
            _loc9_ = _loc2_.end;
            checkActOpen(_loc2_);
            if(todayActList[_loc10_][1] && _loc1_.time > _loc9_.time)
            {
               _loc3_ = todayActList[_loc10_][1];
               checkActOpen(_loc3_);
            }
            _loc10_++;
         }
         if(_isOneOpen)
         {
            return;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_ = todayActList[_loc8_][0];
            _loc5_ = _loc6_.end;
            checkActReady(_loc6_);
            if(todayActList[_loc8_][1] && _loc1_.time > _loc5_.time)
            {
               _loc4_ = todayActList[_loc8_][1];
               checkActReady(_loc4_);
            }
            _loc8_++;
         }
      }
      
      private function checkToday(param1:String) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc2_:Array = param1.split(",");
         var _loc4_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_.day == int(_loc2_[_loc5_]))
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      private function checkActOpen(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc4_:Date = TimeManager.Instance.Now();
         var _loc3_:Date = param1.start;
         var _loc7_:Date = param1.end;
         var _loc6_:int = _loc3_.time - _loc4_.time;
         if(_loc4_.time >= _loc3_.time && _loc4_.time < _loc7_.time)
         {
            if(param1.name == 4)
            {
               _loc2_ = 4;
            }
            else if(param1.name == 11)
            {
               _loc2_ = 11;
            }
            else
            {
               _loc2_ = -100;
            }
            _isOneOpen = true;
            currObj = [];
            currObj.push(param1.name);
            currObj.push(_loc2_);
            _loc5_ = LanguageMgr.GetTranslation("ddt.activityIcon.timeStartTxt") + " " + addO(_loc3_.hours) + ":" + addO(_loc3_.minutes);
            currObj.push(_loc5_);
            dispatchEvent(new ActivitStateEvent("start",[param1.name,_loc2_,_loc5_]));
         }
      }
      
      private function checkActReady(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc4_:Date = TimeManager.Instance.Now();
         var _loc3_:Date = param1.start;
         var _loc7_:Date = param1.end;
         var _loc6_:int = _loc3_.time - _loc4_.time;
         if(_loc3_.time > _loc4_.time && _loc6_ < 3600000)
         {
            if(param1.name == 4)
            {
               _loc2_ = 4;
            }
            else if(param1.name == 11)
            {
               _loc2_ = 11;
            }
            else if(param1.name == 10)
            {
               _loc2_ = 10;
            }
            else
            {
               _loc2_ = -100;
            }
            _isOneOpen = false;
            _loc5_ = addO(_loc3_.hours) + ":" + addO(_loc3_.minutes) + " " + LanguageMgr.GetTranslation("ddt.activityIcon.timePreStartTxt");
            dispatchEvent(new ActivitStateEvent("ready_start",[param1.name,_loc2_,_loc5_]));
         }
      }
      
      private function addO(param1:Number) : String
      {
         var _loc2_:String = param1.toString();
         if(_loc2_.length == 1)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      private function strToDataArray(param1:String, param2:int) : Array
      {
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc10_:* = null;
         var _loc8_:Array = [];
         var _loc5_:Array = param1.split("|");
         var _loc4_:String = _loc5_[0].substr(0,5);
         var _loc7_:String = _loc5_[0].substr(6,5);
         var _loc14_:Date = strToDate(_loc4_);
         var _loc13_:Date = strToDate(_loc7_);
         var _loc9_:Object = {};
         _loc9_.start = _loc14_;
         _loc9_.end = _loc13_;
         _loc9_.name = param2;
         _loc8_.push(_loc9_);
         if(_loc5_[1])
         {
            _loc3_ = _loc5_[1].substr(0,5);
            _loc6_ = _loc5_[1].substr(6,5);
            _loc11_ = strToDate(_loc3_);
            _loc12_ = strToDate(_loc6_);
            _loc10_ = {};
            _loc10_.start = _loc11_;
            _loc10_.end = _loc12_;
            _loc10_.name = param2;
            _loc8_.push(_loc10_);
         }
         return _loc8_;
      }
      
      private function strToDate(param1:String) : Date
      {
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc6_:Number = _loc3_.fullYear;
         var _loc5_:int = _loc3_.month;
         var _loc7_:Number = _loc3_.date;
         var _loc4_:String = param1.substr(0,2);
         var _loc2_:String = param1.substr(3,2);
         var _loc8_:Date = new Date(_loc6_,_loc5_,_loc7_,_loc4_,_loc2_);
         return _loc8_;
      }
      
      public function set isAlreadyOpen(param1:Boolean) : void
      {
         _isAlreadyOpen = param1;
      }
   }
}
