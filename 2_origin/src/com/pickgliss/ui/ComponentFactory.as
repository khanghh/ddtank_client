package com.pickgliss.ui
{
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   
   public final class ComponentFactory
   {
      
      private static var _instance:ComponentFactory;
      
      private static var COMPONENT_COUNTER:int = 1;
       
      
      private var _allComponents:Dictionary;
      
      private var _model:ComponentModel;
      
      public function ComponentFactory(enforcer:ComponentFactoryEnforcer)
      {
         super();
         _model = new ComponentModel();
         _allComponents = new Dictionary();
         ClassUtils.uiSourceDomain = ApplicationDomain.currentDomain;
      }
      
      public static function get Instance() : ComponentFactory
      {
         if(_instance == null)
         {
            _instance = new ComponentFactory(new ComponentFactoryEnforcer());
         }
         return _instance;
      }
      
      public static function parasArgs(args:String) : Array
      {
         var i:int = 0;
         var resultArgs:Array = args.split(",");
         for(i = 0; i < resultArgs.length; )
         {
            StringUtils.trim(resultArgs[i]);
            i++;
         }
         return resultArgs;
      }
      
      public function creat(stylename:String, args:Array = null) : *
      {
         var com:* = undefined;
         if(_model.getComonentStyle(stylename))
         {
            com = creatComponentByStylename(stylename,args);
         }
         else if(_model.getBitmapSet(stylename) || ClassUtils.classIsBitmapData(stylename))
         {
            com = creatBitmap(stylename);
         }
         else if(_model.getCustomObjectStyle(stylename))
         {
            com = creatCustomObject(stylename,args);
         }
         else
         {
            com = ClassUtils.CreatInstance(stylename,args);
         }
         return com;
      }
      
      public function creatBitmap(classname:String) : Bitmap
      {
         var bitmapData:* = null;
         var bitmap:* = null;
         var bitmapSet:XML = _model.getBitmapSet(classname);
         if(bitmapSet == null)
         {
            if(ClassUtils.uiSourceDomain.hasDefinition(classname))
            {
               bitmapData = ClassUtils.CreatInstance(classname,[0,0]);
               bitmap = new Bitmap(bitmapData);
               _model.addBitmapSet(classname,new XML("<bitmapData resourceLink=\'" + classname + "\' width=\'" + bitmap.width + "\' height=\'" + bitmap.height + "\' />"));
            }
            else
            {
               throw new Error("Bitmap:" + classname + " is Not Found!",888);
            }
         }
         else
         {
            if(bitmapSet.name() == ComponentSetting.BITMAPDATA_TAG_NAME)
            {
               bitmapData = creatBitmapData(classname);
               bitmap = new Bitmap(bitmapData,"auto",String(bitmapSet.@smoothing) == "true");
            }
            else
            {
               bitmap = ClassUtils.CreatInstance(classname);
            }
            ObjectUtils.copyPorpertiesByXML(bitmap,bitmapSet);
         }
         return bitmap;
      }
      
      public function creatNumberSprite(num:int, classname:String, space:int = 0) : Sprite
      {
         var i:int = 0;
         var bit:* = null;
         var spr:Sprite = new Sprite();
         var strNum:String = String(num);
         for(i = 0; i < strNum.length; )
         {
            bit = creatBitmap(classname + strNum.substr(i,1));
            spr.addChild(bit);
            bit.x = (bit.width + space) * i;
            i++;
         }
         return spr;
      }
      
      public function creatBitmapData(classname:String) : BitmapData
      {
         var bitmapData:* = null;
         var bitmapSet:XML = _model.getBitmapSet(classname);
         if(bitmapSet == null)
         {
            return ClassUtils.CreatInstance(classname,[0,0]);
         }
         if(bitmapSet.name() == ComponentSetting.BITMAPDATA_TAG_NAME)
         {
            bitmapData = ClassUtils.CreatInstance(classname,[int(bitmapSet.@width),int(bitmapSet.@height)]);
         }
         else
         {
            bitmapData = ClassUtils.CreatInstance(classname)["btimapData"];
         }
         return bitmapData;
      }
      
      public function creatComponentByStylename(stylename:String, args:Array = null) : *
      {
         var style:XML = getComponentStyle(stylename);
         var classname:String = style.@classname;
         var component:* = ClassUtils.CreatInstance(classname,args);
         component.id = componentID;
         _allComponents[component.id] = component;
         if(ClassUtils.classIsComponent(classname))
         {
            component.beginChanges();
            ObjectUtils.copyPorpertiesByXML(component,style);
            component.commitChanges();
         }
         else
         {
            ObjectUtils.copyPorpertiesByXML(component,style);
         }
         component["stylename"] = stylename;
         return component;
      }
      
      private function getComponentStyle(stylename:String) : XML
      {
         var parentStyle:* = null;
         var style:XML = _model.getComonentStyle(stylename);
         while(style != null && style.hasOwnProperty("@parentStyle"))
         {
            parentStyle = _model.getComonentStyle(String(style.@parentStyle));
            delete style.@parentStyle;
            ObjectUtils.combineXML(style,parentStyle);
         }
         return style;
      }
      
      public function getCustomStyle(stylename:String) : XML
      {
         var parentStyle:* = null;
         var style:XML = _model.getCustomObjectStyle(stylename);
         if(style == null)
         {
            return null;
         }
         while(style && style.hasOwnProperty("@parentStyle"))
         {
            parentStyle = _model.getCustomObjectStyle(String(style.@parentStyle));
            delete style.@parentStyle;
            ObjectUtils.combineXML(style,parentStyle);
         }
         return style;
      }
      
      public function creatCustomObject(stylename:String, args:Array = null) : *
      {
         var style:XML = getCustomStyle(stylename);
         var classname:String = style.@classname;
         var custom:* = ClassUtils.CreatInstance(classname,args);
         ObjectUtils.copyPorpertiesByXML(custom,style);
         return custom;
      }
      
      public function getComponentByID(componentid:int) : *
      {
         return _allComponents[componentid];
      }
      
      public function checkAllComponentDispose(moduleArr:Array) : void
      {
         var i:int = 0;
         var dicStyle:Dictionary = _model.allComponentStyle;
         var len:int = moduleArr.length;
         var k:int = 1;
         for(i = 0; i < moduleArr.length; i++)
         {
            var _loc11_:int = 0;
            var _loc10_:* = dicStyle;
            for each(var item in dicStyle)
            {
               if(item.@componentModule != null && item.@componentModule == moduleArr[i])
               {
                  var _loc9_:int = 0;
                  var _loc8_:* = _allComponents;
                  for each(var compo in _allComponents)
                  {
                     if(compo && compo.stylename == item.@stylename)
                     {
                        trace(k.toString() + ". " + String(item.@stylename) + " =================> 可能未释放...请注意!");
                        k++;
                     }
                  }
                  continue;
               }
            }
         }
      }
      
      public function removeComponent(componentid:int) : void
      {
      }
      
      public function creatFrameFilters(filterString:String) : Array
      {
         var i:int = 0;
         var filterStyles:Array = parasArgs(filterString);
         var resultFilters:Array = [];
         for(i = 0; i < filterStyles.length; )
         {
            if(filterStyles[i] == "null")
            {
               resultFilters.push(null);
            }
            else
            {
               resultFilters.push(creatFilters(filterStyles[i]));
            }
            i++;
         }
         return resultFilters;
      }
      
      public function creatFilters(filtersStyle:String) : Array
      {
         var i:int = 0;
         var frameFilterStyle:Array = filtersStyle.split("|");
         var frameFilter:Array = [];
         for(i = 0; i < frameFilterStyle.length; )
         {
            frameFilter.push(ComponentFactory.Instance.model.getSet(frameFilterStyle[i]));
            i++;
         }
         return frameFilter;
      }
      
      public function get model() : ComponentModel
      {
         return _model;
      }
      
      public function setup(config:XML) : void
      {
         _model.addComponentSet(config);
      }
      
      public function get componentID() : int
      {
         COMPONENT_COUNTER = Number(COMPONENT_COUNTER) + 1;
         return Number(COMPONENT_COUNTER);
      }
   }
}

class ComponentFactoryEnforcer
{
    
   
   function ComponentFactoryEnforcer()
   {
      super();
   }
}
