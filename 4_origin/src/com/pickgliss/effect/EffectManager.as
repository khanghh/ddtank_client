package com.pickgliss.effect
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public final class EffectManager
   {
      
      private static var _instance:EffectManager;
       
      
      private var _effects:Dictionary;
      
      private var _effectIDCounter:int = 0;
      
      public function EffectManager()
      {
         super();
         _effects = new Dictionary();
      }
      
      public static function get Instance() : EffectManager
      {
         if(_instance == null)
         {
            _instance = new EffectManager();
         }
         return _instance;
      }
      
      public function getEffectID() : int
      {
         _effectIDCounter = Number(_effectIDCounter) + 1;
         return Number(_effectIDCounter);
      }
      
      public function creatEffect(param1:int, param2:DisplayObject, ... rest) : IEffect
      {
         var _loc4_:IEffect = creatEffectByEffectType(param1);
         _loc4_.initEffect(param2,rest);
         _effects[_loc4_.id] = _loc4_;
         return _loc4_;
      }
      
      public function getEffectByTarget(param1:DisplayObject) : IEffect
      {
         var _loc4_:int = 0;
         var _loc3_:* = _effects;
         for each(var _loc2_ in _effects)
         {
            if(param1 == _loc2_.target)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function removeEffect(param1:IEffect) : void
      {
         param1.dispose();
      }
      
      public function creatEffectByEffectType(param1:int) : IEffect
      {
         var _loc2_:* = null;
         switch(int(param1) - 1)
         {
            case 0:
               _loc2_ = new AddMovieEffect(getEffectID());
               break;
            case 1:
               _loc2_ = new ShinerAnimation(getEffectID());
               break;
            case 2:
               _loc2_ = new AlphaShinerAnimation(getEffectID());
               break;
            case 3:
               _loc2_ = new LinearShinerAnimation(getEffectID());
         }
         return _loc2_;
      }
   }
}
