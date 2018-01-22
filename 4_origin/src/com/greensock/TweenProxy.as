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
      
      public function TweenProxy(param1:DisplayObject, param2:Boolean = false)
      {
         super();
         _target = param1;
         if(_dict[_target] == undefined)
         {
            _dict[_target] = [];
         }
         _proxies = _dict[_target];
         _proxies.push(this);
         _localRegistration = new Point(0,0);
         this.ignoreSiblingUpdates = param2;
         calibrate();
      }
      
      public static function create(param1:DisplayObject, param2:Boolean = true) : TweenProxy
      {
         if(_dict[param1] != null && param2)
         {
            return _dict[param1][0];
         }
         return new TweenProxy(param1);
      }
      
      public function getCenter() : Point
      {
         var _loc2_:* = null;
         var _loc3_:Boolean = false;
         if(_target.parent == null)
         {
            _loc3_ = true;
            _loc2_ = new Sprite();
            _loc2_.addChild(_target);
         }
         var _loc1_:Rectangle = _target.getBounds(_target.parent);
         var _loc4_:Point = new Point(_loc1_.x + _loc1_.width / 2,_loc1_.y + _loc1_.height / 2);
         if(_loc3_)
         {
            _target.parent.removeChild(_target);
         }
         return _loc4_;
      }
      
      public function get target() : DisplayObject
      {
         return _target;
      }
      
      public function calibrate() : void
      {
         _scaleX = _target.scaleX;
         _scaleY = _target.scaleY;
         _angle = _target.rotation * 0.0174532925199433;
         calibrateRegistration();
      }
      
      public function destroy() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = _dict[_target];
         _loc2_ = _loc1_.length - 1;
         while(_loc2_ > -1)
         {
            if(_loc1_[_loc2_] == this)
            {
               _loc1_.splice(_loc2_,1);
            }
            _loc2_--;
         }
         if(_loc1_.length == 0)
         {
            delete _dict[_target];
         }
         _target = null;
         _localRegistration = null;
         _registration = null;
         _proxies = null;
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : *
      {
         return _target[param1].apply(null,rest);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return _target[param1];
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         _target[param1] = param2;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         if(_target.hasOwnProperty(param1))
         {
            return true;
         }
         if(_addedProps.indexOf(" " + param1 + " ") != -1)
         {
            return true;
         }
         return false;
      }
      
      public function moveRegX(param1:Number) : void
      {
         _registration.x = _registration.x + param1;
      }
      
      public function moveRegY(param1:Number) : void
      {
         _registration.y = _registration.y + param1;
      }
      
      private function reposition() : void
      {
         var _loc1_:Point = _target.parent.globalToLocal(_target.localToGlobal(_localRegistration));
         _target.x = _target.x + (_registration.x - _loc1_.x);
         _target.y = _target.y + (_registration.y - _loc1_.y);
      }
      
      private function updateSiblingProxies() : void
      {
         var _loc1_:int = 0;
         _loc1_ = _proxies.length - 1;
         while(_loc1_ > -1)
         {
            if(_proxies[_loc1_] != this)
            {
               _proxies[_loc1_].onSiblingUpdate(_scaleX,_scaleY,_angle);
            }
            _loc1_--;
         }
      }
      
      private function calibrateLocal() : void
      {
         _localRegistration = _target.globalToLocal(_target.parent.localToGlobal(_registration));
         _regAt0 = _localRegistration.x == 0 && _localRegistration.y == 0;
      }
      
      private function calibrateRegistration() : void
      {
         _registration = _target.parent.globalToLocal(_target.localToGlobal(_localRegistration));
         _regAt0 = _localRegistration.x == 0 && _localRegistration.y == 0;
      }
      
      public function onSiblingUpdate(param1:Number, param2:Number, param3:Number) : void
      {
         _scaleX = param1;
         _scaleY = param2;
         _angle = param3;
         if(this.ignoreSiblingUpdates)
         {
            calibrateLocal();
         }
         else
         {
            calibrateRegistration();
         }
      }
      
      public function get localRegistration() : Point
      {
         return _localRegistration;
      }
      
      public function set localRegistration(param1:Point) : void
      {
         _localRegistration = param1;
         calibrateRegistration();
      }
      
      public function get localRegistrationX() : Number
      {
         return _localRegistration.x;
      }
      
      public function set localRegistrationX(param1:Number) : void
      {
         _localRegistration.x = param1;
         calibrateRegistration();
      }
      
      public function get localRegistrationY() : Number
      {
         return _localRegistration.y;
      }
      
      public function set localRegistrationY(param1:Number) : void
      {
         _localRegistration.y = param1;
         calibrateRegistration();
      }
      
      public function get registration() : Point
      {
         return _registration;
      }
      
      public function set registration(param1:Point) : void
      {
         _registration = param1;
         calibrateLocal();
      }
      
      public function get registrationX() : Number
      {
         return _registration.x;
      }
      
      public function set registrationX(param1:Number) : void
      {
         _registration.x = param1;
         calibrateLocal();
      }
      
      public function get registrationY() : Number
      {
         return _registration.y;
      }
      
      public function set registrationY(param1:Number) : void
      {
         _registration.y = param1;
         calibrateLocal();
      }
      
      public function get x() : Number
      {
         return _registration.x;
      }
      
      public function set x(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Number = param1 - _registration.x;
         _target.x = _target.x + _loc2_;
         _loc3_ = _proxies.length - 1;
         while(_loc3_ > -1)
         {
            if(_proxies[_loc3_] == this || !_proxies[_loc3_].ignoreSiblingUpdates)
            {
               _proxies[_loc3_].moveRegX(_loc2_);
            }
            _loc3_--;
         }
      }
      
      public function get y() : Number
      {
         return _registration.y;
      }
      
      public function set y(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Number = param1 - _registration.y;
         _target.y = _target.y + _loc2_;
         _loc3_ = _proxies.length - 1;
         while(_loc3_ > -1)
         {
            if(_proxies[_loc3_] == this || !_proxies[_loc3_].ignoreSiblingUpdates)
            {
               _proxies[_loc3_].moveRegY(_loc2_);
            }
            _loc3_--;
         }
      }
      
      public function get rotation() : Number
      {
         return _angle * 57.2957795130823;
      }
      
      public function set rotation(param1:Number) : void
      {
         var _loc2_:Number = param1 * 0.0174532925199433;
         var _loc3_:Matrix = _target.transform.matrix;
         _loc3_.rotate(_loc2_ - _angle);
         _target.transform.matrix = _loc3_;
         _angle = _loc2_;
         reposition();
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get skewX() : Number
      {
         var _loc1_:Matrix = _target.transform.matrix;
         return (Math.atan2(-_loc1_.c,_loc1_.d) - _angle) * 57.2957795130823;
      }
      
      public function set skewX(param1:Number) : void
      {
         var _loc2_:Number = param1 * 0.0174532925199433;
         var _loc3_:Matrix = _target.transform.matrix;
         var _loc4_:Number = _scaleY < 0?-_scaleY:Number(_scaleY);
         _loc3_.c = -_loc4_ * Math.sin(_loc2_ + _angle);
         _loc3_.d = _loc4_ * Math.cos(_loc2_ + _angle);
         _target.transform.matrix = _loc3_;
         if(!_regAt0)
         {
            reposition();
         }
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get skewY() : Number
      {
         var _loc1_:Matrix = _target.transform.matrix;
         return (Math.atan2(_loc1_.b,_loc1_.a) - _angle) * 57.2957795130823;
      }
      
      public function set skewY(param1:Number) : void
      {
         var _loc2_:Number = param1 * 0.0174532925199433;
         var _loc3_:Matrix = _target.transform.matrix;
         var _loc4_:Number = _scaleX < 0?-_scaleX:Number(_scaleX);
         _loc3_.a = _loc4_ * Math.cos(_loc2_ + _angle);
         _loc3_.b = _loc4_ * Math.sin(_loc2_ + _angle);
         _target.transform.matrix = _loc3_;
         if(!_regAt0)
         {
            reposition();
         }
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get skewX2() : Number
      {
         return this.skewX2Radians * 57.2957795130823;
      }
      
      public function set skewX2(param1:Number) : void
      {
         this.skewX2Radians = param1 * 0.0174532925199433;
      }
      
      public function get skewY2() : Number
      {
         return this.skewY2Radians * 57.2957795130823;
      }
      
      public function set skewY2(param1:Number) : void
      {
         this.skewY2Radians = param1 * 0.0174532925199433;
      }
      
      public function get skewX2Radians() : Number
      {
         return -Math.atan(_target.transform.matrix.c);
      }
      
      public function set skewX2Radians(param1:Number) : void
      {
         var _loc2_:Matrix = _target.transform.matrix;
         _loc2_.c = Math.tan(-param1);
         _target.transform.matrix = _loc2_;
         if(!_regAt0)
         {
            reposition();
         }
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get skewY2Radians() : Number
      {
         return Math.atan(_target.transform.matrix.b);
      }
      
      public function set skewY2Radians(param1:Number) : void
      {
         var _loc2_:Matrix = _target.transform.matrix;
         _loc2_.b = Math.tan(param1);
         _target.transform.matrix = _loc2_;
         if(!_regAt0)
         {
            reposition();
         }
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get scaleX() : Number
      {
         return _scaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         var _loc2_:Matrix = _target.transform.matrix;
         _loc2_.rotate(-_angle);
         _loc2_.scale(param1 / _scaleX,1);
         _loc2_.rotate(_angle);
         _target.transform.matrix = _loc2_;
         _scaleX = param1;
         reposition();
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get scaleY() : Number
      {
         return _scaleY;
      }
      
      public function set scaleY(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         var _loc2_:Matrix = _target.transform.matrix;
         _loc2_.rotate(-_angle);
         _loc2_.scale(1,param1 / _scaleY);
         _loc2_.rotate(_angle);
         _target.transform.matrix = _loc2_;
         _scaleY = param1;
         reposition();
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get scale() : Number
      {
         return (_scaleX + _scaleY) / 2;
      }
      
      public function set scale(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         var _loc2_:Matrix = _target.transform.matrix;
         _loc2_.rotate(-_angle);
         _loc2_.scale(param1 / _scaleX,param1 / _scaleY);
         _loc2_.rotate(_angle);
         _target.transform.matrix = _loc2_;
         _scaleY = param1;
         _scaleX = param1;
         reposition();
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get alpha() : Number
      {
         return _target.alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         _target.alpha = param1;
      }
      
      public function get width() : Number
      {
         return _target.width;
      }
      
      public function set width(param1:Number) : void
      {
         _target.width = param1;
         if(!_regAt0)
         {
            reposition();
         }
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get height() : Number
      {
         return _target.height;
      }
      
      public function set height(param1:Number) : void
      {
         _target.height = param1;
         if(!_regAt0)
         {
            reposition();
         }
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
   }
}
