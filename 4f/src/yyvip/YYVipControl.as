package yyvip{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.events.CEvent;   import ddt.manager.ItemManager;   import ddt.utils.AssetModuleLoader;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.net.URLRequest;   import flash.net.navigateToURL;   import yyvip.view.YYVipMainFrame;      public class YYVipControl extends EventDispatcher   {            private static var _instance:YYVipControl;                   public function YYVipControl(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : YYVipControl { return null; }
            public function setup() : void { }
            protected function __onOpenView(event:CEvent) : void { }
            private function loadCompleteHandler() : void { }
            public function get openViewAwardList() : Vector.<Object> { return null; }
            public function getDailyLevelVipAwardList(index:int) : Vector.<Object> { return null; }
            public function get dailyViewYearAwardList() : Vector.<Object> { return null; }
            public function gotoOpenUrl() : void { }
   }}