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
      
      public function ComponentFactory(param1:ComponentFactoryEnforcer)
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
      
      public static function parasArgs(param1:String) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            StringUtils.trim(_loc2_[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function creat(param1:String, param2:Array = null) : *
      {
         var _loc3_:* = undefined;
         if(_model.getComonentStyle(param1))
         {
            _loc3_ = creatComponentByStylename(param1,param2);
         }
         else if(_model.getBitmapSet(param1) || ClassUtils.classIsBitmapData(param1))
         {
            _loc3_ = creatBitmap(param1);
         }
         else if(_model.getCustomObjectStyle(param1))
         {
            _loc3_ = creatCustomObject(param1,param2);
         }
         else
         {
            _loc3_ = ClassUtils.CreatInstance(param1,param2);
         }
         return _loc3_;
      }
      
      public function creatBitmap(param1:String) : Bitmap
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:XML = _model.getBitmapSet(param1);
         if(_loc4_ == null)
         {
            if(ClassUtils.uiSourceDomain.hasDefinition(param1))
            {
               _loc2_ = ClassUtils.CreatInstance(param1,[0,0]);
               _loc3_ = new Bitmap(_loc2_);
               _model.addBitmapSet(param1,new XML("<bitmapData resourceLink=\'" + param1 + "\' width=\'" + _loc3_.width + "\' height=\'" + _loc3_.height + "\' />"));
            }
            else
            {
               throw new Error("Bitmap:" + param1 + " is Not Found!",888);
            }
         }
         else
         {
            if(_loc4_.name() == ComponentSetting.BITMAPDATA_TAG_NAME)
            {
               _loc2_ = creatBitmapData(param1);
               _loc3_ = new Bitmap(_loc2_,"auto",String(_loc4_.@smoothing) == "true");
            }
            else
            {
               _loc3_ = ClassUtils.CreatInstance(param1);
            }
            ObjectUtils.copyPorpertiesByXML(_loc3_,_loc4_);
         }
         return _loc3_;
      }
      
      public function creatNumberSprite(param1:int, param2:String, param3:int = 0) : Sprite
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc7_:Sprite = new Sprite();
         var _loc5_:String = String(param1);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc4_ = creatBitmap(param2 + _loc5_.substr(_loc6_,1));
            _loc7_.addChild(_loc4_);
            _loc4_.x = (_loc4_.width + param3) * _loc6_;
            _loc6_++;
         }
         return _loc7_;
      }
      
      public function creatBitmapData(param1:String) : BitmapData
      {
         var _loc2_:* = null;
         var _loc3_:XML = _model.getBitmapSet(param1);
         if(_loc3_ == null)
         {
            return ClassUtils.CreatInstance(param1,[0,0]);
         }
         if(_loc3_.name() == ComponentSetting.BITMAPDATA_TAG_NAME)
         {
            _loc2_ = ClassUtils.CreatInstance(param1,[int(_loc3_.@width),int(_loc3_.@height)]);
         }
         else
         {
            _loc2_ = ClassUtils.CreatInstance(param1)["btimapData"];
         }
         return _loc2_;
      }
      
      public function creatComponentByStylename(param1:String, param2:Array = null) : *
      {
         var _loc3_:XML = getComponentStyle(param1);
         var _loc5_:String = _loc3_.@classname;
         var _loc4_:* = ClassUtils.CreatInstance(_loc5_,param2);
         _loc4_.id = componentID;
         _allComponents[_loc4_.id] = _loc4_;
         if(ClassUtils.classIsComponent(_loc5_))
         {
            _loc4_.beginChanges();
            ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_);
            _loc4_.commitChanges();
         }
         else
         {
            ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_);
         }
         _loc4_["stylename"] = param1;
         return _loc4_;
      }
      
      private function getComponentStyle(param1:String) : XML
      {
         var _loc3_:* = null;
         var _loc2_:XML = _model.getComonentStyle(param1);
         while(_loc2_ != null && _loc2_.hasOwnProperty("@parentStyle"))
         {
            _loc3_ = _model.getComonentStyle(String(_loc2_.@parentStyle));
            delete _loc2_.@parentStyle;
            ObjectUtils.combineXML(_loc2_,_loc3_);
         }
         return _loc2_;
      }
      
      public function getCustomStyle(param1:String) : XML
      {
         var _loc3_:* = null;
         var _loc2_:XML = _model.getCustomObjectStyle(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         while(_loc2_ && _loc2_.hasOwnProperty("@parentStyle"))
         {
            _loc3_ = _model.getCustomObjectStyle(String(_loc2_.@parentStyle));
            delete _loc2_.@parentStyle;
            ObjectUtils.combineXML(_loc2_,_loc3_);
         }
         return _loc2_;
      }
      
      public function creatCustomObject(param1:String, param2:Array = null) : *
      {
         var _loc3_:XML = getCustomStyle(param1);
         var _loc4_:String = _loc3_.@classname;
         var _loc5_:* = ClassUtils.CreatInstance(_loc4_,param2);
         ObjectUtils.copyPorpertiesByXML(_loc5_,_loc3_);
         return _loc5_;
      }
      
      public function getComponentByID(param1:int) : *
      {
         return _allComponents[param1];
      }
      
      public function checkAllComponentDispose(param1:Array) : void
      {
         var _loc7_:int = 0;
         var _loc6_:Dictionary = _model.allComponentStyle;
         var _loc3_:int = param1.length;
         var _loc5_:int = 1;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            var _loc11_:int = 0;
            var _loc10_:* = _loc6_;
            for each(var _loc2_ in _loc6_)
            {
               if(_loc2_.@componentModule != null && _loc2_.@componentModule == param1[_loc7_])
               {
                  var _loc9_:int = 0;
                  var _loc8_:* = _allComponents;
                  for each(var _loc4_ in _allComponents)
                  {
                     if(_loc4_ && _loc4_.stylename == _loc2_.@stylename)
                     {
                        trace(_loc5_.toString() + ". " + String(_loc2_.@stylename) + " =================> 可能未释放...请注意!");
                        _loc5_++;
                     }
                  }
                  continue;
               }
            }
            _loc7_++;
         }
      }
      
      public function removeComponent(param1:int) : void
      {
      }
      
      public function creatFrameFilters(param1:String) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = parasArgs(param1);
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_] == "null")
            {
               _loc3_.push(null);
            }
            else
            {
               _loc3_.push(creatFilters(_loc2_[_loc4_]));
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function creatFilters(param1:String) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = param1.split("|");
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_.push(ComponentFactory.Instance.model.getSet(_loc3_[_loc4_]));
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get model() : ComponentModel
      {
         return _model;
      }
      
      public function setup(param1:XML) : void
      {
         _model.addComponentSet(param1);
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
