package com.pickgliss.effect
{
   import flash.display.DisplayObject;
   
   public class BaseEffect implements IEffect
   {
       
      
      protected var _target:DisplayObject;
      
      private var _id:int;
      
      public function BaseEffect(param1:int){super();}
      
      public function dispose() : void{}
      
      public function get id() : int{return 0;}
      
      public function set id(param1:int) : void{}
      
      public function initEffect(param1:DisplayObject, param2:Array) : void{}
      
      public function play() : void{}
      
      public function stop() : void{}
      
      public function get target() : DisplayObject{return null;}
   }
}
