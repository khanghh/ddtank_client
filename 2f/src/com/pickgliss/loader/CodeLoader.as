package com.pickgliss.loader{   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.utils.ClassUtils;   import flash.utils.Dictionary;      public class CodeLoader   {            private static var _loadedDic:Dictionary = new Dictionary();                   private const DDT_CLASS_PATH:String = "DDT_Core";            private var _onLoaded:Function;            private var _url:String;            private var _onProgress:Function;            private var _coreLoader:BaseLoader;            public function CodeLoader() { super(); }
            public static function loaded(url:String) : Boolean { return false; }
            public static function removeURL(url:String) : void { }
            public static function addLoadURL(url:String) : void { }
            public function loadPNG($url:String, $onLoaded:Function, $onProgress:Function) : void { }
            public function stop() : void { }
            private function startLoad() : void { }
            protected function __onLoadCoreProgress(event:LoaderEvent) : void { }
            private function __onloadCoreComplete(event:LoaderEvent) : void { }
   }}