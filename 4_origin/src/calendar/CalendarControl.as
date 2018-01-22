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
      
      private function __onOpenView(param1:CalendarEvent) : void
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
      
      private function __onQqOpen(param1:CalendarEvent) : void
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
      
      private function __frameDispose(param1:ComponentEvent) : void
      {
         CalendarManager.getInstance().localVisible = false;
         param1.currentTarget.removeEventListener("dispose",__frameDispose);
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
      
      private function __mark(param1:Event) : void
      {
         var _loc2_:* = null;
         if(CalendarManager.getInstance().isShow && CalendarManager.getInstance().model)
         {
            _loc2_ = CalendarManager.getInstance().model.today;
            _localMarkDate.time = _loc2_.time + getTimer() - CalendarManager.getInstance().startTime;
            if(_localMarkDate.fullYear > _loc2_.fullYear || _localMarkDate.month > _loc2_.month || _localMarkDate.date > _loc2_.date)
            {
               localToNextDay(CalendarManager.getInstance().model,_localMarkDate);
            }
         }
      }
      
      public function closeActivity() : void
      {
         setState(1);
      }
      
      public function setState(param1:* = null) : void
      {
         if(_frame)
         {
            (_frame as CalendarFrame).setState(param1);
         }
      }
      
      private function localToNextDay(param1:CalendarModel, param2:Date) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param2.date == 1)
         {
            _loc3_ = CalendarModel.getMonthMaxDay(param2.month,param2.fullYear);
            _loc4_ = 1;
            while(_loc4_ <= _loc3_)
            {
               CalendarManager.getInstance().model.dayLog[_loc4_] = "0";
               _loc4_++;
            }
            CalendarManager.getInstance().model.signCount = 0;
         }
         CalendarManager.getInstance().model.today = param2;
      }
      
      public function sign(param1:Date) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:Boolean = false;
         if(CalendarManager.getInstance().localVisible && CalendarManager.getInstance().model)
         {
            _loc3_ = CalendarManager.getInstance().model.today;
            if(param1.fullYear == _loc3_.fullYear && param1.month == _loc3_.month && param1.date == _loc3_.date && !CalendarManager.getInstance().model.hasSigned(param1))
            {
               _loc2_ = setSignInfo("True",param1);
            }
         }
         return _loc2_;
      }
      
      public function signNew(param1:Date) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         if(CalendarManager.getInstance().localVisible && CalendarManager.getInstance().model)
         {
            if(!CalendarManager.getInstance().model.hasSignedNew(param1))
            {
               CalendarManager.getInstance().model.dayLog[param1.date.toString()] = "True";
               CalendarManager.getInstance().model.signCount++;
               CalendarManager.getInstance().signCount = CalendarManager.getInstance().model.signCount;
               _loc2_ = true;
               _loc3_ = CalendarManager.getInstance().model.awardCounts.length;
               returnPetIsShow(CalendarManager.getInstance().model.signCount);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  if(CalendarManager.getInstance().model.signCount == CalendarManager.getInstance().model.awardCounts[_loc4_])
                  {
                     receive(CalendarManager.getInstance().model.awardCounts[_loc4_],CalendarManager.getInstance().model.awards);
                     return _loc2_;
                  }
                  _loc4_++;
               }
            }
         }
         return _loc2_;
      }
      
      private function returnPetIsShow(param1:int) : void
      {
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc3_:Date = new Date(_loc2_.getFullYear(),_loc2_.getMonth() + 1);
         _loc3_.time = _loc3_.time - 1;
         var _loc4_:int = _loc3_.date;
         if(param1 == _loc4_ && !CalendarManager.getInstance().isOK)
         {
            dispatchEvent(new Event("petBtnShow"));
         }
      }
      
      private function setSignInfo(param1:String, param2:Date) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         SocketManager.Instance.out.sendDailyAward(5);
         CalendarManager.getInstance().model.dayLog[param2.date.toString()] = "True";
         CalendarManager.getInstance().model.signCount++;
         CalendarManager.getInstance().signCount = CalendarManager.getInstance().model.signCount;
         _loc3_ = true;
         var _loc4_:int = CalendarManager.getInstance().model.awardCounts.length;
         returnPetIsShow(CalendarManager.getInstance().model.signCount);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(CalendarManager.getInstance().model.signCount == CalendarManager.getInstance().model.awardCounts[_loc5_])
            {
               receive(CalendarManager.getInstance().model.awardCounts[_loc5_],CalendarManager.getInstance().model.awards);
               return _loc3_;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function lookActivity(param1:Date) : void
      {
         if(_frame && CalendarManager.getInstance().model && hasSameWeek(CalendarManager.getInstance().model.today,param1))
         {
            (_frame as CalendarFrame).activityList.setActivityDate(param1);
         }
      }
      
      private function hasSameWeek(param1:Date, param2:Date) : Boolean
      {
         if(Math.abs(param2.time - param1.time) > 86400000 * 7)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.calendar.OutWeek"));
            return false;
         }
         return true;
      }
      
      public function receive(param1:int, param2:Array) : void
      {
         SocketManager.Instance.out.sendSignAward(param1);
         var _loc3_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = param2;
         for each(var _loc4_ in param2)
         {
            if(_loc4_.AwardDays == param1)
            {
               _loc3_.push(_loc4_);
            }
         }
         showAwardInfo(_loc3_);
      }
      
      public function showAwardInfo(param1:Array) : void
      {
         var _loc4_:* = null;
         var _loc2_:String = "";
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(_loc4_)
            {
               _loc2_ = _loc2_ + (_loc4_.Name + "X" + _loc3_.Count + " ");
            }
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.calendar.signedAwards",_loc2_));
      }
      
      public function reciveDayAward() : void
      {
         var _loc1_:* = null;
         var _loc2_:Date = PlayerManager.Instance.Self.systemDate as Date;
         if(!CalendarManager.getInstance().dailyAwardState)
         {
            _loc1_ = new Date();
            _loc1_.setTime(_loc1_.getTime() + 86400000);
            AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.calendar.DailyAward",_loc1_.month + 1,_loc1_.date),LanguageMgr.GetTranslation("ok"),"",true,false,false,2);
         }
         else
         {
            CalendarManager.getInstance().dailyAwardState = false;
            MainButtnController.instance.DailyAwardState = false;
            SocketManager.Instance.out.sendDailyAward(0);
            MainButtnController.instance.dispatchEvent(new Event(MainButtnController.ICONCLOSE));
         }
      }
      
      public function reciveActivityAward(param1:ActiveEventsInfo, param2:String) : BaseLoader
      {
         _reciveActive = param1;
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeUTFBytes(param2);
         var _loc4_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var _loc6_:AccountInfo = PlayerManager.Instance.Account;
         _loc4_["activeKey"] = CrytoUtils.rsaEncry4(_loc6_.Key,_loc5_);
         _loc4_["activeID"] = param1.ActiveID;
         var _loc3_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ActivePullDown.ashx"),6,_loc4_);
         _loc3_.addEventListener("loadError",__onLoadError);
         _loc3_.addEventListener("complete",__activityLoadComplete,false,99);
         LoadResourceManager.Instance.startLoad(_loc3_,true);
         return _loc3_;
      }
      
      private function __activityLoadComplete(param1:LoaderEvent) : void
      {
         var _loc3_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc3_.removeEventListener("loadError",__onLoadError);
         _loc3_.removeEventListener("complete",__activityLoadComplete);
         var _loc2_:XML = XML(param1.loader.content);
         if(String(_loc2_.@value) == "True")
         {
            _reciveActive.isAttend = true;
         }
         if(String(_loc2_.@message).length > 0)
         {
            MessageTipManager.getInstance().show(_loc2_.@message);
         }
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("loadError",__onLoadError);
         _loc2_.removeEventListener("complete",__complete);
      }
      
      private function __complete(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.currentTarget as BaseLoader;
         _loc2_.removeEventListener("loadError",__onLoadError);
         _loc2_.removeEventListener("complete",__complete);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
   }
}
