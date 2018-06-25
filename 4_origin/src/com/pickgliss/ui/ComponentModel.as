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
      
      public function ComponentModel()
      {
         super();
         _componentStyle = new Dictionary();
         _customObjectStyle = new Dictionary();
         _styleSets = new Dictionary();
         _allTipStyles = new Vector.<String>();
         _shaderData = new Dictionary();
         _bitmapSets = new Dictionary();
         _loadedComponentSet = new Vector.<String>();
         if(Capabilities.isDebugger)
         {
            _allComponentSet = new Dictionary();
         }
         var _loc1_:* = false;
         XML.ignoreProcessingInstructions = _loc1_;
         _loc1_ = _loc1_;
         XML.ignoreWhitespace = _loc1_;
         _loc1_ = _loc1_;
         XML.prettyPrinting = _loc1_;
         XML.ignoreComments = _loc1_;
         XML.prettyIndent = 0;
      }
      
      public function get allComponentStyle() : Dictionary
      {
         return _componentStyle;
      }
      
      public function addBitmapSet(classpath:String, tagData:XML) : void
      {
         _bitmapSets[classpath] = tagData;
      }
      
      public function addComponentSet(componentSet:XML) : void
      {
         if(_loadedComponentSet.indexOf(String(componentSet.@name)) != -1)
         {
            return;
         }
         _currentComponentSet = componentSet;
         _loadedComponentSet.push(String(_currentComponentSet.@name));
         if(Capabilities.isDebugger)
         {
            _allComponentSet[componentSet.@name] = componentSet;
         }
         paras();
      }
      
      public function get allTipStyles() : Vector.<String>
      {
         return _allTipStyles;
      }
      
      public function getBitmapSet(classpath:String) : XML
      {
         return _bitmapSets[classpath];
      }
      
      public function getComonentStyle(stylename:String) : XML
      {
         return _componentStyle[stylename];
      }
      
      public function getCustomObjectStyle(stylename:String) : XML
      {
         return _customObjectStyle[stylename];
      }
      
      public function getSet(key:String) : *
      {
         return _styleSets[key];
      }
      
      private function __onShaderLoadComplete(event:LoaderEvent) : void
      {
         var i:int = 0;
         var para:* = null;
         var shaderDataObject:Object = findShaderDataByLoader(event.loader);
         var shader:Shader = new Shader(shaderDataObject.loader.content);
         var shaderFilter:ShaderFilter = new ShaderFilter(shader);
         var shaderParas:Array = ComponentFactory.parasArgs(shaderDataObject.xml.@paras);
         for(i = 0; i < shaderParas.length; )
         {
            para = String(shaderParas[i]).split(":");
            if(shaderFilter.shader.data.hasOwnProperty(para[0]))
            {
               shaderFilter.shader.data[para[0]].value = [int(para[1])];
            }
            i++;
         }
         _styleSets[shaderDataObject.xml.@shadername] = shaderFilter;
      }
      
      private function findShaderDataByLoader(loader:BaseLoader) : Object
      {
         var _loc4_:int = 0;
         var _loc3_:* = _shaderData;
         for each(var shaderDataObject in _shaderData)
         {
            if(shaderDataObject.loader == loader)
            {
               return shaderDataObject;
            }
         }
         return null;
      }
      
      private function paras() : void
      {
         parasSets(_currentComponentSet..set);
         parasComponent(_currentComponentSet..component);
         parasCustomObject(_currentComponentSet..custom);
         if(_currentComponentSet.hasOwnProperty("tips"))
         {
            parasTipStyle(_currentComponentSet.tips);
         }
         if(_currentComponentSet.shaderFilters.length() > 0)
         {
         }
         parasBitmapDataSets(_currentComponentSet..bitmapData);
         parasBitmapSets(_currentComponentSet..bitmap);
      }
      
      private function parasBitmapDataSets(list:XMLList) : void
      {
         var i:int = 0;
         for(i = 0; i < list.length(); )
         {
            _bitmapSets[list[i].@resourceLink] = list[i];
            i++;
         }
      }
      
      private function parasBitmapSets(list:XMLList) : void
      {
         var i:int = 0;
         for(i = 0; i < list.length(); )
         {
            _bitmapSets[list[i].@resourceLink] = list[i];
            i++;
         }
      }
      
      private function parasComponent(list:XMLList) : void
      {
         var i:int = 0;
         var error:* = null;
         for(i = 0; i < list.length(); )
         {
            if(_componentStyle[list[i].@stylename] != null)
            {
               error = new Error("样式重名。。。请注意检查!!!!!!!!" + String(list[i].@stylename));
               throw error;
            }
            list[i].@componentModule = _currentComponentSet.@name;
            _componentStyle[list[i].@stylename] = list[i];
            i++;
         }
      }
      
      private function parasCustomObject(list:XMLList) : void
      {
         var i:int = 0;
         var error:* = null;
         for(i = 0; i < list.length(); )
         {
            if(_customObjectStyle[list[i].@stylename] != null)
            {
               error = new Error("样式重名。。。请注意检查!!!!!!!!" + String(list[i].@stylename));
               throw error;
            }
            _customObjectStyle[list[i].@stylename] = list[i];
            i++;
         }
      }
      
      private function parasSets(list:XMLList) : void
      {
         var i:int = 0;
         for(i = 0; i < list.length(); )
         {
            if(String(list[i].@type) == "flash.filters.ColorMatrixFilter")
            {
               _styleSets[list[i].@stylename] = ClassUtils.CreatInstance(list[i].@type,[ComponentFactory.parasArgs(list[i].@args)]);
            }
            else
            {
               _styleSets[list[i].@stylename] = ClassUtils.CreatInstance(list[i].@type,ComponentFactory.parasArgs(list[i].@args));
            }
            ObjectUtils.copyPorpertiesByXML(_styleSets[list[i].@stylename],list[i]);
            i++;
         }
      }
      
      private function parasTipStyle(styles:XMLList) : void
      {
         var i:int = 0;
         var allStyles:Array = String(styles[0].@alltips).split(",");
         for(i = 0; i < allStyles.length; )
         {
            if(_allTipStyles.indexOf(allStyles[i]) == -1)
            {
               _allTipStyles.push(allStyles[i]);
            }
            i++;
         }
      }
      
      public function get allComponentSet() : Dictionary
      {
         return _allComponentSet;
      }
      
      public function set allComponentSet(value:Dictionary) : void
      {
         _allComponentSet = value;
      }
   }
}
