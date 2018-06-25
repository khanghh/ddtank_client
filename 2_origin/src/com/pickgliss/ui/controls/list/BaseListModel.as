package com.pickgliss.ui.controls.list
{
   import com.pickgliss.utils.ArrayUtils;
   
   public class BaseListModel
   {
       
      
      private var listeners:Array;
      
      public function BaseListModel()
      {
         super();
         listeners = [];
      }
      
      public function addListDataListener(l:ListDataListener) : void
      {
         listeners.push(l);
      }
      
      public function removeListDataListener(l:ListDataListener) : void
      {
         ArrayUtils.removeFromArray(listeners,l);
      }
      
      protected function fireContentsChanged(target:Object, index0:int, index1:int, removedItems:Array) : void
      {
         var i:int = 0;
         var lis:* = null;
         var e:ListDataEvent = new ListDataEvent(target,index0,index1,removedItems);
         for(i = listeners.length - 1; i >= 0; )
         {
            lis = ListDataListener(listeners[i]);
            lis.contentsChanged(e);
            i--;
         }
      }
      
      protected function fireIntervalAdded(target:Object, index0:int, index1:int) : void
      {
         var i:int = 0;
         var lis:* = null;
         var e:ListDataEvent = new ListDataEvent(target,index0,index1,[]);
         for(i = listeners.length - 1; i >= 0; )
         {
            lis = ListDataListener(listeners[i]);
            lis.intervalAdded(e);
            i--;
         }
      }
      
      protected function fireIntervalRemoved(target:Object, index0:int, index1:int, removedItems:Array) : void
      {
         var i:int = 0;
         var lis:* = null;
         var e:ListDataEvent = new ListDataEvent(target,index0,index1,removedItems);
         for(i = listeners.length - 1; i >= 0; )
         {
            lis = ListDataListener(listeners[i]);
            lis.intervalRemoved(e);
            i--;
         }
      }
   }
}
