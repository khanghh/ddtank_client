package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class ShortRotationPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      public function ShortRotationPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      public function initRotation(param1:Object, param2:String, param3:Number, param4:Number) : void{}
   }
}
