package com.pickgliss.effect{   import flash.display.DisplayObject;      public class BaseEffect implements IEffect   {                   protected var _target:DisplayObject;            private var _id:int;            public function BaseEffect($id:int) { super(); }
            public function dispose() : void { }
            public function get id() : int { return 0; }
            public function set id($id:int) : void { }
            public function initEffect(target:DisplayObject, data:Array) : void { }
            public function play() : void { }
            public function stop() : void { }
            public function get target() : DisplayObject { return null; }
   }}