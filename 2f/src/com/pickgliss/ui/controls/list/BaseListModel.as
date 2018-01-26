package com.pickgliss.ui.controls.list
{
   import com.pickgliss.utils.ArrayUtils;
   
   public class BaseListModel
   {
       
      
      private var listeners:Array;
      
      public function BaseListModel(){super();}
      
      public function addListDataListener(param1:ListDataListener) : void{}
      
      public function removeListDataListener(param1:ListDataListener) : void{}
      
      protected function fireContentsChanged(param1:Object, param2:int, param3:int, param4:Array) : void{}
      
      protected function fireIntervalAdded(param1:Object, param2:int, param3:int) : void{}
      
      protected function fireIntervalRemoved(param1:Object, param2:int, param3:int, param4:Array) : void{}
   }
}
