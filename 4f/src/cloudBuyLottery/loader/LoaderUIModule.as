package cloudBuyLottery.loader{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.view.UIModuleSmallLoading;      public class LoaderUIModule   {            private static var _instance:LoaderUIModule;                   private var _func:Function;            private var _funcParams:Array;            private var _type:String;            public function LoaderUIModule(prc:PrivateClass) { super(); }
            public static function get Instance() : LoaderUIModule { return null; }
            public function loadUIModule(complete:Function = null, completeParams:Array = null, types:String = "") : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}