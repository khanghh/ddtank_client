package com.pickgliss.ui.controls.list
{
   import com.pickgliss.events.ModelEvent;
   
   public class ListDataEvent extends ModelEvent
   {
       
      
      private var index0:int;
      
      private var index1:int;
      
      private var removedItems:Array;
      
      public function ListDataEvent(source:Object, index0:int, index1:int, removedItems:Array)
      {
         super(source);
         this.index0 = index0;
         this.index1 = index1;
         this.removedItems = removedItems.concat();
      }
      
      public function getIndex0() : int
      {
         return index0;
      }
      
      public function getIndex1() : int
      {
         return index1;
      }
      
      public function getRemovedItems() : Array
      {
         return removedItems.concat();
      }
   }
}
