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
      
      public function DdtActivityIconManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      private function timerHander(e:TimerEvent) : void
      {
         checkTodayActList();
         checkSpecialActivity();
      }
      
      private function checkSpecialActivity() : void
      {
         var tStr:* = null;
         if(_isAlreadyOpen)
         {
            return;
         }
         var now:Date = TimeManager.Instance.Now();
         var nowTime:String = now.getFullYear().toString() + "/" + (now.month + 1).toString() + "/" + now.date.toString() + " ";
         var serverData:DictionaryData = ServerConfigManager.instance.serverConfigInfo;
         var startDate:Date = DateUtils.getDateByStr(serverData["LightRiddleBeginDate"].Value);
         var startTime:Date = DateUtils.getDateByStr(transformTime(nowTime,serverData["LightRiddleBeginTime"].Value));
         var endDate:Date = DateUtils.getDateByStr(serverData["LightRiddleEndDate"].Value);
         if(PlayerManager.Instance.Self.Grade >= 15)
         {
            if(now.time > startDate.time && now.time < endDate.time)
            {
               if(startTime.time > now.time && startTime.time - now.time <= 3600000)
               {
                  _isAlreadyOpen = true;
                  tStr = addO(startTime.hours) + ":" + addO(startTime.minutes) + LanguageMgr.GetTranslation("ddt.activityIcon.timePreStartTxt");
                  dispatchEvent(new LanternEvent("lanternSettime",tStr));
               }
            }
         }
      }
      
      private function transformTime(nowTime:String, startTime:String) : String
      {
         var temp:Array = startTime.split(" ");
         return nowTime + temp[1];
      }
      
      public function set timerList(list:Vector.<DayActiveData>) : void
      {
         _timerList = list;
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
         var len:int = 0;
         var i:int = 0;
         if(_timerList)
         {
            todayActList = [];
            len = _timerList.length;
            for(i = 0; i < len; )
            {
               if(checkToday(_timerList[i].DayOfWeek))
               {
                  if(!(int(_timerList[i].JumpType) == 1 && int(_timerList[i].LevelLimit) > PlayerManager.Instance.Self.Grade))
                  {
                     if(!(int(_timerList[i].JumpType) == 10 && int(_timerList[i].LevelLimit) > PlayerManager.Instance.Self.Grade))
                     {
                        todayActList.push(strToDataArray(_timerList[i].ActiveTime,int(_timerList[i].JumpType)));
                     }
                  }
               }
               i++;
            }
         }
         return todayActList;
      }
      
      public function get isOneOpen() : Boolean
      {
         return _isOneOpen;
      }
      
      public function set isOneOpen(bool:Boolean) : void
      {
         _isOneOpen = bool;
      }
      
      private function checkTodayActList() : void
      {
         var i:int = 0;
         var obj1:* = null;
         var end:* = null;
         var obj2:* = null;
         var j:int = 0;
         var objReady1:* = null;
         var endReady1:* = null;
         var objReady2:* = null;
         if(!todayActList)
         {
            return;
         }
         var len:int = todayActList.length;
         var now:Date = TimeManager.Instance.Now();
         for(i = 0; i < len; )
         {
            obj1 = todayActList[i][0];
            end = obj1.end;
            checkActOpen(obj1);
            if(todayActList[i][1] && now.time > end.time)
            {
               obj2 = todayActList[i][1];
               checkActOpen(obj2);
            }
            i++;
         }
         if(_isOneOpen)
         {
            return;
         }
         for(j = 0; j < len; )
         {
            objReady1 = todayActList[j][0];
            endReady1 = objReady1.end;
            checkActReady(objReady1);
            if(todayActList[j][1] && now.time > endReady1.time)
            {
               objReady2 = todayActList[j][1];
               checkActReady(objReady2);
            }
            j++;
         }
      }
      
      private function checkToday(str:String) : Boolean
      {
         var i:int = 0;
         var now:Date = TimeManager.Instance.Now();
         var arr:Array = str.split(",");
         var len:int = arr.length;
         for(i = 0; i < len; )
         {
            if(now.day == int(arr[i]))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function checkActOpen(obj:Object) : void
      {
         var JumpType:int = 0;
         var tStr:* = null;
         var now:Date = TimeManager.Instance.Now();
         var start:Date = obj.start;
         var end:Date = obj.end;
         var disT:int = start.time - now.time;
         if(now.time >= start.time && now.time < end.time)
         {
            if(obj.name == 4)
            {
               JumpType = 4;
            }
            else if(obj.name == 11)
            {
               JumpType = 11;
            }
            else
            {
               JumpType = -100;
            }
            _isOneOpen = true;
            currObj = [];
            currObj.push(obj.name);
            currObj.push(JumpType);
            tStr = LanguageMgr.GetTranslation("ddt.activityIcon.timeStartTxt") + " " + addO(start.hours) + ":" + addO(start.minutes);
            currObj.push(tStr);
            dispatchEvent(new ActivitStateEvent("start",[obj.name,JumpType,tStr]));
         }
      }
      
      private function checkActReady(obj:Object) : void
      {
         var JumpType:int = 0;
         var tStr:* = null;
         var now:Date = TimeManager.Instance.Now();
         var start:Date = obj.start;
         var end:Date = obj.end;
         var disT:int = start.time - now.time;
         if(start.time > now.time && disT < 3600000)
         {
            if(obj.name == 4)
            {
               JumpType = 4;
            }
            else if(obj.name == 11)
            {
               JumpType = 11;
            }
            else if(obj.name == 10)
            {
               JumpType = 10;
            }
            else
            {
               JumpType = -100;
            }
            _isOneOpen = false;
            tStr = addO(start.hours) + ":" + addO(start.minutes) + " " + LanguageMgr.GetTranslation("ddt.activityIcon.timePreStartTxt");
            dispatchEvent(new ActivitStateEvent("ready_start",[obj.name,JumpType,tStr]));
         }
      }
      
      private function addO(num:Number) : String
      {
         var str:String = num.toString();
         if(str.length == 1)
         {
            str = "0" + str;
         }
         return str;
      }
      
      private function strToDataArray(str:String, JumpType:int) : Array
      {
         var startStr2:* = null;
         var endStr2:* = null;
         var startDate2:* = null;
         var endDate2:* = null;
         var obj2:* = null;
         var dataArr:Array = [];
         var arr:Array = str.split("|");
         var startStr1:String = arr[0].substr(0,5);
         var endStr1:String = arr[0].substr(6,5);
         var startDate1:Date = strToDate(startStr1);
         var endDate1:Date = strToDate(endStr1);
         var obj1:Object = {};
         obj1.start = startDate1;
         obj1.end = endDate1;
         obj1.name = JumpType;
         dataArr.push(obj1);
         if(arr[1])
         {
            startStr2 = arr[1].substr(0,5);
            endStr2 = arr[1].substr(6,5);
            startDate2 = strToDate(startStr2);
            endDate2 = strToDate(endStr2);
            obj2 = {};
            obj2.start = startDate2;
            obj2.end = endDate2;
            obj2.name = JumpType;
            dataArr.push(obj2);
         }
         return dataArr;
      }
      
      private function strToDate(str:String) : Date
      {
         var now:Date = TimeManager.Instance.Now();
         var year:Number = now.fullYear;
         var month:int = now.month;
         var day:Number = now.date;
         var hours:String = str.substr(0,2);
         var minutes:String = str.substr(3,2);
         var date:Date = new Date(year,month,day,hours,minutes);
         return date;
      }
      
      public function set isAlreadyOpen(value:Boolean) : void
      {
         _isAlreadyOpen = value;
      }
   }
}
