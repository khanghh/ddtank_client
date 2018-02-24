package com.greensock
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public dynamic class TweenProxy extends Proxy
   {
      
      public static const VERSION:Number = 0.94;
      
      private static const _DEG2RAD:Number = 0.017453292519943295;
      
      private static const _RAD2DEG:Number = 57.29577951308232;
      
      private static var _dict:Dictionary = new Dictionary(false);
      
      private static var _addedProps:String = " tint tintPercent scale skewX skewY skewX2 skewY2 target registration registrationX registrationY localRegistration localRegistrationX localRegistrationY ";
       
      
      private var _target:DisplayObject;
      
      private var _angle:Number;
      
      private var _scaleX:Number;
      
      private var _scaleY:Number;
      
      private var _proxies:Array;
      
      private var _localRegistration:Point;
      
      private var _registration:Point;
      
      private var _regAt0:Boolean;
      
      public var ignoreSiblingUpdates:Boolean = false;
      
      public var isTweenProxy:Boolean = true;
      
      public function TweenProxy(param1:DisplayObject, param2:Boolean = false){super();}
      
      public static function create(param1:DisplayObject, param2:Boolean = true) : TweenProxy{return null;}
      
      public function getCenter() : Point{return null;}
      
      public function get target() : DisplayObject{return null;}
      
      public function calibrate() : void{}
      
      public function destroy() : void{}
      
      override flash_proxy function callProperty(param1:*, ... rest) : *{return null;}
      
      override flash_proxy function getProperty(param1:*) : *{return null;}
      
      override flash_proxy function setProperty(param1:*, param2:*) : void{}
      
      override flash_proxy function hasProperty(param1:*) : Boolean{return false;}
      
      public function moveRegX(param1:Number) : void{}
      
      public function moveRegY(param1:Number) : void{}
      
      private function reposition() : void{}
      
      private function updateSiblingProxies() : void{}
      
      private function calibrateLocal() : void{}
      
      private function calibrateRegistration() : void{}
      
      public function onSiblingUpdate(param1:Number, param2:Number, param3:Number) : void{}
      
      public function get localRegistration() : Point{return null;}
      
      public function set localRegistration(param1:Point) : void{}
      
      public function get localRegistrationX() : Number{return 0;}
      
      public function set localRegistrationX(param1:Number) : void{}
      
      public function get localRegistrationY() : Number{return 0;}
      
      public function set localRegistrationY(param1:Number) : void{}
      
      public function get registration() : Point{return null;}
      
      public function set registration(param1:Point) : void{}
      
      public function get registrationX() : Number{return 0;}
      
      public function set registrationX(param1:Number) : void{}
      
      public function get registrationY() : Number{return 0;}
      
      public function set registrationY(param1:Number) : void{}
      
      public function get x() : Number{return 0;}
      
      public function set x(param1:Number) : void{}
      
      public function get y() : Number{return 0;}
      
      public function set y(param1:Number) : void{}
      
      public function get rotation() : Number{return 0;}
      
      public function set rotation(param1:Number) : void{}
      
      public function get skewX() : Number{return 0;}
      
      public function set skewX(param1:Number) : void{}
      
      public function get skewY() : Number{return 0;}
      
      public function set skewY(param1:Number) : void{}
      
      public function get skewX2() : Number{return 0;}
      
      public function set skewX2(param1:Number) : void{}
      
      public function get skewY2() : Number{return 0;}
      
      public function set skewY2(param1:Number) : void{}
      
      public function get skewX2Radians() : Number{return 0;}
      
      public function set skewX2Radians(param1:Number) : void{}
      
      public function get skewY2Radians() : Number{return 0;}
      
      public function set skewY2Radians(param1:Number) : void{}
      
      public function get scaleX() : Number{return 0;}
      
      public function set scaleX(param1:Number) : void{}
      
      public function get scaleY() : Number{return 0;}
      
      public function set scaleY(param1:Number) : void{}
      
      public function get scale() : Number{return 0;}
      
      public function set scale(param1:Number) : void{}
      
      public function get alpha() : Number{return 0;}
      
      public function set alpha(param1:Number) : void{}
      
      public function get width() : Number{return 0;}
      
      public function set width(param1:Number) : void{}
      
      public function get height() : Number{return 0;}
      
      public function set height(param1:Number) : void{}
   }
}
