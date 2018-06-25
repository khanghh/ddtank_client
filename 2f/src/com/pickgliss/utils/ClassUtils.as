package com.pickgliss.utils{   import flash.errors.IllegalOperationError;   import flash.system.ApplicationDomain;   import flash.utils.getDefinitionByName;   import flash.utils.getQualifiedSuperclassName;      public final class ClassUtils   {            public static const INNERRECTANGLE:String = "com.pickgliss.geom.InnerRectangle";            public static const OUTTERRECPOS:String = "com.pickgliss.geom.OuterRectPos";            public static const RECTANGLE:String = "flash.geom.Rectangle";            public static const COLOR_MATIX_FILTER:String = "flash.filters.ColorMatrixFilter";            private static var _appDomain:ApplicationDomain;                   public function ClassUtils() { super(); }
            public static function CreatInstance(className:String, args:Array = null) : * { return null; }
            public static function get uiSourceDomain() : ApplicationDomain { return null; }
            public static function set uiSourceDomain(domain:ApplicationDomain) : void { }
            public static function getDefinition(classname:String) : Object { return null; }
            public static function classIsBitmapData(classname:String) : Boolean { return false; }
            public static function classIsComponent(classname:String) : Boolean { return false; }
   }}