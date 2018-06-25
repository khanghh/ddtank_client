package ddt.utils{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.QueueLoader;   import ddt.manager.PathManager;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.utils.Dictionary;      public class HelperDataModuleLoad   {            private static var _loadedDic:Dictionary = new Dictionary();                   private var _loaderQueue:QueueLoader;            private var _loadProgress:int = 0;            private var _list:Array;            private var _update:Function;            private var _params:Array;            public function HelperDataModuleLoad() { super(); }
            public function loadDataModule(list:Array, update:Function, params:Array = null, isReal:Boolean = false, isSmallLoading:Boolean = true) : void { }
            protected function __onClose(event:Event) : void { }
            private function removeSmallLoading() : void { }
            private function __onDataLoadProgress(event:LoaderEvent) : void { }
            private function __onDataLoadComplete(event:Event) : void { }
            private function dispose() : void { }
   }}