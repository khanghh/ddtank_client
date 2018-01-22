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
      
      private function __userLuckyNum(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         _luckyNum = _loc3_.readInt();
         var _loc2_:String = _loc3_.readUTF();
         if(_model)
         {
            _model.luckyNum = _luckyNum;
            _model.myLuckyNum = _myLuckyNum;
         }
         _responseLuckyNum = true;
      }
      
      public function open(param1:int, param2:Boolean = false) : void
      {
         _currentModel = param1;
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatDailyInfoLoader());
         AssetModuleLoader.addRequestLoader(request());
         var _loc3_:Boolean = _initialized && (!_localVisible || param2) && _today;
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatActionExchangeInfoLoader(),_loc3_);
         AssetModuleLoader.addModelLoader("ddtcalendar",6);
         AssetModuleLoader.startCodeLoader(loadDataComplete);
      }
      
      private function loadDataComplete() : void
      {
         _localVisible = true;
         SocketManager.Instance.addEventListener(PkgEvent.format(293),__onOpenDailyView);
         SocketManager.Instance.out.sendOpenDailyView();
      }
      
      private function __onOpenDailyView(param1:PkgEvent) : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(293),__onOpenDailyView);
         _model = new CalendarModel(_today,_signCount,_dayLogDic,_signAwards,_signAwardCounts,_eventActives,_activeExchange);
         _model.luckyNum = _luckyNum;
         _model.myLuckyNum = _myLuckyNum;
         var _loc2_:Date = new Date();
         if(_loc2_.time - _today.time > 86400000)
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
      
      public function qqOpen(param1:int) : void
      {
         _isQQopen = true;
         _activeID = param1;
         if(_initialized && !_localVisible)
         {
            open(2);
         }
         dispatchEvent(new CalendarEvent("calendarqqOpenView"));
      }
      
      public function request() : BaseLoader
      {
         var _loc1_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc1_["rnd"] = Math.random();
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("DailyLogList.ashx"),7,_loc1_);
         _loc2_.analyzer = new CalendarSignAnalyze(calendarSignComplete);
         LoadResourceManager.Instance.startLoad(_loc2_);
         return _loc2_;
      }
      
      public function requestActiveEvent() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ActiveList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadingActivityInformationFailure");
         _loc1_.analyzer = new ActiveEventsAnalyzer(setEventActivity);
         return _loc1_;
      }
      
      public function requestActionExchange() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ActiveConvertItemInfo.xml"),2);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.loadingActivityInformationFailure");
         _loc1_.analyzer = new ActiveExchangeAnalyzer(setActivityExchange);
         return _loc1_;
      }
      
      private function calendarSignComplete(param1:CalendarSignAnalyze) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Date = new Date();
         _startTime = getTimer();
         _today = param1.date;
         _times = param1.times;
         _price = param1.price;
         _isOK = param1.isOK == "True"?true:false;
         _signCount = 0;
         var _loc2_:Array = param1.dayLog.split(",");
         var _loc5_:int = CalendarModel.getMonthMaxDay(_today.month,_today.fullYear);
         if(_loc2_.length <= 0)
         {
            _isOK = false;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            if(_loc6_ < _loc2_.length && _loc2_[_loc6_] == "True")
            {
               _loc4_ = _loc6_ + 1;
               _signCount = Number(_signCount) + 1;
               _dayLogDic[_loc6_ + 1] = "True";
               if(_loc4_ == int(_loc3_.date))
               {
                  PlayerManager.Instance.Self.Sign = true;
                  MainButtnController.instance.dispatchEvent(new Event(MainButtnController.CLOSESIGN));
               }
            }
            else
            {
               _dayLogDic[_loc6_ + 1] = "False";
            }
            _loc6_++;
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
         for each(var _loc1_ in _eventActives)
         {
            if(_loc1_.IsShow == true && !_loc1_.overdue())
            {
               _showInfo = _loc1_;
               return true;
            }
         }
         return false;
      }
      
      public function getShowActiveInfo() : ActiveEventsInfo
      {
         return _showInfo;
      }
      
      public function setEventActivity(param1:ActiveEventsAnalyzer) : void
      {
         _eventActives = param1.list;
         WonderfulActivityManager.Instance.setLimitActivities(_eventActives);
      }
      
      public function get eventActives() : Array
      {
         return _eventActives;
      }
      
      public function setActivityExchange(param1:ActiveExchangeAnalyzer) : void
      {
         _activeExchange = param1.list;
      }
      
      public function get activeExchange() : Array
      {
         return _activeExchange;
      }
      
      public function setDailyInfo(param1:DaylyGiveAnalyzer) : void
      {
         _dailyInfo = param1.list;
         _signAwards = param1.signAwardList;
         _signAwardCounts = param1.signAwardCounts;
         _signPetInfo = param1.signPetInfo;
         _initialized = true;
      }
      
      public function set dailyAwardState(param1:Boolean) : void
      {
         _dailyAwardState = param1;
      }
      
      public function get dailyAwardState() : Boolean
      {
         return _dailyAwardState;
      }
      
      public function set isQQopen(param1:Boolean) : void
      {
         _isQQopen = param1;
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
      
      public function set localVisible(param1:Boolean) : void
      {
         _localVisible = param1;
      }
      
      public function get currentModel() : int
      {
         return _currentModel;
      }
      
      public function get startTime() : int
      {
         return _startTime;
      }
      
      public function set model(param1:CalendarModel) : void
      {
         _model = param1;
      }
      
      public function set signCount(param1:int) : void
      {
         _signCount = param1;
      }
      
      public function get isOK() : Boolean
      {
         return _isOK;
      }
      
      public function set isOK(param1:Boolean) : void
      {
         _isOK = param1;
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
      
      public function set times(param1:int) : void
      {
         _times = param1;
      }
      
      public function get localVisible() : Boolean
      {
         return _localVisible;
      }
   }
}
