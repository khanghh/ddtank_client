package com.pickgliss.effect
{
   import flash.display.DisplayObject;
   
   public class BaseEffect implements IEffect
   {
       
      
      protected var _target:DisplayObject;
      
      private var _id:int;
      
      public function BaseEffect($id:int)
      {
         super();
         _id = $id;
      }
      
      public function dispose() : void
      {
         _target = null;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id($id:int) : void
      {
         _id = $id;
      }
      
      public function initEffect(target:DisplayObject, data:Array) : void
      {
         _target = target;
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
