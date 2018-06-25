package groupPurchase{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.view.UIModuleSmallLoading;   import flash.events.EventDispatcher;   import groupPurchase.view.GroupPurchaseQuickBuyFrame;   import groupPurchase.view.GroupPurchaseRankFrame;      public class GroupPurchaseControl extends EventDispatcher   {            private static var _instance:GroupPurchaseControl;                   private var _func:Function;            private var _funcParams:Array;            public function GroupPurchaseControl() { super(); }
            public static function get instance() : GroupPurchaseControl { return null; }
            public function loadResModule(complete:Function = null, completeParams:Array = null) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
   }}