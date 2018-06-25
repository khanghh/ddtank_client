package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class MotionBlurPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
      
      private static const _DEG2RAD:Number = 0.017453292519943295;
      
      private static const _RAD2DEG:Number = 57.29577951308232;
      
      private static const _point:Point = new Point(0,0);
      
      private static const _ct:ColorTransform = new ColorTransform();
      
      private static const _blankArray:Array = [];
      
      private static var _classInitted:Boolean;
      
      private static var _isFlex:Boolean;
       
      
      protected var _target:DisplayObject;
      
      protected var _time:Number;
      
      protected var _xCurrent:Number;
      
      protected var _yCurrent:Number;
      
      protected var _bd:BitmapData;
      
      protected var _bitmap:Bitmap;
      
      protected var _strength:Number = 0.05;
      
      protected var _tween:TweenLite;
      
      protected var _blur:BlurFilter;
      
      protected var _matrix:Matrix;
      
      protected var _sprite:Sprite;
      
      protected var _rect:Rectangle;
      
      protected var _angle:Number;
      
      protected var _alpha:Number;
      
      protected var _xRef:Number;
      
      protected var _yRef:Number;
      
      protected var _mask:DisplayObject;
      
      protected var _parentMask:DisplayObject;
      
      protected var _padding:int;
      
      protected var _bdCache:BitmapData;
      
      protected var _rectCache:Rectangle;
      
      protected var _cos:Number;
      
      protected var _sin:Number;
      
      protected var _smoothing:Boolean;
      
      protected var _xOffset:Number;
      
      protected var _yOffset:Number;
      
      protected var _cached:Boolean;
      
      protected var _fastMode:Boolean;
      
      public function MotionBlurPlugin()
      {
         _blur = new BlurFilter(0,0,2);
         _matrix = new Matrix();
         super();
         this.propName = "motionBlur";
         this.overwriteProps = ["motionBlur"];
         this.onComplete = disable;
         this.onDisable = onTweenDisable;
         this.priority = -2;
         this.activeDisable = true;
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         var x:Number = NaN;
         var y:Number = NaN;
         if(!(target is DisplayObject))
         {
            throw new Error("motionBlur tweens only work for DisplayObjects.");
         }
         if(value == false)
         {
            _strength = 0;
         }
         else if(typeof value == "object")
         {
            _strength = (value.strength || 1) * 0.05;
            _blur.quality = int(value.quality) || 2;
            _fastMode = value.fastMode == true;
         }
         if(!_classInitted)
         {
            try
            {
               _isFlex = Boolean(getDefinitionByName("mx.managers.SystemManager"));
            }
            catch(e:Error)
            {
               _isFlex = false;
            }
            _classInitted = true;
         }
         _target = target as DisplayObject;
         _tween = tween;
         _time = 0;
         _padding = "padding" in value?int(value.padding):10;
         _smoothing = _blur.quality > 1;
         _xRef = _target.x;
         _xCurrent = _target.x;
         _yRef = _target.y;
         _yCurrent = _target.y;
         _alpha = _target.alpha;
         if("x" in _tween.propTweenLookup && "y" in _tween.propTweenLookup && !_tween.propTweenLookup.x.isPlugin && !_tween.propTweenLookup.y.isPlugin)
         {
            _angle = 3.14159265358979 - Math.atan2(_tween.propTweenLookup.y.change,_tween.propTweenLookup.x.change);
         }
         else if(_tween.vars.x != null || _tween.vars.y != null)
         {
            x = _tween.vars.x || _target.x;
            y = _tween.vars.y || _target.y;
            _angle = 3.14159265358979 - Math.atan2(y - _target.y,x - _target.x);
         }
         else
         {
            _angle = 0;
         }
         _cos = Math.cos(_angle);
         _sin = Math.sin(_angle);
         _bd = new BitmapData(_target.width + _padding * 2,_target.height + _padding * 2,true,16777215);
         _bdCache = _bd.clone();
         _bitmap = new Bitmap(_bd);
         _bitmap.smoothing = _smoothing;
         _sprite = !!_isFlex?new getDefinitionByName("mx.core.UIComponent")():new Sprite();
         var _loc8_:Boolean = false;
         _sprite.mouseChildren = _loc8_;
         _sprite.mouseEnabled = _loc8_;
         _sprite.addChild(_bitmap);
         _rectCache = new Rectangle(0,0,_bd.width,_bd.height);
         _rect = _rectCache.clone();
         if(_target.mask)
         {
            _mask = _target.mask;
         }
         if(_target.parent && _target.parent.mask)
         {
            _parentMask = _target.parent.mask;
         }
         return true;
      }
      
      private function disable() : void
      {
         if(_strength != 0)
         {
            _target.alpha = _alpha;
         }
         if(_sprite.parent)
         {
            if(_isFlex && _sprite.parent.hasOwnProperty("removeElement"))
            {
               (_sprite.parent as Object).removeElement(_sprite);
            }
            else
            {
               _sprite.parent.removeChild(_sprite);
            }
         }
         if(_mask)
         {
            _target.mask = _mask;
         }
      }
      
      private function onTweenDisable() : void
      {
         if(_tween.cachedTime != _tween.cachedDuration && _tween.cachedTime != 0)
         {
            disable();
         }
      }
      
      override public function set changeFactor(n:Number) : void
      {
         var parentFilters:* = null;
         var prevVisible:Boolean = false;
         var bounds:* = null;
         var height:Number = NaN;
         var val:Number = NaN;
         var width:Number = NaN;
         var time:Number = _tween.cachedTime - _time;
         if(time < 0)
         {
            time = -time;
         }
         if(time < 1.0e-7)
         {
            return;
         }
         var dx:Number = _target.x - _xCurrent;
         var dy:Number = _target.y - _yCurrent;
         var rx:Number = _target.x - _xRef;
         var ry:Number = _target.y - _yRef;
         _changeFactor = n;
         if(rx > 2 || ry > 2 || rx < -2 || ry < -2)
         {
            _angle = 3.14159265358979 - Math.atan2(ry,rx);
            _cos = Math.cos(_angle);
            _sin = Math.sin(_angle);
            _xRef = _target.x;
            _yRef = _target.y;
         }
         _blur.blurX = Math.sqrt(dx * dx + dy * dy) * _strength / time;
         _xCurrent = _target.x;
         _yCurrent = _target.y;
         _time = _tween.cachedTime;
         if(n == 0 || _target.parent == null)
         {
            disable();
            return;
         }
         if(_sprite.parent != _target.parent && _target.parent)
         {
            if(_isFlex && _target.parent.hasOwnProperty("addElement"))
            {
               (_target.parent as Object).addElementAt(_sprite,(_target.parent as Object).getElementIndex(_target));
            }
            else
            {
               _target.parent.addChildAt(_sprite,_target.parent.getChildIndex(_target));
            }
            if(_mask)
            {
               _sprite.mask = _mask;
            }
         }
         if(!_fastMode || !_cached)
         {
            parentFilters = _target.parent.filters;
            if(parentFilters.length != 0)
            {
               _target.parent.filters = _blankArray;
            }
            var _loc13_:* = 20000;
            _target.y = _loc13_;
            _target.x = _loc13_;
            prevVisible = _target.visible;
            _target.visible = true;
            bounds = _target.getBounds(_target.parent);
            if(bounds.width + _blur.blurX * 2 > 2870)
            {
               _blur.blurX = bounds.width >= 2870?0:Number((2870 - bounds.width) * 0.5);
            }
            _xOffset = 20000 - bounds.x + _padding;
            _yOffset = 20000 - bounds.y + _padding;
            bounds.width = bounds.width + _padding * 2;
            bounds.height = bounds.height + _padding * 2;
            if(bounds.height > _bdCache.height || bounds.width > _bdCache.width)
            {
               _bdCache = new BitmapData(bounds.width,bounds.height,true,16777215);
               _rectCache = new Rectangle(0,0,_bdCache.width,_bdCache.height);
            }
            _matrix.tx = _padding - bounds.x;
            _matrix.ty = _padding - bounds.y;
            _loc13_ = 1;
            _matrix.d = _loc13_;
            _matrix.a = _loc13_;
            _loc13_ = 0;
            _matrix.c = _loc13_;
            _matrix.b = _loc13_;
            _loc13_ = 0;
            bounds.y = _loc13_;
            bounds.x = _loc13_;
            if(_target.alpha == 0.00390625)
            {
               _target.alpha = _alpha;
            }
            else
            {
               _alpha = _target.alpha;
            }
            if(_parentMask)
            {
               _target.parent.mask = null;
            }
            _bdCache.fillRect(_rectCache,16777215);
            _bdCache.draw(_target.parent,_matrix,_ct,"normal",bounds,_smoothing);
            if(_parentMask)
            {
               _target.parent.mask = _parentMask;
            }
            _target.visible = prevVisible;
            _target.x = _xCurrent;
            _target.y = _yCurrent;
            if(parentFilters.length != 0)
            {
               _target.parent.filters = parentFilters;
            }
            _cached = true;
         }
         else if(_target.alpha != 0.00390625)
         {
            _alpha = _target.alpha;
         }
         _target.alpha = 0.00390625;
         _loc13_ = 0;
         _matrix.ty = _loc13_;
         _matrix.tx = _loc13_;
         _matrix.a = _cos;
         _matrix.b = _sin;
         _matrix.c = -_sin;
         _matrix.d = _cos;
         width = _matrix.a * _bdCache.width;
         if(_matrix.a * _bdCache.width < 0)
         {
            _matrix.tx = -width;
            width = -width;
         }
         val = _matrix.c * _bdCache.height;
         if(_matrix.c * _bdCache.height < 0)
         {
            _matrix.tx = _matrix.tx - val;
            width = width - val;
         }
         else
         {
            width = width + val;
         }
         height = _matrix.d * _bdCache.height;
         if(_matrix.d * _bdCache.height < 0)
         {
            _matrix.ty = -height;
            height = -height;
         }
         val = _matrix.b * _bdCache.width;
         if(_matrix.b * _bdCache.width < 0)
         {
            _matrix.ty = _matrix.ty - val;
            height = height - val;
         }
         else
         {
            height = height + val;
         }
         width = width + _blur.blurX * 2;
         _matrix.tx = _matrix.tx + _blur.blurX;
         if(width > _bd.width || height > _bd.height)
         {
            _loc13_ = new BitmapData(width,height,true,16777215);
            _bitmap.bitmapData = _loc13_;
            _bd = _loc13_;
            _rect = new Rectangle(0,0,_bd.width,_bd.height);
            _bitmap.smoothing = _smoothing;
         }
         _bd.fillRect(_rect,16777215);
         _bd.draw(_bdCache,_matrix,_ct,"normal",_rect,_smoothing);
         _bd.applyFilter(_bd,_rect,_point,_blur);
         _bitmap.x = 0 - (_matrix.a * _xOffset + _matrix.c * _yOffset + _matrix.tx);
         _bitmap.y = 0 - (_matrix.d * _yOffset + _matrix.b * _xOffset + _matrix.ty);
         _matrix.b = -_sin;
         _matrix.c = _sin;
         _matrix.tx = _xCurrent;
         _matrix.ty = _yCurrent;
         _sprite.transform.matrix = _matrix;
      }
   }
}
