package org.aswing.util
{
   public class ASWingVector implements List
   {
      
      public static const CASEINSENSITIVE:int = 1;
      
      public static const DESCENDING:int = 2;
      
      public static const UNIQUESORT:int = 4;
      
      public static const RETURNINDEXEDARRAY:int = 8;
      
      public static const NUMERIC:int = 16;
       
      
      protected var _elements:Array;
      
      public function ASWingVector()
      {
         super();
         _elements = [];
      }
      
      public function each(param1:Function) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _elements.length)
         {
            param1(_elements[_loc2_]);
            _loc2_++;
         }
      }
      
      public function eachWithout(param1:Object, param2:Function) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _elements.length)
         {
            if(_elements[_loc3_] != param1)
            {
               param2(_elements[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      public function get(param1:int) : *
      {
         return _elements[param1];
      }
      
      public function elementAt(param1:int) : *
      {
         return get(param1);
      }
      
      public function append(param1:*, param2:int = -1) : void
      {
         if(param2 == -1)
         {
            _elements.push(param1);
         }
         else
         {
            _elements.splice(param2,0,param1);
         }
      }
      
      public function appendAll(param1:Array, param2:int = -1) : void
      {
         var _loc3_:* = null;
         if(param1 == null || param1.length <= 0)
         {
            return;
         }
         if(param2 == -1 || param2 == _elements.length)
         {
            _elements = _elements.concat(param1);
         }
         else if(param2 == 0)
         {
            _elements = param1.concat(_elements);
         }
         else
         {
            _loc3_ = _elements.splice(param2);
            _elements = _elements.concat(param1);
            _elements = _elements.concat(_loc3_);
         }
      }
      
      public function replaceAt(param1:int, param2:*) : *
      {
         var _loc3_:* = null;
         if(param1 < 0 || param1 >= size())
         {
            return null;
         }
         _loc3_ = _elements[param1];
         _elements[param1] = param2;
         return _loc3_;
      }
      
      public function removeAt(param1:int) : *
      {
         var _loc2_:* = null;
         if(param1 < 0 || param1 >= size())
         {
            return null;
         }
         _loc2_ = _elements[param1];
         _elements.splice(param1,1);
         return _loc2_;
      }
      
      public function remove(param1:*) : *
      {
         var _loc2_:int = indexOf(param1);
         if(_loc2_ >= 0)
         {
            return removeAt(_loc2_);
         }
         return null;
      }
      
      public function removeRange(param1:int, param2:int) : Array
      {
         param1 = Math.max(0,param1);
         param2 = Math.min(param2,_elements.length - 1);
         if(param1 > param2)
         {
            return [];
         }
         return _elements.splice(param1,param2 - param1 + 1);
      }
      
      public function indexOf(param1:*) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _elements.length)
         {
            if(_elements[_loc2_] === param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function appendList(param1:List, param2:int = -1) : void
      {
         appendAll(param1.toArray(),param2);
      }
      
      public function pop() : *
      {
         if(size() > 0)
         {
            return _elements.pop();
         }
         return null;
      }
      
      public function shift() : *
      {
         if(size() > 0)
         {
            return _elements.shift();
         }
         return undefined;
      }
      
      public function lastIndexOf(param1:*) : int
      {
         var _loc2_:int = 0;
         _loc2_ = _elements.length - 1;
         while(_loc2_ >= 0)
         {
            if(_elements[_loc2_] === param1)
            {
               return _loc2_;
            }
            _loc2_--;
         }
         return -1;
      }
      
      public function contains(param1:*) : Boolean
      {
         return indexOf(param1) >= 0;
      }
      
      public function first() : *
      {
         return _elements[0];
      }
      
      public function last() : *
      {
         return _elements[_elements.length - 1];
      }
      
      public function size() : int
      {
         return _elements.length;
      }
      
      public function setElementAt(param1:int, param2:*) : void
      {
         replaceAt(param1,param2);
      }
      
      public function getSize() : int
      {
         return size();
      }
      
      public function clear() : void
      {
         if(!isEmpty())
         {
            _elements.splice(0);
            _elements = [];
         }
      }
      
      public function clone() : ASWingVector
      {
         var _loc2_:int = 0;
         var _loc1_:ASWingVector = new ASWingVector();
         _loc2_ = 0;
         while(_loc2_ < _elements.length)
         {
            _loc1_.append(_elements[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function isEmpty() : Boolean
      {
         if(_elements.length > 0)
         {
            return false;
         }
         return true;
      }
      
      public function toArray() : Array
      {
         return _elements.concat();
      }
      
      public function subArray(param1:int, param2:int) : Array
      {
         return _elements.slice(param1,Math.min(param1 + param2,size()));
      }
      
      public function sort(param1:Object, param2:int) : Array
      {
         return _elements.sort(param1,param2);
      }
      
      public function sortOn(param1:Object, param2:int) : Array
      {
         return _elements.sortOn(param1,param2);
      }
      
      public function toString() : String
      {
         return "Vector : " + _elements.toString();
      }
   }
}
