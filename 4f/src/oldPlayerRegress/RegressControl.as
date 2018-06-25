package oldPlayerRegress{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.LoaderManager;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import ddt.data.analyze.PlayerRegressNotificationAnalyzer;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import oldPlayerRegress.view.RegressView;      public class RegressControl extends EventDispatcher   {            public static var loadComplete:Boolean = false;            public static var useFirst:Boolean = true;            private static var _instance:RegressControl;                   private var _regressView:RegressView;            public var updateContent:String;            public function RegressControl() { super(); }
            public static function get instance() : RegressControl { return null; }
            public function setup() : void { }
            private function __onOpenView(event:RegressEvent) : void { }
            private function show() : void { }
            public function hide() : void { }
            private function __complainShow(event:UIModuleEvent) : void { }
            private function __progressShow(event:UIModuleEvent) : void { }
            protected function __onClose(event:Event) : void { }
            private function showRegressFrame() : void { }
            public function setupAnalyzer(analyzer:PlayerRegressNotificationAnalyzer) : void { }
            public function startPlayerRegressNotificationLoader() : void { }
            private function __loaderComplete(event:LoaderEvent) : void { }
   }}