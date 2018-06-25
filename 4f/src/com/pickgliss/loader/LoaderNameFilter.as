package com.pickgliss.loader{   import flash.utils.Dictionary;      public class LoaderNameFilter   {            private static var _loadNameList:Dictionary = null;            private static var _pathList:Dictionary;                   public function LoaderNameFilter() { super(); }
            public static function setLoadNameContent(xml:XML) : void { }
            private static function isFilter(value:String) : Boolean { return false; }
            public static function getLoadFilePath(path:String) : String { return null; }
            public static function getRealFilePath(path:String) : String { return null; }
   }}