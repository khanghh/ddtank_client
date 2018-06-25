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
         var i:* = undefined;
         var re_arr:Array = new Array();
         for(i in this.map)
         {
            re_arr.push(i);
         }
         return re_arr;
      }
      
      public function contentValue(value:*) : Boolean
      {
         var i:* = undefined;
         for(i in this.map)
         {
            if(i == value)
            {
               return true;
            }
         }
         return false;
      }
      
      public function contentKey(key:*) : Boolean
      {
         var i:* = undefined;
         var key_arr:Array = this.keySet;
         for each(i in key_arr)
         {
            if(i == key)
            {
               return true;
            }
         }
         return false;
      }
      
      public function add(key:*, value:*) : void
      {
         var i:Array = null;
         if(this.contentKey(key))
         {
            for each(i in this.map)
            {
               i.splice(i.indexOf(key),1);
            }
            this._length--;
         }
         if(this.contentValue(value))
         {
            this.map[value].push(key);
         }
         else
         {
            this.map[value] = [key];
         }
         this._length++;
         if(this.key_set.indexOf(key) < 0)
         {
            this.key_set.push(key);
         }
      }
      
      public function getValue(key:*) : *
      {
         var i:* = undefined;
         var key_arr:Array = null;
         var k:* = undefined;
         for(i in this.map)
         {
            key_arr = this.map[i];
            for each(k in key_arr)
            {
               if(k == key)
               {
                  return i;
               }
            }
         }
         return null;
      }
      
      public function remove(key:*) : void
      {
         var value:* = this.getValue(key);
         var key_arr:Array = this.map[this.getValue(key)];
         if(key_arr)
         {
            key_arr.splice(key_arr.indexOf(key),1);
            if(key_arr.length <= 0)
            {
               delete this.map[value];
            }
            this._length--;
         }
         this.key_set.splice(this.key_set.indexOf(key),1);
      }
   }
}
