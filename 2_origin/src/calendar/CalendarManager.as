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
      
      public function CalendarManager()
      {
         _dayLogDic = new Dictionary();
         super();
      }
      
      public static function getInstance() : CalendarManager
      {
         if(_ins == null)
         {
            _ins = new CalendarManager();
         }
         return _ins;
      }
      
      public function initialize() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(161),__userLuckyNum);
      }
      
      public function requestLuckyNum() : void
      {
         if(_responseLuckyNum)
         {
            SocketManager.Instance.out.sendUserLuckyNum(-1,false);
            _responseLuckyNum = false;
         }
      }
      
      private function __userLuckyNum(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _luckyNum = pkg.readInt();
         var luckyBuff:String = pkg.readUTF();
         if(_model)
         {
            _model.luckyNum = _luckyNum;
            _model.myLuckyNum = _myLuckyNum;
         }
         _responseLuckyNum = true;
      }
      
      public function open(current:int, isFromWantStrong:Boolean = false) : void
      {
         _currentModel = current;
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatDailyInfoLoader());
         AssetModuleLoader.addRequestLoader(request());
         var isReset:Boolean = _initialized && (!_localVisible || isFromWantStrong) && _today;
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatActionExchangeInfoLoader(),isReset);
         AssetModuleLoader.addModelLoader("ddtcalendar",6);
         AssetModuleLoader.startCodeLoader(loadDataComplete);
      }
      
      private function loadDataComplete() : void
      {
         _localVisible = true;
         SocketManager.Instance.addEventListener(PkgEvent.format(293),__onOpenDailyView);
         SocketManager.Instance.out.sendOpenDailyView();
      }
      
      private function __onOpenDailyView(e:PkgEvent) : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(293),__onOpenDailyView);
         _model = new CalendarModel(_today,_signCount,_dayLogDic,_signAwards,_signAwardCounts,_eventActives,_activeExchange);
         _model.luckyNum = _luckyNum;
         _model.myLuckyNum = _myLuckyNum;
         var localDate:Date = new Date();
         if(localDate.time - _today.time > 86400000)
         {
            SocketManager.Instance.out.sendErrorMsg("打开签到的时候，客户端时间与服务器时间间隔超过一天。by" + PlayerManager.Instance.Self.NickName);
         }
         dispatchEvent(new CalendarEvent("calendarOpenView"));
         requestLuckyNum();
      }
      
      public function get luckyNum() : int
      {
         return _luckyNum;
      }
      
      public function qqOpen(activeID:int) : void
      {
         _isQQopen = true;
         _activeID = activeID;
         if(_initialized && !_localVisible)
         {
            open(2);
         }
         dispatchEvent(new CalendarEvent("calendarqqOpenView"));
      }
      
      public function request() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["rnd"] = Math.random();
         var calendarLoader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DailyLogList.ashx"),7,args);
         calendarLoader.analyzer = new CalendarSignAnalyze(calendarSignComplete);
         LoadResourceManager.Instance.startLoad(calendarLoader);
         return calendarLoader;
      }
      
      public function requestActiveEvent() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ActiveList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadingActivityInformationFailure");
         loader.analyzer = new ActiveEventsAnalyzer(setEventActivity);
         return loader;
      }
      
      public function requestActionExchange() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ActiveConvertItemInfo.xml"),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadingActivityInformationFailure");
         loader.analyzer = new ActiveExchangeAnalyzer(setActivityExchange);
         return loader;
      }
      
      private function calendarSignComplete(analyze:CalendarSignAnalyze) : void
      {
         var i:int = 0;
         var day:int = 0;
         var nowtoday:Date = new Date();
         _startTime = getTimer();
         _today = analyze.date;
         _times = analyze.times;
         _price = analyze.price;
         _isOK = analyze.isOK == "True"?true:false;
         _signCount = 0;
         var arr:Array = analyze.dayLog.split(",");
         var len:int = CalendarModel.getMonthMaxDay(_today.month,_today.fullYear);
         if(arr.length <= 0)
         {
            _isOK = false;
         }
         i = 0;
         while(i < len)
         {
            if(i < arr.length && arr[i] == "True")
            {
               day = i + 1;
               _signCount = Number(_signCount) + 1;
               _dayLogDic[i + 1] = "True";
               if(day == int(nowtoday.date))
               {
                  PlayerManager.Instance.Self.Sign = true;
                  MainButtnController.instance.dispatchEvent(new Event(MainButtnController.CLOSESIGN));
               }
            }
            else
            {
               _dayLogDic[i + 1] = "False";
            }
            i++;
         }
         if(_model && _localVisible)
         {
            _model.today = _today;
            _model.signCount = _signCount;
            _model.dayLog = _dayLogDic;
         }
      }
      
      public function hasTodaySigned() : Boolean
      {
         return _dayLogDic && _today && _dayLogDic[_today.date.toString()] == "True";
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get isShow() : Boolean
      {
         return _localVisible;
      }
      
      public function checkEventInfo() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _eventActives;
         for each(var info in _eventActives)
         {
            if(info.IsShow == true && !info.overdue())
            {
               _showInfo = info;
               return true;
            }
         }
         return false;
      }
      
      public function getShowActiveInfo() : ActiveEventsInfo
      {
         return _showInfo;
      }
      
      public function setEventActivity(analyzer:ActiveEventsAnalyzer) : void
      {
         _eventActives = analyzer.list;
         WonderfulActivityManager.Instance.setLimitActivities(_eventActives);
      }
      
      public function get eventActives() : Array
      {
         return _eventActives;
      }
      
      public function setActivityExchange(analyzer:ActiveExchangeAnalyzer) : void
      {
         _activeExchange = analyzer.list;
      }
      
      public function get activeExchange() : Array
      {
         return _activeExchange;
      }
      
      public function setDailyInfo(analyzer:DaylyGiveAnalyzer) : void
      {
         _dailyInfo = analyzer.list;
         _signAwards = analyzer.signAwardList;
         _signAwardCounts = analyzer.signAwardCounts;
         _signPetInfo = analyzer.signPetInfo;
         _initialized = true;
      }
      
      public function set dailyAwardState(state:Boolean) : void
      {
         _dailyAwardState = state;
      }
      
      public function get dailyAwardState() : Boolean
      {
         return _dailyAwardState;
      }
      
      public function set isQQopen(value:Boolean) : void
      {
         _isQQopen = value;
      }
      
      public function get isQQopen() : Boolean
      {
         return _isQQopen;
      }
      
      public function get activeID() : int
      {
         return _activeID;
      }
      
      public function get model() : CalendarModel
      {
         return _model;
      }
      
      public function set localVisible(value:Boolean) : void
      {
         _localVisible = value;
      }
      
      public function get currentModel() : int
      {
         return _currentModel;
      }
      
      public function get startTime() : int
      {
         return _startTime;
      }
      
      public function set model(value:CalendarModel) : void
      {
         _model = value;
      }
      
      public function set signCount(value:int) : void
      {
         _signCount = value;
      }
      
      public function get isOK() : Boolean
      {
         return _isOK;
      }
      
      public function set isOK(value:Boolean) : void
      {
         _isOK = value;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function get signPetInfo() : Array
      {
         return _signPetInfo;
      }
      
      public function get times() : int
      {
         return _times;
      }
      
      public function set times(value:int) : void
      {
         _times = value;
      }
      
      public function get localVisible() : Boolean
      {
         return _localVisible;
      }
   }
}
