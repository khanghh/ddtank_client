package com.pickgliss.ui.controls.list
{
   import com.pickgliss.events.ModelEvent;
   
   public class ListDataEvent extends ModelEvent
   {
       
      
      private var index0:int;
      
      private var index1:int;
      
      private var removedItems:Array;
      
      public function ListDataEvent(param1:Object, param2:int, param3:int, param4:Array){super(null);}
      
      public function getIndex0() : int{return 0;}
      
      public function getIndex1() : int{return 0;}
      
      public function getRemovedItems() : Array{return null;}
   }
}
