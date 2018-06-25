package ddt.utils{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.utils.Dictionary;      public class HelperUIModuleLoad   {            private static var _loadedDic:Dictionary = new Dictionary();                   private var _loadProgress:int = 0;            private var _UILoadComplete:Boolean = false;            private var _loadlist:Array;            private var _update:Function;            private var _params:Array;            public function HelperUIModuleLoad() { super(); }
            public function loadUIModule(list:Array, update:Function, params:Array = null) : void { }
            protected function __onProgress(event:UIModuleEvent) : void { }
            protected function __onUIModuleComplete(event:UIModuleEvent) : void { }
            private function checkComplete(moduleName:String) : void { }
            protected function __onClose(event:Event) : void { }
            private function dispose() : void { }
   }}