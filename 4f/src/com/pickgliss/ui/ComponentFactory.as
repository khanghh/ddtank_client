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
      
      public function ComponentFactory(param1:ComponentFactoryEnforcer){super();}
      
      public static function get Instance() : ComponentFactory{return null;}
      
      public static function parasArgs(param1:String) : Array{return null;}
      
      public function creat(param1:String, param2:Array = null) : *{return null;}
      
      public function creatBitmap(param1:String) : Bitmap{return null;}
      
      public function creatNumberSprite(param1:int, param2:String, param3:int = 0) : Sprite{return null;}
      
      public function creatBitmapData(param1:String) : BitmapData{return null;}
      
      public function creatComponentByStylename(param1:String, param2:Array = null) : *{return null;}
      
      private function getComponentStyle(param1:String) : XML{return null;}
      
      public function getCustomStyle(param1:String) : XML{return null;}
      
      public function creatCustomObject(param1:String, param2:Array = null) : *{return null;}
      
      public function getComponentByID(param1:int) : *{return null;}
      
      public function checkAllComponentDispose(param1:Array) : void{}
      
      public function removeComponent(param1:int) : void{}
      
      public function creatFrameFilters(param1:String) : Array{return null;}
      
      public function creatFilters(param1:String) : Array{return null;}
      
      public function get model() : ComponentModel{return null;}
      
      public function setup(param1:XML) : void{}
      
      public function get componentID() : int{return 0;}
   }
}

class ComponentFactoryEnforcer
{
    
   
   function ComponentFactoryEnforcer(){super();}
}
