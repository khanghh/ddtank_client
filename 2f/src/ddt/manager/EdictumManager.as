package ddt.manager{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import ddt.data.analyze.LoadEdictumAnalyze;   import ddt.events.PkgEvent;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.comm.PackageIn;   import times.TimesManager;      public class EdictumManager extends EventDispatcher   {            private static var _instance:EdictumManager;                   private var unShowArr:Array;            private var edictumDataList:Array;            public function EdictumManager(target:IEventDispatcher = null) { super(); }
            public static function get Instance() : EdictumManager { return null; }
            public function setup() : void { }
            private function initEvents() : void { }
            private function __getEdictumVersion(e:PkgEvent) : void { }
            private function __checkVersion(arr:Array) : void { }
            private function __loadEdictumData() : void { }
            private function __returnWebSiteInfoHandler(action:LoadEdictumAnalyze) : void { }
            private function __getURL() : String { return null; }
   }}