package com.pickgliss.ui{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Shader;   import flash.filters.ShaderFilter;   import flash.system.Capabilities;   import flash.utils.Dictionary;      public final class ComponentModel   {                   private var _allTipStyles:Vector.<String>;            private var _bitmapSets:Dictionary;            private var _componentStyle:Dictionary;            private var _currentComponentSet:XML;            private var _customObjectStyle:Dictionary;            private var _loadedComponentSet:Vector.<String>;            private var _shaderData:Dictionary;            private var _styleSets:Dictionary;            private var _allComponentSet:Dictionary;            public function ComponentModel() { super(); }
            public function get allComponentStyle() : Dictionary { return null; }
            public function addBitmapSet(classpath:String, tagData:XML) : void { }
            public function addComponentSet(componentSet:XML) : void { }
            public function get allTipStyles() : Vector.<String> { return null; }
            public function getBitmapSet(classpath:String) : XML { return null; }
            public function getComonentStyle(stylename:String) : XML { return null; }
            public function getCustomObjectStyle(stylename:String) : XML { return null; }
            public function getSet(key:String) : * { return null; }
            private function __onShaderLoadComplete(event:LoaderEvent) : void { }
            private function findShaderDataByLoader(loader:BaseLoader) : Object { return null; }
            private function paras() : void { }
            private function parasBitmapDataSets(list:XMLList) : void { }
            private function parasBitmapSets(list:XMLList) : void { }
            private function parasComponent(list:XMLList) : void { }
            private function parasCustomObject(list:XMLList) : void { }
            private function parasSets(list:XMLList) : void { }
            private function parasTipStyle(styles:XMLList) : void { }
            public function get allComponentSet() : Dictionary { return null; }
            public function set allComponentSet(value:Dictionary) : void { }
   }}