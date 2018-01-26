package times
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.PathManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   import shop.manager.ShopBuyManager;
   import times.data.TimesAnalyzer;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   import times.data.TimesStatistics;
   import times.view.TimesView;
   
   public class TimesManager
   {
      
      private static var _instance:TimesManager;
       
      
      private var _timesBtn:MovieClip;
      
      private var _timesView:TimesView;
      
      private var _isReturn:Boolean;
      
      private var _isUIComplete:Boolean;
      
      private var _isUpdateResComplete:Boolean;
      
      private var _isThumbnailComplete:Boolean;
      
      private var _controller:TimesController;
      
      private var _statistics:TimesStatistics;
      
      private var _hallView:HallStateView;
      
      private var _isQQshow:Boolean = false;
      
      private var _page:int = 0;
      
      private var _updateContentList:Array;
      
      private var _isNeedOpenUpdateFrame:Boolean = false;
      
      public var isShowActivityAdvView:Boolean = false;
      
      public function TimesManager(){super();}
      
      public static function get Instance() : TimesManager{return null;}
      
      public function setup() : void{}
      
      public function showButton(param1:HallStateView) : void{}
      
      private function __onThumbnailComplete(param1:TimesEvent) : void{}
      
      public function hideButton() : void{}
      
      public function show() : void{}
      
      public function showByQQtips(param1:int) : void{}
      
      private function _QQshowComplete() : void{}
      
      private function __keyBoardEventHandler(param1:KeyboardEvent) : void{}
      
      public function hide() : void{}
      
      public function get statistics() : TimesStatistics{return null;}
      
      private function sendStatistics() : void{}
      
      private function __timesEventHandler(param1:TimesEvent) : void{}
      
      private function __onBtnClick(param1:MouseEvent) : void{}
      
      private function __canGenerateEgg(param1:PkgEvent) : void{}
      
      private function __onUIProgress(param1:UIModuleEvent) : void{}
      
      private function __onSmallLoadingClose(param1:Event) : void{}
      
      private function __onUIComplete(param1:UIModuleEvent) : void{}
      
      private function createTimesInfo() : void{}
      
      public function get updateContentList() : Array{return null;}
      
      public function checkOpenUpdateFrame() : void{}
      
      public function checkLoadUpdateRes(param1:Array, param2:Array) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function doOpenUpdateFrame() : void{}
      
      public function get isShowUpdateView() : Boolean{return false;}
   }
}
