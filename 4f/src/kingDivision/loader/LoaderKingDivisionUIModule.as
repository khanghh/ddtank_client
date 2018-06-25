package kingDivision.loader{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.view.UIModuleSmallLoading;      public class LoaderKingDivisionUIModule   {            private static var _instance:LoaderKingDivisionUIModule;                   private var _func:Function;            private var _funcParams:Array;            public function LoaderKingDivisionUIModule(prc:PrivateClass) { super(); }
            public static function get Instance() : LoaderKingDivisionUIModule { return null; }
            public function loadUIModule(complete:Function = null, completeParams:Array = null) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}