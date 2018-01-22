package com.pickgliss.effect
{
   import flash.display.DisplayObject;
   
   public class BaseEffect implements IEffect
   {
       
      
      protected var _target:DisplayObject;
      
      private var _id:int;
      
      public function BaseEffect(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function dispose() : void
      {
         _target = null;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function initEffect(param1:DisplayObject, param2:Array) : void
      {
         _target = param1;
      }
      
      public function play() : void
      {
      }
      
      public function stop() : void
      {
      }
      
      public function get target() : DisplayObject
      {
         return _target;
      }
   }
}
