package com.greensock.core
{
   public class SimpleTimeline extends TweenCore
   {
       
      
      protected var _firstChild:TweenCore;
      
      protected var _lastChild:TweenCore;
      
      public var autoRemoveChildren:Boolean;
      
      public function SimpleTimeline(param1:Object = null){super(null,null);}
      
      public function insert(param1:TweenCore, param2:* = 0) : TweenCore{return null;}
      
      public function remove(param1:TweenCore, param2:Boolean = false) : void{}
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void{}
      
      public function get rawTime() : Number{return 0;}
   }
}
