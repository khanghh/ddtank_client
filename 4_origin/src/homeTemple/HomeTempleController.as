package homeTemple
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import homeTemple.data.HomeTempleData;
   import homeTemple.data.HomeTempleDataAnalyzer;
   import homeTemple.data.HomeTempleModel;
   import homeTemple.event.HomeTempleEvent;
   import homeTemple.view.HomeTempleFrame;
   import road7th.comm.PackageIn;
   
   public class HomeTempleController extends EventDispatcher
   {
      
      public static var MAXLEVEL:int = 0;
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:HomeTempleController;
       
      
      private var _templeFrame:HomeTempleFrame;
      
      private var _practiceList:Dictionary;
      
      private var _currentInfo:HomeTempleData;
      
      private var _manager:HomeTempleManager;
      
      public function HomeTempleController(target:IEventDispatcher = null)
      {
         super(target);
         _currentInfo = new HomeTempleData();
      }
      
      public static function get Instance() : HomeTempleController
      {
         if(!_instance)
         {
            _instance = new HomeTempleController();
         }
         return _instance;
      }
      
      public function get practiceList() : Dictionary
      {
         return _practiceList;
      }
      
      public function setup() : void
      {
         _manager = HomeTempleManager.getInstance();
         _manager.addEventListener("ht_show",onShowEventHandler);
         _manager.addEventListener("ht_hide",onHideEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(297,0),__onGetTempleLevel);
         SocketManager.Instance.addEventListener(PkgEvent.format(297,1),__onImmolationResponse);
      }
      
      protected function onHideEventHandler(e:CEvent) : void
      {
         hide();
      }
      
      protected function onShowEventHandler(e:CEvent) : void
      {
         onShow();
      }
      
      protected function __onGetTempleLevel(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _currentInfo.CurrentSelectIndex = pkg.readInt();
         _currentInfo.CurrentLevel = pkg.readInt();
         var exp:int = pkg.readInt();
         _currentInfo.CurrentExp = exp - (_currentInfo.CurrentLevel > 0?_practiceList[_currentInfo.CurrentLevel].Exp:0);
         _templeFrame = ComponentFactory.Instance.creatComponentByStylename("home.HomeTempleFrame");
         _manager.setView(_templeFrame);
      }
      
      protected function __onImmolationResponse(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _currentInfo.CurrentLevel = pkg.readInt();
         var exp:int = pkg.readInt();
         _currentInfo.CurrentExp = exp - (_currentInfo.CurrentLevel > 0?_practiceList[_currentInfo.CurrentLevel].Exp:0);
         var maxBombNum:int = pkg.readInt();
         var minBombNum:int = pkg.readInt();
         dispatchEvent(new HomeTempleEvent("homeTempleUpdateProperty",[minBombNum,maxBombNum]));
         _templeFrame.resetBlessingPos();
      }
      
      private function showTempleFrame() : void
      {
         var loader:* = null;
         if(_practiceList)
         {
            SocketManager.Instance.out.getHomeTempleLevel();
         }
         else
         {
            loader = getHomeTempleList();
            LoadResourceManager.Instance.startLoad(loader);
         }
      }
      
      public function getExpPercent() : String
      {
         var level:int = _currentInfo.CurrentLevel + 1;
         level = level > MAXLEVEL?MAXLEVEL:int(level);
         var num:Number = _currentInfo.CurrentExp / (_practiceList[level].Exp - _practiceList[level - 1].Exp) * 100;
         return num.toFixed(2);
      }
      
      public function getPracticeByLevel(level:int) : HomeTempleModel
      {
         level = level > MAXLEVEL?MAXLEVEL:int(level);
         return _practiceList[level];
      }
      
      public function getStarNum() : int
      {
         var level:int = HomeTempleController.Instance.currentInfo.CurrentLevel;
         var movieId:int = 1;
         if(level % 10 == 0)
         {
            if(level > 0)
            {
               movieId = level / 10;
            }
         }
         else
         {
            movieId = level / 10 + 1;
         }
         return movieId;
      }
      
      public function getStarLevelNum() : int
      {
         var level:int = HomeTempleController.Instance.currentInfo.CurrentLevel;
         if(level > 0)
         {
            level = level % 10;
            level = level == 0?10:level;
         }
         return level;
      }
      
      public function getPropertyInfoByIndex(level:int) : HomeTempleModel
      {
         level = level == 0?1:level;
         return _practiceList[level * 10];
      }
      
      public function onShow() : void
      {
         showTempleFrame();
      }
      
      public function getHomeTempleList2() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("HomeTempPracticeList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingHomeTempleListFailure");
         loader.analyzer = new HomeTempleDataAnalyzer(getPracticeList2);
         loader.addEventListener("loadError",__onLoadError);
         return loader;
      }
      
      private function getPracticeList2(analyzer:HomeTempleDataAnalyzer) : void
      {
         _practiceList = analyzer.list;
      }
      
      private function getHomeTempleList() : BaseLoader
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("HomeTempPracticeList.xml"),5);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingHomeTempleListFailure");
         loader.analyzer = new HomeTempleDataAnalyzer(getPracticeList);
         loader.addEventListener("loadError",__onLoadError);
         return loader;
      }
      
      private function getPracticeList(analyzer:HomeTempleDataAnalyzer) : void
      {
         _practiceList = analyzer.list;
         showTempleFrame();
      }
      
      public function __onLoadError(event:LoaderEvent) : void
      {
         var msg:String = event.loader.loadErrorMessage;
         if(event.loader.analyzer)
         {
            if(event.loader.analyzer.message != null)
            {
               msg = event.loader.loadErrorMessage + "\n" + event.loader.analyzer.message;
            }
         }
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),msg,LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm"));
         alert.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(event:FrameEvent) : void
      {
         event.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(event.currentTarget);
         LeavePageManager.leaveToLoginPath();
      }
      
      public function hide() : void
      {
         if(_templeFrame != null)
         {
            ObjectUtils.disposeObject(_templeFrame);
         }
         _templeFrame = null;
      }
      
      public function get currentInfo() : HomeTempleData
      {
         return _currentInfo;
      }
   }
}
