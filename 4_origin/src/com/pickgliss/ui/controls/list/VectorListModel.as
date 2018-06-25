package com.pickgliss.ui.controls.list
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import com.pickgliss.utils.IListData;
   
   public class VectorListModel extends BaseListModel implements IMutableListModel, IListData
   {
      
      public static const CASEINSENSITIVE:int = 1;
      
      public static const DESCENDING:int = 2;
      
      public static const NUMERIC:int = 16;
      
      public static const RETURNINDEXEDARRAY:int = 8;
      
      public static const UNIQUESORT:int = 4;
       
      
      protected var _elements:Array;
      
      public function VectorListModel(initalData:Array = null)
      {
         super();
         if(initalData != null)
         {
            _elements = initalData.concat();
         }
         else
         {
            _elements = [];
         }
      }
      
      public function append(obj:*, index:int = -1) : void
      {
         if(index == -1)
         {
            index = _elements.length;
            _elements.push(obj);
         }
         else
         {
            _elements.splice(index,0,obj);
         }
         fireIntervalAdded(this,index,index);
      }
      
      public function appendAll(arr:Array, index:int = -1) : void
      {
         var right:* = null;
         if(arr == null || arr.length <= 0)
         {
            return;
         }
         if(index == -1)
         {
            index = _elements.length;
         }
         if(index == 0)
         {
            _elements = arr.concat(_elements);
         }
         else if(index == _elements.length)
         {
            _elements = _elements.concat(arr);
         }
         else
         {
            right = _elements.splice(index);
            _elements = _elements.concat(arr);
            _elements = _elements.concat(right);
         }
         fireIntervalAdded(this,index,index + arr.length - 1);
      }
      
      public function appendList(list:IListData, index:int = -1) : void
      {
         appendAll(list.toArray(),index);
      }
      
      public function clear() : void
      {
         var temp:* = null;
         var ei:int = size() - 1;
         if(ei >= 0)
         {
            temp = toArray();
            _elements.splice(0);
            fireIntervalRemoved(this,0,ei,temp);
         }
      }
      
      public function contains(obj:*) : Boolean
      {
         return indexOf(obj) >= 0;
      }
      
      public function first() : *
      {
         return _elements[0];
      }
      
      public function get(i:int) : *
      {
         return _elements[i];
      }
      
      public function getElementAt(i:int) : *
      {
         return _elements[i];
      }
      
      public function getSize() : int
      {
         return size();
      }
      
      public function indexOf(obj:*) : int
      {
         var i:int = 0;
         for(i = 0; i < _elements.length; )
         {
            if(_elements[i] == obj)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function insertElementAt(item:*, index:int) : void
      {
         append(item,index);
      }
      
      public function isEmpty() : Boolean
      {
         return _elements.length <= 0;
      }
      
      public function last() : *
      {
         return _elements[_elements.length - 1];
      }
      
      public function pop() : *
      {
         if(size() > 0)
         {
            return removeAt(size() - 1);
         }
         return null;
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
      
      public function removeAt(index:int) : *
      {
         if(index < 0 || index >= size())
         {
            return null;
         }
         var obj:* = _elements[index];
         _elements.splice(index,1);
         fireIntervalRemoved(this,index,index,[obj]);
         return obj;
      }
      
      public function removeElementAt(index:int) : void
      {
         removeAt(index);
      }
      
      public function removeRange(fromIndex:int, toIndex:int) : Array
      {
         var removed:* = null;
         if(_elements.length > 0)
         {
            fromIndex = Math.max(0,fromIndex);
            toIndex = Math.min(toIndex,_elements.length - 1);
            if(fromIndex > toIndex)
            {
               return [];
            }
            removed = _elements.splice(fromIndex,toIndex - fromIndex + 1);
            fireIntervalRemoved(this,fromIndex,toIndex,removed);
            return removed;
         }
         return [];
      }
      
      public function replaceAt(index:int, obj:*) : *
      {
         if(index < 0 || index >= size())
         {
            return null;
         }
         var oldObj:* = _elements[index];
         _elements[index] = obj;
         fireContentsChanged(this,index,index,[oldObj]);
         return oldObj;
      }
      
      public function shift() : *
      {
         if(size() > 0)
         {
            return removeAt(0);
         }
         return null;
      }
      
      public function size() : int
      {
         return _elements.length;
      }
      
      public function sort(compare:Object, options:int) : Array
      {
         var returned:Array = _elements.sort(compare,options);
         fireContentsChanged(this,0,_elements.length - 1,[]);
         return returned;
      }
      
      public function sortOn(key:Object, options:int) : Array
      {
         var returned:Array = _elements.sortOn(key,options);
         fireContentsChanged(this,0,_elements.length - 1,[]);
         return returned;
      }
      
      public function subArray(startIndex:int, length:int) : Array
      {
         if(size() == 0 || length <= 0)
         {
            return [];
         }
         return _elements.slice(startIndex,Math.min(startIndex + length,size()));
      }
      
      public function toArray() : Array
      {
         return _elements.concat();
      }
      
      public function toString() : String
      {
         return "VectorListModel : " + _elements.toString();
      }
      
      public function valueChanged(obj:*) : void
      {
         valueChangedAt(indexOf(obj));
      }
      
      public function valueChangedAt(index:int) : void
      {
         if(index >= 0 && index < _elements.length)
         {
            fireContentsChanged(this,index,index,[]);
         }
      }
      
      public function valueChangedRange(from:int, to:int) : void
      {
         fireContentsChanged(this,from,to,[]);
      }
      
      public function get elements() : Array
      {
         return _elements;
      }
      
      public function getCellPosFromIndex(index:int) : Number
      {
         var i:int = 0;
         var cellData:* = null;
         var result:* = 0;
         var cellSize:int = size();
         if(index > cellSize)
         {
            index = cellSize;
         }
         i = 0;
         while(i < index)
         {
            if(i != index)
            {
               cellData = get(i);
               result = Number(result + cellData.getCellHeight());
               i++;
               continue;
            }
            break;
         }
         return result;
      }
      
      public function getAllCellHeight() : Number
      {
         var i:int = 0;
         var cellData:* = null;
         var result:* = 0;
         var cellSize:int = size();
         for(i = 0; i < cellSize; )
         {
            cellData = get(i);
            result = Number(result + cellData.getCellHeight());
            i++;
         }
         return result;
      }
      
      public function getStartIndexByPosY(posY:Number) : int
      {
         var i:int = 0;
         var cellData:* = null;
         var result:* = 0;
         var cellSize:int = size();
         var heightCounter:* = 0;
         for(i = 0; i < cellSize; )
         {
            cellData = get(i);
            heightCounter = Number(heightCounter + cellData.getCellHeight());
            if(heightCounter >= posY)
            {
               result = i;
               break;
            }
            i++;
         }
         return result;
      }
   }
}
