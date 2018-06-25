package calendar
{
   import activeEvents.data.ActiveEventsInfo;
   import calendar.event.CalendarEvent;
   import calendar.view.ActivityState;
   import calendar.view.CalendarFrame;
   import calendar.view.CalendarState;
   import calendar.view.SignFrame;
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.AccountInfo;
   import ddt.data.DaylyGiveInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CrytoUtils;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import mainbutton.MainButtnController;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CalendarControl extends EventDispatcher
   {
      
      public static const PET_BTN_SHOW:String = "petBtnShow";
      
      private static var _ins:CalendarControl;
       
      
      private var _timer:TimerJuggler;
      
      private var _localMarkDate:Date;
      
      private var _frame:Frame;
      
      private var _reciveActive:ActiveEventsInfo;
      
      public function CalendarControl()
      {
         _localMarkDate = new Date();
         super();
         CalendarState;
         ActivityState;
      }
      
      public static function getInstance() : CalendarControl
      {
         if(_ins == null)
         {
            _ins = new CalendarControl();
         }
         return _ins;
      }
      
      public function setup() : void
      {
         CalendarManager.getInstance().addEventListener("calendarOpenView",__onOpenView);
         CalendarManager.getInstance().addEventListener("calendarqqOpenView",__onQqOpen);
      }
      
      private function __onOpenView(event:CalendarEvent) : void
      {
         if(CalendarManager.getInstance().isShow)
         {
            if(CalendarManager.getInstance().currentModel == 1)
            {
               _frame = ComponentFactory.Instance.creatCustomObject("ddtmainbutton.SignFrameStyle",[CalendarManager.getInstance().model]);
               LayerManager.Instance.addToLayer(_frame,3,false,2);
            }
            else
            {
               _frame = ComponentFactory.Instance.creatCustomObject("ddtcalendar.CalendarFrame",[CalendarManager.getInstance().model]);
               _frame.titleText = LanguageMgr.GetTranslation("tank.calendar.title");
               (_frame as CalendarFrame).setState();
               lookActivity(TimeManager.Instance.Now());
            }
            _frame.addEventListener("dispose",__frameDispose);
            MainToolBar.Instance.showSignShineEffect(false);
            MainToolBar.Instance.signEffectEnable = false;
            if(_frame is CalendarFrame)
            {
               lookActivity(TimeManager.Instance.Now());
            }
            if(_timer == null)
            {
               _timer = TimerManager.getInstance().addTimerJuggler(1000);
               _timer.addEventListener("timer",__mark);
               _timer.start();
            }
         }
         if(CalendarManager.getInstance().isQQopen)
         {
            CalendarManager.getInstance().isQQopen = false;
            _qqOpenComplete();
         }
      }
      
      private function __onQqOpen(event:CalendarEvent) : void
      {
         if(_frame != null)
         {
            CalendarManager.getInstance().isQQopen = false;
            (_frame as CalendarFrame).showByQQ(CalendarManager.getInstance().activeID);
         }
      }
      
      private function _qqOpenComplete() : void
      {
         if(_frame is CalendarFrame)
         {
            (_frame as CalendarFrame).showByQQ(CalendarManager.getInstance().activeID);
         }
      }
      
      public function close() : void
      {
         CalendarManager.getInstance().localVisible = false;
         ObjectUtils.disposeObject(CalendarManager.getInstance().model);
         CalendarManager.getInstance().model = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__mark);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
      }
      
      private function __frameDispose(event:ComponentEvent) : void
      {
         CalendarManager.getInstance().localVisible = false;
         event.currentTarget.removeEventListener("dispose",__frameDispose);
         ObjectUtils.disposeObject(CalendarManager.getInstance().model);
         CalendarManager.getInstance().model = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__mark);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
      }
      
      private function __mark(event:Event) : void
      {
         var today:* = null;
         if(CalendarManager.getInstance().isShow && CalendarManager.getInstance().model)
         {
            today = CalendarManager.getInstance().model.today;
            _localMarkDate.time = today.time + getTimer() - CalendarManager.getInstance().startTime;
            if(_localMarkDate.fullYear > today.fullYear || _localMarkDate.month > today.month || _localMarkDate.date > today.date)
            {
               localToNextDay(CalendarManager.getInstance().model,_localMarkDate);
            }
         }
      }
      
      public function closeActivity() : void
      {
         setState(1);
      }
      
      public function setState(data:* = null) : void
      {
         if(_frame)
         {
            (_frame as CalendarFrame).setState(data);
         }
      }
      
      private function localToNextDay(model:CalendarModel, date:Date) : void
      {
         var len:int = 0;
         var i:int = 0;
         if(date.date == 1)
         {
            len = CalendarModel.getMonthMaxDay(date.month,date.fullYear);
            for(i = 1; i <= len; )
            {
               CalendarManager.getInstance().model.dayLog[i] = "0";
               i++;
            }
            CalendarManager.getInstance().model.signCount = 0;
         }
         CalendarManager.getInstance().model.today = date;
      }
      
      public function sign(date:Date) : Boolean
      {
         var today:* = null;
         var result:Boolean = false;
         if(CalendarManager.getInstance().localVisible && CalendarManager.getInstance().model)
         {
            today = CalendarManager.getInstance().model.today;
            if(date.fullYear == today.fullYear && date.month == today.month && date.date == today.date && !CalendarManager.getInstance().model.hasSigned(date))
            {
               result = setSignInfo("True",date);
            }
         }
         return result;
      }
      
      public function signNew(date:Date) : Boolean
      {
         var len:int = 0;
         var i:int = 0;
         var result:Boolean = false;
         if(CalendarManager.getInstance().localVisible && CalendarManager.getInstance().model)
         {
            if(!CalendarManager.getInstance().model.hasSignedNew(date))
            {
               CalendarManager.getInstance().model.dayLog[date.date.toString()] = "True";
               CalendarManager.getInstance().model.signCount++;
               CalendarManager.getInstance().signCount = CalendarManager.getInstance().model.signCount;
               result = true;
               len = CalendarManager.getInstance().model.awardCounts.length;
               returnPetIsShow(CalendarManager.getInstance().model.signCount);
               for(i = 0; i < len; )
               {
                  if(CalendarManager.getInstance().model.signCount == CalendarManager.getInstance().model.awardCounts[i])
                  {
                     receive(CalendarManager.getInstance().model.awardCounts[i],CalendarManager.getInstance().model.awards);
                     return result;
                  }
                  i++;
               }
            }
         }
         return result;
      }
      
      private function returnPetIsShow(count:int) : void
      {
         var serverTime:Date = TimeManager.Instance.Now();
         var date:Date = new Date(serverTime.getFullYear(),serverTime.getMonth() + 1);
         date.time = date.time - 1;
         var totalDay:int = date.date;
         if(count == totalDay && !CalendarManager.getInstance().isOK)
         {
            dispatchEvent(new Event("petBtnShow"));
         }
      }
      
      private function setSignInfo(value:String, date:Date) : Boolean
      {
         var i:int = 0;
         var result:Boolean = false;
         SocketManager.Instance.out.sendDailyAward(5);
         CalendarManager.getInstance().model.dayLog[date.date.toString()] = "True";
         CalendarManager.getInstance().model.signCount++;
         CalendarManager.getInstance().signCount = CalendarManager.getInstance().model.signCount;
         result = true;
         var len:int = CalendarManager.getInstance().model.awardCounts.length;
         returnPetIsShow(CalendarManager.getInstance().model.signCount);
         for(i = 0; i < len; )
         {
            if(CalendarManager.getInstance().model.signCount == CalendarManager.getInstance().model.awardCounts[i])
            {
               receive(CalendarManager.getInstance().model.awardCounts[i],CalendarManager.getInstance().model.awards);
               return result;
            }
            i++;
         }
         return result;
      }
      
      public function lookActivity(date:Date) : void
      {
         if(_frame && CalendarManager.getInstance().model && hasSameWeek(CalendarManager.getInstance().model.today,date))
         {
            (_frame as CalendarFrame).activityList.setActivityDate(date);
         }
      }
      
      private function hasSameWeek(date1:Date, date2:Date) : Boolean
      {
         if(Math.abs(date2.time - date1.time) > 86400000 * 7)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.calendar.OutWeek"));
            return false;
         }
         return true;
      }
      
      public function receive(signCount:int, list:Array) : void
      {
         SocketManager.Instance.out.sendSignAward(signCount);
         var awards:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = list;
         for each(var award in list)
         {
            if(award.AwardDays == signCount)
            {
               awards.push(award);
            }
         }
         showAwardInfo(awards);
      }
      
      public function showAwardInfo(awards:Array) : void
      {
         var info:* = null;
         var msgStr:String = "";
         var _loc6_:int = 0;
         var _loc5_:* = awards;
         for each(var item in awards)
         {
            if(info)
            {
               msgStr = msgStr + (info.Name + "X" + item.Count + " ");
            }
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.calendar.signedAwards",msgStr));
      }
      
      public function reciveDayAward() : void
      {
         var nowDate:* = null;
         var date:Date = PlayerManager.Instance.Self.systemDate as Date;
         if(!CalendarManager.getInstance().dailyAwardState)
         {
            nowDate = new Date();
            nowDate.setTime(nowDate.getTime() + 86400000);
            AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.calendar.DailyAward",nowDate.month + 1,nowDate.date),LanguageMgr.GetTranslation("ok"),"",true,false,false,2);
         }
         else
         {
            CalendarManager.getInstance().dailyAwardState = false;
            MainButtnController.instance.DailyAwardState = false;
            SocketManager.Instance.out.sendDailyAward(0);
            MainButtnController.instance.dispatchEvent(new Event(MainButtnController.ICONCLOSE));
         }
      }
      
      public function reciveActivityAward(Active:ActiveEventsInfo, key:String) : BaseLoader
      {
         _reciveActive = Active;
         var temp:ByteArray = new ByteArray();
         temp.writeUTFBytes(key);
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var acc:AccountInfo = PlayerManager.Instance.Account;
         args["activeKey"] = CrytoUtils.rsaEncry4(acc.Key,temp);
         args["activeID"] = Active.ActiveID;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ActivePullDown.ashx"),6,args);
         loader.addEventListener("loadError",__onLoadError);
         loader.addEventListener("complete",__activityLoadComplete,false,99);
         LoadResourceManager.Instance.startLoad(loader,true);
         return loader;
      }
      
      private function __activityLoadComplete(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("loadError",__onLoadError);
         loader.removeEventListener("complete",__activityLoadComplete);
         var result:XML = XML(event.loader.content);
         if(String(result.@value) == "True")
         {
            _reciveActive.isAttend = true;
         }
         if(String(result.@message).length > 0)
         {
            MessageTipManager.getInstance().show(result.@message);
         }
      }
      
      private function __onLoadError(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("loadError",__onLoadError);
         loader.removeEventListener("complete",__complete);
      }
      
      private function __complete(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.currentTarget as BaseLoader;
         loader.removeEventListener("loadError",__onLoadError);
         loader.removeEventListener("complete",__complete);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
   }
}
