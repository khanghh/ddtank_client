package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Transform;
   
   public class TintPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
      
      protected static var _props:Array = ["redMultiplier","greenMultiplier","blueMultiplier","alphaMultiplier","redOffset","greenOffset","blueOffset","alphaOffset"];
       
      
      protected var _transform:Transform;
      
      protected var _ct:ColorTransform;
      
      protected var _ignoreAlpha:Boolean;
      
      public function TintPlugin()
      {
         super();
         this.propName = "tint";
         this.overwriteProps = ["tint"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         if(!(target is DisplayObject))
         {
            return false;
         }
         var end:ColorTransform = new ColorTransform();
         if(value != null && tween.vars.removeTint != true)
         {
            end.color = uint(value);
         }
         _ignoreAlpha = true;
         init(target as DisplayObject,end);
         return true;
      }
      
      public function init(target:DisplayObject, end:ColorTransform) : void
      {
         var p:* = null;
         _transform = target.transform;
         _ct = _transform.colorTransform;
         var i:int = _props.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            p = _props[i];
            if(_ct[p] != end[p])
            {
               _tweens[_tweens.length] = new PropTween(_ct,p,_ct[p],end[p] - _ct[p],"tint",false);
            }
         }
      }
      
      override public function set changeFactor(n:Number) : void
      {
         var ct:* = null;
         updateTweens(n);
         if(_ignoreAlpha)
         {
            ct = _transform.colorTransform;
            _ct.alphaMultiplier = ct.alphaMultiplier;
            _ct.alphaOffset = ct.alphaOffset;
         }
         _transform.colorTransform = _ct;
      }
   }
}
