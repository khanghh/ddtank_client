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
      
      public function HomeTempleController(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : HomeTempleController{return null;}
      
      public function get practiceList() : Dictionary{return null;}
      
      public function setup() : void{}
      
      protected function onHideEventHandler(param1:CEvent) : void{}
      
      protected function onShowEventHandler(param1:CEvent) : void{}
      
      protected function __onGetTempleLevel(param1:PkgEvent) : void{}
      
      protected function __onImmolationResponse(param1:PkgEvent) : void{}
      
      private function showTempleFrame() : void{}
      
      public function getExpPercent() : String{return null;}
      
      public function getPracticeByLevel(param1:int) : HomeTempleModel{return null;}
      
      public function getStarNum() : int{return 0;}
      
      public function getStarLevelNum() : int{return 0;}
      
      public function getPropertyInfoByIndex(param1:int) : HomeTempleModel{return null;}
      
      public function onShow() : void{}
      
      public function getHomeTempleList2() : BaseLoader{return null;}
      
      private function getPracticeList2(param1:HomeTempleDataAnalyzer) : void{}
      
      private function getHomeTempleList() : BaseLoader{return null;}
      
      private function getPracticeList(param1:HomeTempleDataAnalyzer) : void{}
      
      public function __onLoadError(param1:LoaderEvent) : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      public function hide() : void{}
      
      public function get currentInfo() : HomeTempleData{return null;}
   }
}
