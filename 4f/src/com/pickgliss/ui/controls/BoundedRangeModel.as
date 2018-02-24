package com.pickgliss.ui.controls
{
   import com.pickgliss.events.InteractiveEvent;
   import flash.events.EventDispatcher;
   
   public class BoundedRangeModel extends EventDispatcher
   {
       
      
      private var value:int;
      
      private var extent:int;
      
      private var min:int;
      
      private var max:int;
      
      private var isAdjusting:Boolean;
      
      public function BoundedRangeModel(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 100){super();}
      
      public function getValue() : int{return 0;}
      
      public function getExtent() : int{return 0;}
      
      public function getMinimum() : int{return 0;}
      
      public function getMaximum() : int{return 0;}
      
      public function setValue(param1:int) : void{}
      
      public function setExtent(param1:int) : void{}
      
      public function setMinimum(param1:int) : void{}
      
      public function setMaximum(param1:int) : void{}
      
      public function setValueIsAdjusting(param1:Boolean) : void{}
      
      public function getValueIsAdjusting() : Boolean{return false;}
      
      public function setRangeProperties(param1:int, param2:int, param3:int, param4:int, param5:Boolean) : void{}
      
      public function addStateListener(param1:Function, param2:int = 0, param3:Boolean = false) : void{}
      
      public function removeStateListener(param1:Function) : void{}
      
      protected function fireStateChanged() : void{}
      
      override public function toString() : String{return null;}
   }
}
