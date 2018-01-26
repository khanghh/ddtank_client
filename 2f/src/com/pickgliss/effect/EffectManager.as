package com.pickgliss.effect
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public final class EffectManager
   {
      
      private static var _instance:EffectManager;
       
      
      private var _effects:Dictionary;
      
      private var _effectIDCounter:int = 0;
      
      public function EffectManager(){super();}
      
      public static function get Instance() : EffectManager{return null;}
      
      public function getEffectID() : int{return 0;}
      
      public function creatEffect(param1:int, param2:DisplayObject, ... rest) : IEffect{return null;}
      
      public function getEffectByTarget(param1:DisplayObject) : IEffect{return null;}
      
      public function removeEffect(param1:IEffect) : void{}
      
      public function creatEffectByEffectType(param1:int) : IEffect{return null;}
   }
}
