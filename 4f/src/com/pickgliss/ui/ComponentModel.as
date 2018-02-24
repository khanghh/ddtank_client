package com.pickgliss.ui
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shader;
   import flash.filters.ShaderFilter;
   import flash.system.Capabilities;
   import flash.utils.Dictionary;
   
   public final class ComponentModel
   {
       
      
      private var _allTipStyles:Vector.<String>;
      
      private var _bitmapSets:Dictionary;
      
      private var _componentStyle:Dictionary;
      
      private var _currentComponentSet:XML;
      
      private var _customObjectStyle:Dictionary;
      
      private var _loadedComponentSet:Vector.<String>;
      
      private var _shaderData:Dictionary;
      
      private var _styleSets:Dictionary;
      
      private var _allComponentSet:Dictionary;
      
      public function ComponentModel(){super();}
      
      public function get allComponentStyle() : Dictionary{return null;}
      
      public function addBitmapSet(param1:String, param2:XML) : void{}
      
      public function addComponentSet(param1:XML) : void{}
      
      public function get allTipStyles() : Vector.<String>{return null;}
      
      public function getBitmapSet(param1:String) : XML{return null;}
      
      public function getComonentStyle(param1:String) : XML{return null;}
      
      public function getCustomObjectStyle(param1:String) : XML{return null;}
      
      public function getSet(param1:String) : *{return null;}
      
      private function __onShaderLoadComplete(param1:LoaderEvent) : void{}
      
      private function findShaderDataByLoader(param1:BaseLoader) : Object{return null;}
      
      private function paras() : void{}
      
      private function parasBitmapDataSets(param1:XMLList) : void{}
      
      private function parasBitmapSets(param1:XMLList) : void{}
      
      private function parasComponent(param1:XMLList) : void{}
      
      private function parasCustomObject(param1:XMLList) : void{}
      
      private function parasSets(param1:XMLList) : void{}
      
      private function parasTipStyle(param1:XMLList) : void{}
      
      public function get allComponentSet() : Dictionary{return null;}
      
      public function set allComponentSet(param1:Dictionary) : void{}
   }
}
