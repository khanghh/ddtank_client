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
      
      public function addListDataListener(param1:ListDataListener) : void
      {
         listeners.push(param1);
      }
      
      public function removeListDataListener(param1:ListDataListener) : void
      {
         ArrayUtils.removeFromArray(listeners,param1);
      }
      
      protected function fireContentsChanged(param1:Object, param2:int, param3:int, param4:Array) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc6_:ListDataEvent = new ListDataEvent(param1,param2,param3,param4);
         _loc7_ = listeners.length - 1;
         while(_loc7_ >= 0)
         {
            _loc5_ = ListDataListener(listeners[_loc7_]);
            _loc5_.contentsChanged(_loc6_);
            _loc7_--;
         }
      }
      
      protected function fireIntervalAdded(param1:Object, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:ListDataEvent = new ListDataEvent(param1,param2,param3,[]);
         _loc6_ = listeners.length - 1;
         while(_loc6_ >= 0)
         {
            _loc4_ = ListDataListener(listeners[_loc6_]);
            _loc4_.intervalAdded(_loc5_);
            _loc6_--;
         }
      }
      
      protected function fireIntervalRemoved(param1:Object, param2:int, param3:int, param4:Array) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc6_:ListDataEvent = new ListDataEvent(param1,param2,param3,param4);
         _loc7_ = listeners.length - 1;
         while(_loc7_ >= 0)
         {
            _loc5_ = ListDataListener(listeners[_loc7_]);
            _loc5_.intervalRemoved(_loc6_);
            _loc7_--;
         }
      }
   }
}
