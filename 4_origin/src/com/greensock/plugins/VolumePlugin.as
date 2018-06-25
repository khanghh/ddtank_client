package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.media.SoundTransform;
   
   public class VolumePlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _target:Object;
      
      protected var _st:SoundTransform;
      
      public function VolumePlugin()
      {
         super();
         this.propName = "volume";
         this.overwriteProps = ["volume"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         if(isNaN(value) || target.hasOwnProperty("volume") || !target.hasOwnProperty("soundTransform"))
         {
            return false;
         }
         _target = target;
         _st = _target.soundTransform;
         addTween(_st,"volume",_st.volume,value,"volume");
         return true;
      }
      
      override public function set changeFactor(n:Number) : void
      {
         updateTweens(n);
         _target.soundTransform = _st;
      }
   }
}
