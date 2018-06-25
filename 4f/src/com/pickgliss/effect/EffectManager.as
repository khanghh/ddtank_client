package com.pickgliss.effect{   import flash.display.DisplayObject;   import flash.utils.Dictionary;      public final class EffectManager   {            private static var _instance:EffectManager;                   private var _effects:Dictionary;            private var _effectIDCounter:int = 0;            public function EffectManager() { super(); }
            public static function get Instance() : EffectManager { return null; }
            public function getEffectID() : int { return 0; }
            public function creatEffect(type:int, target:DisplayObject, ... args) : IEffect { return null; }
            public function getEffectByTarget($target:DisplayObject) : IEffect { return null; }
            public function removeEffect(effect:IEffect) : void { }
            public function creatEffectByEffectType(type:int) : IEffect { return null; }
   }}