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
      
      public function creatEffect(type:int, target:DisplayObject, ... args) : IEffect
      {
         var effect:IEffect = creatEffectByEffectType(type);
         effect.initEffect(target,args);
         _effects[effect.id] = effect;
         return effect;
      }
      
      public function getEffectByTarget($target:DisplayObject) : IEffect
      {
         var _loc4_:int = 0;
         var _loc3_:* = _effects;
         for each(var effect in _effects)
         {
            if($target == effect.target)
            {
               return effect;
            }
         }
         return null;
      }
      
      public function removeEffect(effect:IEffect) : void
      {
         effect.dispose();
      }
      
      public function creatEffectByEffectType(type:int) : IEffect
      {
         var effect:* = null;
         switch(int(type) - 1)
         {
            case 0:
               effect = new AddMovieEffect(getEffectID());
               break;
            case 1:
               effect = new ShinerAnimation(getEffectID());
               break;
            case 2:
               effect = new AlphaShinerAnimation(getEffectID());
               break;
            case 3:
               effect = new LinearShinerAnimation(getEffectID());
         }
         return effect;
      }
   }
}
