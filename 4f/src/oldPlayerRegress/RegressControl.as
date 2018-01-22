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
      
      public function RegressControl(){super();}
      
      public static function get instance() : RegressControl{return null;}
      
      public function setup() : void{}
      
      private function __onOpenView(param1:RegressEvent) : void{}
      
      private function show() : void{}
      
      public function hide() : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function showRegressFrame() : void{}
      
      public function setupAnalyzer(param1:PlayerRegressNotificationAnalyzer) : void{}
      
      public function startPlayerRegressNotificationLoader() : void{}
      
      private function __loaderComplete(param1:LoaderEvent) : void{}
   }
}
