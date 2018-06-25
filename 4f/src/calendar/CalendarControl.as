package calendar{   import activeEvents.data.ActiveEventsInfo;   import calendar.event.CalendarEvent;   import calendar.view.ActivityState;   import calendar.view.CalendarFrame;   import calendar.view.CalendarState;   import calendar.view.SignFrame;   import com.pickgliss.events.ComponentEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.AccountInfo;   import ddt.data.DaylyGiveInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.CrytoUtils;   import ddt.utils.RequestVairableCreater;   import ddt.view.MainToolBar;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.net.URLVariables;   import flash.utils.ByteArray;   import flash.utils.getTimer;   import mainbutton.MainButtnController;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class CalendarControl extends EventDispatcher   {            public static const PET_BTN_SHOW:String = "petBtnShow";            private static var _ins:CalendarControl;                   private var _timer:TimerJuggler;            private var _localMarkDate:Date;            private var _frame:Frame;            private var _reciveActive:ActiveEventsInfo;            public function CalendarControl() { super(); }
            public static function getInstance() : CalendarControl { return null; }
            public function setup() : void { }
            private function __onOpenView(event:CalendarEvent) : void { }
            private function __onQqOpen(event:CalendarEvent) : void { }
            private function _qqOpenComplete() : void { }
            public function close() : void { }
            private function __frameDispose(event:ComponentEvent) : void { }
            private function __mark(event:Event) : void { }
            public function closeActivity() : void { }
            public function setState(data:* = null) : void { }
            private function localToNextDay(model:CalendarModel, date:Date) : void { }
            public function sign(date:Date) : Boolean { return false; }
            public function signNew(date:Date) : Boolean { return false; }
            private function returnPetIsShow(count:int) : void { }
            private function setSignInfo(value:String, date:Date) : Boolean { return false; }
            public function lookActivity(date:Date) : void { }
            private function hasSameWeek(date1:Date, date2:Date) : Boolean { return false; }
            public function receive(signCount:int, list:Array) : void { }
            public function showAwardInfo(awards:Array) : void { }
            public function reciveDayAward() : void { }
            public function reciveActivityAward(Active:ActiveEventsInfo, key:String) : BaseLoader { return null; }
            private function __activityLoadComplete(event:LoaderEvent) : void { }
            private function __onLoadError(event:LoaderEvent) : void { }
            private function __complete(event:LoaderEvent) : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
   }}