package trainer.controller{   import com.pickgliss.loader.BitmapLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ClassUtils;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.PreviewFrameManager;   import ddt.manager.SocketManager;   import ddt.view.MainToolBar;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.geom.Point;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.net.URLVariables;   import flash.utils.ByteArray;   import road7th.utils.MovieClipWrapper;      public class WeakGuildManager   {            private static var _instance:WeakGuildManager;                   private const LV:int = 15;            private var _type:String;            private var _title:String;            private var _newTask:Boolean;            private var _bmpLoader:BitmapLoader;            public function WeakGuildManager() { super(); }
            public static function get Instance() : WeakGuildManager { return null; }
            public function get switchUserGuide() : Boolean { return false; }
            public function get newTask() : Boolean { return false; }
            public function set newTask(value:Boolean) : void { }
            public function setup() : void { }
            private function __onChange(event:PlayerPropertyEvent) : void { }
            public function timeStatistics(type:int, startTime:Number) : void { }
            public function statistics(type:int, startTime:Number) : void { }
            public function setStepFinish(step:int) : void { }
            public function showMainToolBarBtnOpen(step:int, pos:String) : void { }
            public function checkFunction() : void { }
            public function checkOpen(step:int, lv:int) : Boolean { return false; }
            public function openBuildTip(buildName:String) : void { }
            public function showBuildPreview(type:String, title:String) : void { }
            private function __loadProgress(evt:LoaderEvent) : void { }
            private function __loadComplete(evt:LoaderEvent) : void { }
            private function __onClose(event:Event) : void { }
            private function disposeBmpLoader() : void { }
            private function checkLevelFunction() : void { }
            private function openFunction(id:int) : void { }
   }}