package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class AutoAlphaPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _target:Object;
      
      protected var _ignoreVisible:Boolean;
      
      public function AutoAlphaPlugin()
      {
         super();
         this.propName = "autoAlpha";
         this.overwriteProps = ["alpha","visible"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         _target = target;
         addTween(target,"alpha",target.alpha,value,"alpha");
         return true;
      }
      
      override public function killProps(lookup:Object) : void
      {
         super.killProps(lookup);
         _ignoreVisible = "visible" in lookup;
      }
      
      override public function set changeFactor(n:Number) : void
      {
         updateTweens(n);
         if(!_ignoreVisible)
         {
            _target.visible = _target.alpha != 0;
         }
      }
   }
}
