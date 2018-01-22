package calendar
{
   import activeEvents.data.ActiveEventsInfo;
   import calendar.event.CalendarEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.analyze.ActiveEventsAnalyzer;
   import ddt.data.analyze.ActiveExchangeAnalyzer;
   import ddt.data.analyze.CalendarSignAnalyze;
   import ddt.data.analyze.DaylyGiveAnalyzer;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.RequestVairableCreater;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import mainbutton.MainButtnController;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class CalendarManager extends EventDispatcher
   {
      
      private static var _isOK:Boolean;
      
      private static var _ins:CalendarManager;
       
      
      private var _localVisible:Boolean = false;
      
      private var _model:CalendarModel;
      
      private var _today:Date;
      
      private var _signCount:int;
      
      private var _restroSignCount:int;
      
      private var _dayLogDic:Dictionary;
      
      private var _startTime:int;
      
      private var _luckyNum:int = -1;
      
      private var _myLuckyNum:int = -1;
      
      private var _initialized:Boolean = false;
      
      private var _responseLuckyNum:Boolean = true;
      
      private var _currentModel:int;
      
      private var _times:int;
      
      private var _price:int;
      
      private var _isQQopen:Boolean = false;
      
      private var _activeID:int;
      
      private var _showInfo:ActiveEventsInfo;
      
      private var _eventActives:Array;
      
      private var _activeExchange:Array;
      
      private var _dailyInfo:Array;
      
      private var _signAwards:Array;
      
      private var _signAwardCounts:Array;
      
      private var _signPetInfo:Array;
      
      private var _dailyAwardState:Boolean = true;
      
      public function CalendarManager(){super();}
      
      public static function getInstance() : CalendarManager{return null;}
      
      public function initialize() : void{}
      
      public function requestLuckyNum() : void{}
      
      private function __userLuckyNum(param1:PkgEvent) : void{}
      
      public function open(param1:int, param2:Boolean = false) : void{}
      
      private function loadDataComplete() : void{}
      
      private function __onOpenDailyView(param1:PkgEvent) : void{}
      
      public function get luckyNum() : int{return 0;}
      
      public function qqOpen(param1:int) : void{}
      
      public function request() : BaseLoader{return null;}
      
      public function requestActiveEvent() : BaseLoader{return null;}
      
      public function requestActionExchange() : BaseLoader{return null;}
      
      private function calendarSignComplete(param1:CalendarSignAnalyze) : void{}
      
      public function hasTodaySigned() : Boolean{return false;}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function get isShow() : Boolean{return false;}
      
      public function checkEventInfo() : Boolean{return false;}
      
      public function getShowActiveInfo() : ActiveEventsInfo{return null;}
      
      public function setEventActivity(param1:ActiveEventsAnalyzer) : void{}
      
      public function get eventActives() : Array{return null;}
      
      public function setActivityExchange(param1:ActiveExchangeAnalyzer) : void{}
      
      public function get activeExchange() : Array{return null;}
      
      public function setDailyInfo(param1:DaylyGiveAnalyzer) : void{}
      
      public function set dailyAwardState(param1:Boolean) : void{}
      
      public function get dailyAwardState() : Boolean{return false;}
      
      public function set isQQopen(param1:Boolean) : void{}
      
      public function get isQQopen() : Boolean{return false;}
      
      public function get activeID() : int{return 0;}
      
      public function get model() : CalendarModel{return null;}
      
      public function set localVisible(param1:Boolean) : void{}
      
      public function get currentModel() : int{return 0;}
      
      public function get startTime() : int{return 0;}
      
      public function set model(param1:CalendarModel) : void{}
      
      public function set signCount(param1:int) : void{}
      
      public function get isOK() : Boolean{return false;}
      
      public function set isOK(param1:Boolean) : void{}
      
      public function get price() : int{return 0;}
      
      public function get signPetInfo() : Array{return null;}
      
      public function get times() : int{return 0;}
      
      public function set times(param1:int) : void{}
      
      public function get localVisible() : Boolean{return false;}
   }
}
