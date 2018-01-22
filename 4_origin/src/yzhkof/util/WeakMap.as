package yzhkof.util
{
   import flash.utils.Dictionary;
   
   public class WeakMap
   {
       
      
      private var map:Dictionary;
      
      private var key_set:Array;
      
      private var _length:int = 0;
      
      public function WeakMap()
      {
         this.map = new Dictionary(true);
         this.key_set = new Array();
         super();
      }
      
      public function get length() : int
      {
         return this._length;
      }
      
      public function get keySet() : Array
      {
         return this.key_set;
      }
      
      public function get valueSet() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.map)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function contentValue(param1:*) : Boolean
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.map)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function contentKey(param1:*) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = this.keySet;
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function add(param1:*, param2:*) : void
      {
         var _loc3_:Array = null;
         if(this.contentKey(param1))
         {
            for each(_loc3_ in this.map)
            {
               _loc3_.splice(_loc3_.indexOf(param1),1);
            }
            this._length--;
         }
         if(this.contentValue(param2))
         {
            this.map[param2].push(param1);
         }
         else
         {
            this.map[param2] = [param1];
         }
         this._length++;
         if(this.key_set.indexOf(param1) < 0)
         {
            this.key_set.push(param1);
         }
      }
      
      public function getValue(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         for(_loc2_ in this.map)
         {
            _loc3_ = this.map[_loc2_];
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_ == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function remove(param1:*) : void
      {
         var _loc2_:* = this.getValue(param1);
         var _loc3_:Array = this.map[this.getValue(param1)];
         if(_loc3_)
         {
            _loc3_.splice(_loc3_.indexOf(param1),1);
            if(_loc3_.length <= 0)
            {
               delete this.map[_loc2_];
            }
            this._length--;
         }
         this.key_set.splice(this.key_set.indexOf(param1),1);
      }
   }
}
