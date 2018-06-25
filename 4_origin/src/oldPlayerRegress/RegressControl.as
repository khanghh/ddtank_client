package oldPlayerRegress
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.LoaderManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.analyze.PlayerRegressNotificationAnalyzer;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import oldPlayerRegress.view.RegressView;
   
   public class RegressControl extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:RegressControl;
       
      
      private var _regressView:RegressView;
      
      public var updateContent:String;
      
      public function RegressControl()
      {
         super();
      }
      
      public static function get instance() : RegressControl
      {
         if(!_instance)
         {
            _instance = new RegressControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         RegressManager.instance.addEventListener("regressOpenView",__onOpenView);
      }
      
      private function __onOpenView(event:RegressEvent) : void
      {
         show();
      }
      
      private function show() : void
      {
         if(!updateContent)
         {
            startPlayerRegressNotificationLoader();
            return;
         }
         if(loadComplete)
         {
            showRegressFrame();
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__complainShow);
            UIModuleLoader.Instance.addUIModuleImp("ddtregressview");
         }
      }
      
      public function hide() : void
      {
         if(_regressView != null)
         {
            _regressView.dispose();
         }
         _regressView = null;
      }
      
      private function __complainShow(event:UIModuleEvent) : void
      {
         if(event.module == "ddtregressview")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            useFirst = false;
            __onOpenView(null);
         }
      }
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "ddtregressview")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
      }
      
      private function showRegressFrame() : void
      {
         _regressView = ComponentFactory.Instance.creatComponentByStylename("regress.RegressView");
         _regressView.show();
      }
      
      public function setupAnalyzer(analyzer:PlayerRegressNotificationAnalyzer) : void
      {
         updateContent = analyzer.updateContent;
      }
      
      public function startPlayerRegressNotificationLoader() : void
      {
         var loader:BaseLoader = LoaderManager.Instance.creatLoader(PathManager.getPlayerRegressNotificationPath(),2);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingPlayerRegressNotificationFailure");
         loader.analyzer = new PlayerRegressNotificationAnalyzer(setupAnalyzer);
         loader.addEventListener("loadError",LoaderCreate.Instance.__onLoadError);
         loader.addEventListener("complete",__loaderComplete);
         LoaderManager.Instance.startLoad(loader);
      }
      
      private function __loaderComplete(event:LoaderEvent) : void
      {
         var loader:BaseLoader = BaseLoader(event.currentTarget);
         loader.removeEventListener("loadError",LoaderCreate.Instance.__onLoadError);
         loader.removeEventListener("complete",__loaderComplete);
         show();
      }
   }
}
