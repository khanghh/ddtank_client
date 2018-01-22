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
      
      public function HomeTempleController(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      protected function onHideEventHandler(param1:CEvent) : void
      {
         hide();
      }
      
      protected function onShowEventHandler(param1:CEvent) : void
      {
         onShow();
      }
      
      protected function __onGetTempleLevel(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         _currentInfo.CurrentSelectIndex = _loc3_.readInt();
         _currentInfo.CurrentLevel = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         _currentInfo.CurrentExp = _loc2_ - (_currentInfo.CurrentLevel > 0?_practiceList[_currentInfo.CurrentLevel].Exp:0);
         _templeFrame = ComponentFactory.Instance.creatComponentByStylename("home.HomeTempleFrame");
         _manager.setView(_templeFrame);
      }
      
      protected function __onImmolationResponse(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         _currentInfo.CurrentLevel = _loc4_.readInt();
         var _loc3_:int = _loc4_.readInt();
         _currentInfo.CurrentExp = _loc3_ - (_currentInfo.CurrentLevel > 0?_practiceList[_currentInfo.CurrentLevel].Exp:0);
         var _loc5_:int = _loc4_.readInt();
         var _loc2_:int = _loc4_.readInt();
         dispatchEvent(new HomeTempleEvent("homeTempleUpdateProperty",[_loc2_,_loc5_]));
         _templeFrame.resetBlessingPos();
      }
      
      private function showTempleFrame() : void
      {
         var _loc1_:* = null;
         if(_practiceList)
         {
            SocketManager.Instance.out.getHomeTempleLevel();
         }
         else
         {
            _loc1_ = getHomeTempleList();
            LoadResourceManager.Instance.startLoad(_loc1_);
         }
      }
      
      public function getExpPercent() : String
      {
         var _loc2_:int = _currentInfo.CurrentLevel + 1;
         _loc2_ = _loc2_ > MAXLEVEL?MAXLEVEL:int(_loc2_);
         var _loc1_:Number = _currentInfo.CurrentExp / (_practiceList[_loc2_].Exp - _practiceList[_loc2_ - 1].Exp) * 100;
         return _loc1_.toFixed(2);
      }
      
      public function getPracticeByLevel(param1:int) : HomeTempleModel
      {
         param1 = param1 > MAXLEVEL?MAXLEVEL:int(param1);
         return _practiceList[param1];
      }
      
      public function getStarNum() : int
      {
         var _loc2_:int = HomeTempleController.Instance.currentInfo.CurrentLevel;
         var _loc1_:int = 1;
         if(_loc2_ % 10 == 0)
         {
            if(_loc2_ > 0)
            {
               _loc1_ = _loc2_ / 10;
            }
         }
         else
         {
            _loc1_ = _loc2_ / 10 + 1;
         }
         return _loc1_;
      }
      
      public function getStarLevelNum() : int
      {
         var _loc1_:int = HomeTempleController.Instance.currentInfo.CurrentLevel;
         if(_loc1_ > 0)
         {
            _loc1_ = _loc1_ % 10;
            _loc1_ = _loc1_ == 0?10:_loc1_;
         }
         return _loc1_;
      }
      
      public function getPropertyInfoByIndex(param1:int) : HomeTempleModel
      {
         param1 = param1 == 0?1:param1;
         return _practiceList[param1 * 10];
      }
      
      public function onShow() : void
      {
         showTempleFrame();
      }
      
      public function getHomeTempleList2() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("HomeTempPracticeList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingHomeTempleListFailure");
         _loc1_.analyzer = new HomeTempleDataAnalyzer(getPracticeList2);
         _loc1_.addEventListener("loadError",__onLoadError);
         return _loc1_;
      }
      
      private function getPracticeList2(param1:HomeTempleDataAnalyzer) : void
      {
         _practiceList = param1.list;
      }
      
      private function getHomeTempleList() : BaseLoader
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("HomeTempPracticeList.xml"),5);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingHomeTempleListFailure");
         _loc1_.analyzer = new HomeTempleDataAnalyzer(getPracticeList);
         _loc1_.addEventListener("loadError",__onLoadError);
         return _loc1_;
      }
      
      private function getPracticeList(param1:HomeTempleDataAnalyzer) : void
      {
         _practiceList = param1.list;
         showTempleFrame();
      }
      
      public function __onLoadError(param1:LoaderEvent) : void
      {
         var _loc3_:String = param1.loader.loadErrorMessage;
         if(param1.loader.analyzer)
         {
            if(param1.loader.analyzer.message != null)
            {
               _loc3_ = param1.loader.loadErrorMessage + "\n" + param1.loader.analyzer.message;
            }
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),_loc3_,LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm"));
         _loc2_.addEventListener("response",__onAlertResponse);
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
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
