package ddt.loader.assetsLoader{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;      public class UIAssetsLoader extends EventDispatcher   {            public static const UI_LIST_LOADED:String = "ui_list_loaded";                   private var _moduleLoadedDic:Dictionary;            private var _loadingIDList:Dictionary;            public function UIAssetsLoader() { super(); }
            public function load(id:String, moduleList:Array) : void { }
            protected function __onUIModuleComplete(event:UIModuleEvent) : void { }
            private function listLoaded(id:String) : void { }
            protected function __onProgress(event:UIModuleEvent) : void { }
            protected function __onClose(event:Event) : void { }
   }}