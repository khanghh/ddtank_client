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
      
      public function addBitmapSet(param1:String, param2:XML) : void
      {
         _bitmapSets[param1] = param2;
      }
      
      public function addComponentSet(param1:XML) : void
      {
         if(_loadedComponentSet.indexOf(String(param1.@name)) != -1)
         {
            return;
         }
         _currentComponentSet = param1;
         _loadedComponentSet.push(String(_currentComponentSet.@name));
         if(Capabilities.isDebugger)
         {
            _allComponentSet[param1.@name] = param1;
         }
         paras();
      }
      
      public function get allTipStyles() : Vector.<String>
      {
         return _allTipStyles;
      }
      
      public function getBitmapSet(param1:String) : XML
      {
         return _bitmapSets[param1];
      }
      
      public function getComonentStyle(param1:String) : XML
      {
         return _componentStyle[param1];
      }
      
      public function getCustomObjectStyle(param1:String) : XML
      {
         return _customObjectStyle[param1];
      }
      
      public function getSet(param1:String) : *
      {
         return _styleSets[param1];
      }
      
      private function __onShaderLoadComplete(param1:LoaderEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:Object = findShaderDataByLoader(param1.loader);
         var _loc2_:Shader = new Shader(_loc4_.loader.content);
         var _loc3_:ShaderFilter = new ShaderFilter(_loc2_);
         var _loc5_:Array = ComponentFactory.parasArgs(_loc4_.xml.@paras);
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ = String(_loc5_[_loc7_]).split(":");
            if(_loc3_.shader.data.hasOwnProperty(_loc6_[0]))
            {
               _loc3_.shader.data[_loc6_[0]].value = [int(_loc6_[1])];
            }
            _loc7_++;
         }
         _styleSets[_loc4_.xml.@shadername] = _loc3_;
      }
      
      private function findShaderDataByLoader(param1:BaseLoader) : Object
      {
         var _loc4_:int = 0;
         var _loc3_:* = _shaderData;
         for each(var _loc2_ in _shaderData)
         {
            if(_loc2_.loader == param1)
            {
               return _loc2_;
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
      
      private function parasBitmapDataSets(param1:XMLList) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length())
         {
            _bitmapSets[param1[_loc2_].@resourceLink] = param1[_loc2_];
            _loc2_++;
         }
      }
      
      private function parasBitmapSets(param1:XMLList) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length())
         {
            _bitmapSets[param1[_loc2_].@resourceLink] = param1[_loc2_];
            _loc2_++;
         }
      }
      
      private function parasComponent(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length())
         {
            if(_componentStyle[param1[_loc3_].@stylename] != null)
            {
               _loc2_ = new Error("样式重名。。。请注意检查!!!!!!!!" + String(param1[_loc3_].@stylename));
               throw _loc2_;
            }
            param1[_loc3_].@componentModule = _currentComponentSet.@name;
            _componentStyle[param1[_loc3_].@stylename] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      private function parasCustomObject(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length())
         {
            if(_customObjectStyle[param1[_loc3_].@stylename] != null)
            {
               _loc2_ = new Error("样式重名。。。请注意检查!!!!!!!!" + String(param1[_loc3_].@stylename));
               throw _loc2_;
            }
            _customObjectStyle[param1[_loc3_].@stylename] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      private function parasSets(param1:XMLList) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length())
         {
            if(String(param1[_loc2_].@type) == "flash.filters.ColorMatrixFilter")
            {
               _styleSets[param1[_loc2_].@stylename] = ClassUtils.CreatInstance(param1[_loc2_].@type,[ComponentFactory.parasArgs(param1[_loc2_].@args)]);
            }
            else
            {
               _styleSets[param1[_loc2_].@stylename] = ClassUtils.CreatInstance(param1[_loc2_].@type,ComponentFactory.parasArgs(param1[_loc2_].@args));
            }
            ObjectUtils.copyPorpertiesByXML(_styleSets[param1[_loc2_].@stylename],param1[_loc2_]);
            _loc2_++;
         }
      }
      
      private function parasTipStyle(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = String(param1[0].@alltips).split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_allTipStyles.indexOf(_loc2_[_loc3_]) == -1)
            {
               _allTipStyles.push(_loc2_[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      public function get allComponentSet() : Dictionary
      {
         return _allComponentSet;
      }
      
      public function set allComponentSet(param1:Dictionary) : void
      {
         _allComponentSet = param1;
      }
   }
}
