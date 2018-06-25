package com.pickgliss.ui{   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StringUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.system.ApplicationDomain;   import flash.utils.Dictionary;      public final class ComponentFactory   {            private static var _instance:ComponentFactory;            private static var COMPONENT_COUNTER:int = 1;                   private var _allComponents:Dictionary;            private var _model:ComponentModel;            public function ComponentFactory(enforcer:ComponentFactoryEnforcer) { super(); }
            public static function get Instance() : ComponentFactory { return null; }
            public static function parasArgs(args:String) : Array { return null; }
            public function creat(stylename:String, args:Array = null) : * { return null; }
            public function creatBitmap(classname:String) : Bitmap { return null; }
            public function creatNumberSprite(num:int, classname:String, space:int = 0) : Sprite { return null; }
            public function creatBitmapData(classname:String) : BitmapData { return null; }
            public function creatComponentByStylename(stylename:String, args:Array = null) : * { return null; }
            private function getComponentStyle(stylename:String) : XML { return null; }
            public function getCustomStyle(stylename:String) : XML { return null; }
            public function creatCustomObject(stylename:String, args:Array = null) : * { return null; }
            public function getComponentByID(componentid:int) : * { return null; }
            public function checkAllComponentDispose(moduleArr:Array) : void { }
            public function removeComponent(componentid:int) : void { }
            public function creatFrameFilters(filterString:String) : Array { return null; }
            public function creatFilters(filtersStyle:String) : Array { return null; }
            public function get model() : ComponentModel { return null; }
            public function setup(config:XML) : void { }
            public function get componentID() : int { return 0; }
   }}class ComponentFactoryEnforcer{          function ComponentFactoryEnforcer() { super(); }
}