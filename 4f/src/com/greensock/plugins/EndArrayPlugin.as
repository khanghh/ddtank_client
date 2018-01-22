package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class EndArrayPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _a:Array;
      
      protected var _info:Array;
      
      public function EndArrayPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      public function init(param1:Array, param2:Array) : void{}
      
      override public function set changeFactor(param1:Number) : void{}
   }
}

class ArrayTweenInfo
{
    
   
   public var index:uint;
   
   public var start:Number;
   
   public var change:Number;
   
   function ArrayTweenInfo(param1:uint, param2:Number, param3:Number){super();}
}
