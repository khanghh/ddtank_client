package tool{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.view.UIModuleSmallLoading;   import flash.utils.setTimeout;      public class LoaderClass   {            private static var _instance:LoaderClass;                   private var _func:Function;            private var _funcParams:Array;            private var _type:String;            private var _type1:String;            public function LoaderClass(prc:PrivateClass) { super(); }
            public static function get Instance() : LoaderClass { return null; }
            public function loadUIModule(complete:Function = null, completeParams:Array = null, types:String = "", types1:String = "") : void { }
            private function loaderTwoUIModule() : void { }
            private function daleyTime() : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
   }}class PrivateClass{          function PrivateClass() { super(); }
}