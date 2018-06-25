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
      
      public function each(operation:Function) : void
      {
         var i:int = 0;
         for(i = 0; i < _elements.length; )
         {
            operation(_elements[i]);
            i++;
         }
      }
      
      public function eachWithout(obj:Object, operation:Function) : void
      {
         var i:int = 0;
         for(i = 0; i < _elements.length; )
         {
            if(_elements[i] != obj)
            {
               operation(_elements[i]);
            }
            i++;
         }
      }
      
      public function get(i:int) : *
      {
         return _elements[i];
      }
      
      public function elementAt(i:int) : *
      {
         return get(i);
      }
      
      public function append(obj:*, index:int = -1) : void
      {
         if(index == -1)
         {
            _elements.push(obj);
         }
         else
         {
            _elements.splice(index,0,obj);
         }
      }
      
      public function appendAll(arr:Array, index:int = -1) : void
      {
         var right:* = null;
         if(arr == null || arr.length <= 0)
         {
            return;
         }
         if(index == -1 || index == _elements.length)
         {
            _elements = _elements.concat(arr);
         }
         else if(index == 0)
         {
            _elements = arr.concat(_elements);
         }
         else
         {
            right = _elements.splice(index);
            _elements = _elements.concat(arr);
            _elements = _elements.concat(right);
         }
      }
      
      public function replaceAt(index:int, obj:*) : *
      {
         var oldObj:* = null;
         if(index < 0 || index >= size())
         {
            return null;
         }
         oldObj = _elements[index];
         _elements[index] = obj;
         return oldObj;
      }
      
      public function removeAt(index:int) : *
      {
         var obj:* = null;
         if(index < 0 || index >= size())
         {
            return null;
         }
         obj = _elements[index];
         _elements.splice(index,1);
         return obj;
      }
      
      public function remove(obj:*) : *
      {
         var i:int = indexOf(obj);
         if(i >= 0)
         {
            return removeAt(i);
         }
         return null;
      }
      
      public function removeRange(fromIndex:int, toIndex:int) : Array
      {
         fromIndex = Math.max(0,fromIndex);
         toIndex = Math.min(toIndex,_elements.length - 1);
         if(fromIndex > toIndex)
         {
            return [];
         }
         return _elements.splice(fromIndex,toIndex - fromIndex + 1);
      }
      
      public function indexOf(obj:*) : int
      {
         var i:int = 0;
         for(i = 0; i < _elements.length; )
         {
            if(_elements[i] === obj)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function appendList(list:List, index:int = -1) : void
      {
         appendAll(list.toArray(),index);
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
      
      public function lastIndexOf(obj:*) : int
      {
         var i:int = 0;
         for(i = _elements.length - 1; i >= 0; )
         {
            if(_elements[i] === obj)
            {
               return i;
            }
            i--;
         }
         return -1;
      }
      
      public function contains(obj:*) : Boolean
      {
         return indexOf(obj) >= 0;
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
      
      public function setElementAt(index:int, element:*) : void
      {
         replaceAt(index,element);
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
         var i:int = 0;
         var cloned:ASWingVector = new ASWingVector();
         for(i = 0; i < _elements.length; )
         {
            cloned.append(_elements[i]);
            i++;
         }
         return cloned;
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
      
      public function subArray(startIndex:int, length:int) : Array
      {
         return _elements.slice(startIndex,Math.min(startIndex + length,size()));
      }
      
      public function sort(compare:Object, options:int) : Array
      {
         return _elements.sort(compare,options);
      }
      
      public function sortOn(key:Object, options:int) : Array
      {
         return _elements.sortOn(key,options);
      }
      
      public function toString() : String
      {
         return "Vector : " + _elements.toString();
      }
   }
}
