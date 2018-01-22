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
      
      public function BoundedRangeModel(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 100)
      {
         super();
         isAdjusting = false;
         if(param4 >= param3 && param1 >= param3 && param1 + param2 >= param1 && param1 + param2 <= param4)
         {
            this.value = param1;
            this.extent = param2;
            this.min = param3;
            this.max = param4;
            return;
         }
         throw new RangeError("invalid range properties");
      }
      
      public function getValue() : int
      {
         return value;
      }
      
      public function getExtent() : int
      {
         return extent;
      }
      
      public function getMinimum() : int
      {
         return min;
      }
      
      public function getMaximum() : int
      {
         return max;
      }
      
      public function setValue(param1:int) : void
      {
         param1 = Math.min(param1,max - extent);
         var _loc2_:int = Math.max(param1,min);
         setRangeProperties(_loc2_,extent,min,max,isAdjusting);
      }
      
      public function setExtent(param1:int) : void
      {
         var _loc2_:int = Math.max(0,param1);
         if(value + _loc2_ > max)
         {
            _loc2_ = max - value;
         }
         setRangeProperties(value,_loc2_,min,max,isAdjusting);
      }
      
      public function setMinimum(param1:int) : void
      {
         var _loc3_:int = Math.max(param1,max);
         var _loc2_:int = Math.max(param1,value);
         var _loc4_:int = Math.min(_loc3_ - _loc2_,extent);
         setRangeProperties(_loc2_,_loc4_,param1,_loc3_,isAdjusting);
      }
      
      public function setMaximum(param1:int) : void
      {
         var _loc3_:int = Math.min(param1,min);
         var _loc4_:int = Math.min(param1 - _loc3_,extent);
         var _loc2_:int = Math.min(param1 - _loc4_,value);
         setRangeProperties(_loc2_,_loc4_,_loc3_,param1,isAdjusting);
      }
      
      public function setValueIsAdjusting(param1:Boolean) : void
      {
         setRangeProperties(value,extent,min,max,param1);
      }
      
      public function getValueIsAdjusting() : Boolean
      {
         return isAdjusting;
      }
      
      public function setRangeProperties(param1:int, param2:int, param3:int, param4:int, param5:Boolean) : void
      {
         if(param3 > param4)
         {
            param3 = param4;
         }
         if(param1 > param4)
         {
            param4 = param1;
         }
         if(param1 < param3)
         {
            param3 = param1;
         }
         if(param2 + param1 > param4)
         {
            param2 = param4 - param1;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         var _loc6_:Boolean = param1 != value || param2 != extent || param3 != min || param4 != max || param5 != isAdjusting;
         if(_loc6_)
         {
            value = param1;
            extent = param2;
            min = param3;
            max = param4;
            isAdjusting = param5;
            fireStateChanged();
         }
      }
      
      public function addStateListener(param1:Function, param2:int = 0, param3:Boolean = false) : void
      {
         addEventListener("stateChange",param1,false,param2);
      }
      
      public function removeStateListener(param1:Function) : void
      {
         removeEventListener("stateChange",param1);
      }
      
      protected function fireStateChanged() : void
      {
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "value=" + getValue() + ", " + "extent=" + getExtent() + ", " + "min=" + getMinimum() + ", " + "max=" + getMaximum() + ", " + "adj=" + getValueIsAdjusting();
         return "BoundedRangeModel[" + _loc1_ + "]";
      }
   }
}
