package com.greensock
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public dynamic class TweenProxyStarling extends Proxy
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
      
      public function TweenProxyStarling(target:DisplayObject, ignoreSiblingUpdates:Boolean = false)
      {
         super();
         _target = target;
         if(_dict[_target] == undefined)
         {
            _dict[_target] = [];
         }
         _proxies = _dict[_target];
         _proxies.push(this);
         _localRegistration = new Point(0,0);
         this.ignoreSiblingUpdates = ignoreSiblingUpdates;
         calibrate();
      }
      
      public static function create(target:DisplayObject, allowRecycle:Boolean = true) : TweenProxyStarling
      {
         if(_dict[target] != null && allowRecycle)
         {
            return _dict[target][0];
         }
         return new TweenProxyStarling(target);
      }
      
      public function getCenter() : Point
      {
         var s:* = null;
         var remove:Boolean = false;
         if(_target.parent == null)
         {
            remove = true;
            s = new Sprite();
            s.addChild(_target);
         }
         var b:Rectangle = _target.getBounds(_target.parent);
         var p:Point = new Point(b.x + b.width / 2,b.y + b.height / 2);
         if(remove)
         {
            _target.parent.removeChild(_target);
         }
         return p;
      }
      
      public function get target() : DisplayObject
      {
         return _target;
      }
      
      public function calibrate() : void
      {
         _scaleX = _target.scaleX;
         _scaleY = _target.scaleY;
         _angle = _target.angle * 0.0174532925199433;
         calibrateRegistration();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         var a:Array = _dict[_target];
         for(i = a.length - 1; i > -1; )
         {
            if(a[i] == this)
            {
               a.splice(i,1);
            }
            i--;
         }
         if(a.length == 0)
         {
            delete _dict[_target];
         }
         _target = null;
         _localRegistration = null;
         _registration = null;
         _proxies = null;
      }
      
      override flash_proxy function callProperty(name:*, ... args) : *
      {
         return _target[name].apply(null,args);
      }
      
      override flash_proxy function getProperty(prop:*) : *
      {
         return _target[prop];
      }
      
      override flash_proxy function setProperty(prop:*, value:*) : void
      {
         _target[prop] = value;
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         if(_target.hasOwnProperty(name))
         {
            return true;
         }
         if(_addedProps.indexOf(" " + name + " ") != -1)
         {
            return true;
         }
         return false;
      }
      
      public function moveRegX(n:Number) : void
      {
         _registration.x = _registration.x + n;
      }
      
      public function moveRegY(n:Number) : void
      {
         _registration.y = _registration.y + n;
      }
      
      private function reposition() : void
      {
         var p:Point = _target.parent.globalToLocal(_target.localToGlobal(_localRegistration));
         _target.x = _target.x + (_registration.x - p.x);
         _target.y = _target.y + (_registration.y - p.y);
      }
      
      private function updateSiblingProxies() : void
      {
         var i:int = 0;
         for(i = _proxies.length - 1; i > -1; )
         {
            if(_proxies[i] != this)
            {
               _proxies[i].onSiblingUpdate(_scaleX,_scaleY,_angle);
            }
            i--;
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
      
      public function onSiblingUpdate(scaleX:Number, scaleY:Number, angle:Number) : void
      {
         _scaleX = scaleX;
         _scaleY = scaleY;
         _angle = angle;
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
      
      public function set localRegistration(p:Point) : void
      {
         _localRegistration = p;
         calibrateRegistration();
      }
      
      public function get localRegistrationX() : Number
      {
         return _localRegistration.x;
      }
      
      public function set localRegistrationX(n:Number) : void
      {
         _localRegistration.x = n;
         calibrateRegistration();
      }
      
      public function get localRegistrationY() : Number
      {
         return _localRegistration.y;
      }
      
      public function set localRegistrationY(n:Number) : void
      {
         _localRegistration.y = n;
         calibrateRegistration();
      }
      
      public function get registration() : Point
      {
         return _registration;
      }
      
      public function set registration(p:Point) : void
      {
         _registration = p;
         calibrateLocal();
      }
      
      public function get registrationX() : Number
      {
         return _registration.x;
      }
      
      public function set registrationX(n:Number) : void
      {
         _registration.x = n;
         calibrateLocal();
      }
      
      public function get registrationY() : Number
      {
         return _registration.y;
      }
      
      public function set registrationY(n:Number) : void
      {
         _registration.y = n;
         calibrateLocal();
      }
      
      public function get x() : Number
      {
         return _registration.x;
      }
      
      public function set x(n:Number) : void
      {
         var i:int = 0;
         var tx:Number = n - _registration.x;
         _target.x = _target.x + tx;
         for(i = _proxies.length - 1; i > -1; )
         {
            if(_proxies[i] == this || !_proxies[i].ignoreSiblingUpdates)
            {
               _proxies[i].moveRegX(tx);
            }
            i--;
         }
      }
      
      public function get y() : Number
      {
         return _registration.y;
      }
      
      public function set y(n:Number) : void
      {
         var i:int = 0;
         var ty:Number = n - _registration.y;
         _target.y = _target.y + ty;
         for(i = _proxies.length - 1; i > -1; )
         {
            if(_proxies[i] == this || !_proxies[i].ignoreSiblingUpdates)
            {
               _proxies[i].moveRegY(ty);
            }
            i--;
         }
      }
      
      public function get rotation() : Number
      {
         return _angle * 57.2957795130823;
      }
      
      public function set rotation(n:Number) : void
      {
         var radians:Number = n * 0.0174532925199433;
         var m:Matrix = _target.transformationMatrix;
         m.rotate(radians - _angle);
         _target.transformationMatrix = m;
         _angle = radians;
         reposition();
         if(_proxies.length > 1)
         {
            updateSiblingProxies();
         }
      }
      
      public function get skewX() : Number
      {
         var m:Matrix = _target.transformationMatrix;
         return (Math.atan2(-m.c,m.d) - _angle) * 57.2957795130823;
      }
      
      public function set skewX(n:Number) : void
      {
         var radians:Number = n * 0.0174532925199433;
         var m:Matrix = _target.transformationMatrix;
         var sy:Number = _scaleY < 0?-_scaleY:Number(_scaleY);
         m.c = -sy * Math.sin(radians + _angle);
         m.d = sy * Math.cos(radians + _angle);
         _target.transformationMatrix = m;
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
         var m:Matrix = _target.transformationMatrix;
         return (Math.atan2(m.b,m.a) - _angle) * 57.2957795130823;
      }
      
      public function set skewY(n:Number) : void
      {
         var radians:Number = n * 0.0174532925199433;
         var m:Matrix = _target.transformationMatrix;
         var sx:Number = _scaleX < 0?-_scaleX:Number(_scaleX);
         m.a = sx * Math.cos(radians + _angle);
         m.b = sx * Math.sin(radians + _angle);
         _target.transformationMatrix = m;
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
      
      public function set skewX2(n:Number) : void
      {
         this.skewX2Radians = n * 0.0174532925199433;
      }
      
      public function get skewY2() : Number
      {
         return this.skewY2Radians * 57.2957795130823;
      }
      
      public function set skewY2(n:Number) : void
      {
         this.skewY2Radians = n * 0.0174532925199433;
      }
      
      public function get skewX2Radians() : Number
      {
         return -Math.atan(_target.transformationMatrix.c);
      }
      
      public function set skewX2Radians(n:Number) : void
      {
         var m:Matrix = _target.transformationMatrix;
         m.c = Math.tan(-n);
         _target.transformationMatrix = m;
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
         return Math.atan(_target.transformationMatrix.b);
      }
      
      public function set skewY2Radians(n:Number) : void
      {
         var m:Matrix = _target.transformationMatrix;
         m.b = Math.tan(n);
         _target.transformationMatrix = m;
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
      
      public function set scaleX(n:Number) : void
      {
         if(n == 0)
         {
            n = 0.0001;
         }
         var m:Matrix = _target.transformationMatrix;
         m.rotate(-_angle);
         m.scale(n / _scaleX,1);
         m.rotate(_angle);
         _target.transformationMatrix = m;
         _scaleX = n;
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
      
      public function set scaleY(n:Number) : void
      {
         if(n == 0)
         {
            n = 0.0001;
         }
         var m:Matrix = _target.transformationMatrix;
         m.rotate(-_angle);
         m.scale(1,n / _scaleY);
         m.rotate(_angle);
         _target.transformationMatrix = m;
         _scaleY = n;
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
      
      public function set scale(n:Number) : void
      {
         if(n == 0)
         {
            n = 0.0001;
         }
         var m:Matrix = _target.transformationMatrix;
         m.rotate(-_angle);
         m.scale(n / _scaleX,n / _scaleY);
         m.rotate(_angle);
         _target.transformationMatrix = m;
         _scaleY = n;
         _scaleX = n;
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
      
      public function set alpha(n:Number) : void
      {
         _target.alpha = n;
      }
      
      public function get width() : Number
      {
         return _target.width;
      }
      
      public function set width(n:Number) : void
      {
         _target.width = n;
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
      
      public function set height(n:Number) : void
      {
         _target.height = n;
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
