package com.greensock{   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.geom.Matrix;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import flash.utils.Proxy;   import flash.utils.flash_proxy;      public dynamic class TweenProxy extends Proxy   {            public static const VERSION:Number = 0.94;            private static const _DEG2RAD:Number = 0.017453292519943295;            private static const _RAD2DEG:Number = 57.29577951308232;            private static var _dict:Dictionary = new Dictionary(false);            private static var _addedProps:String = " tint tintPercent scale skewX skewY skewX2 skewY2 target registration registrationX registrationY localRegistration localRegistrationX localRegistrationY ";                   private var _target:DisplayObject;            private var _angle:Number;            private var _scaleX:Number;            private var _scaleY:Number;            private var _proxies:Array;            private var _localRegistration:Point;            private var _registration:Point;            private var _regAt0:Boolean;            public var ignoreSiblingUpdates:Boolean = false;            public var isTweenProxy:Boolean = true;            public function TweenProxy(target:DisplayObject, ignoreSiblingUpdates:Boolean = false) { super(); }
            public static function create(target:DisplayObject, allowRecycle:Boolean = true) : TweenProxy { return null; }
            public function getCenter() : Point { return null; }
            public function get target() : DisplayObject { return null; }
            public function calibrate() : void { }
            public function destroy() : void { }
            override flash_proxy function callProperty(name:*, ... args) : * { return null; }
            override flash_proxy function getProperty(prop:*) : * { return null; }
            override flash_proxy function setProperty(prop:*, value:*) : void { }
            override flash_proxy function hasProperty(name:*) : Boolean { return false; }
            public function moveRegX(n:Number) : void { }
            public function moveRegY(n:Number) : void { }
            private function reposition() : void { }
            private function updateSiblingProxies() : void { }
            private function calibrateLocal() : void { }
            private function calibrateRegistration() : void { }
            public function onSiblingUpdate(scaleX:Number, scaleY:Number, angle:Number) : void { }
            public function get localRegistration() : Point { return null; }
            public function set localRegistration(p:Point) : void { }
            public function get localRegistrationX() : Number { return 0; }
            public function set localRegistrationX(n:Number) : void { }
            public function get localRegistrationY() : Number { return 0; }
            public function set localRegistrationY(n:Number) : void { }
            public function get registration() : Point { return null; }
            public function set registration(p:Point) : void { }
            public function get registrationX() : Number { return 0; }
            public function set registrationX(n:Number) : void { }
            public function get registrationY() : Number { return 0; }
            public function set registrationY(n:Number) : void { }
            public function get x() : Number { return 0; }
            public function set x(n:Number) : void { }
            public function get y() : Number { return 0; }
            public function set y(n:Number) : void { }
            public function get rotation() : Number { return 0; }
            public function set rotation(n:Number) : void { }
            public function get skewX() : Number { return 0; }
            public function set skewX(n:Number) : void { }
            public function get skewY() : Number { return 0; }
            public function set skewY(n:Number) : void { }
            public function get skewX2() : Number { return 0; }
            public function set skewX2(n:Number) : void { }
            public function get skewY2() : Number { return 0; }
            public function set skewY2(n:Number) : void { }
            public function get skewX2Radians() : Number { return 0; }
            public function set skewX2Radians(n:Number) : void { }
            public function get skewY2Radians() : Number { return 0; }
            public function set skewY2Radians(n:Number) : void { }
            public function get scaleX() : Number { return 0; }
            public function set scaleX(n:Number) : void { }
            public function get scaleY() : Number { return 0; }
            public function set scaleY(n:Number) : void { }
            public function get scale() : Number { return 0; }
            public function set scale(n:Number) : void { }
            public function get alpha() : Number { return 0; }
            public function set alpha(n:Number) : void { }
            public function get width() : Number { return 0; }
            public function set width(n:Number) : void { }
            public function get height() : Number { return 0; }
            public function set height(n:Number) : void { }
   }}