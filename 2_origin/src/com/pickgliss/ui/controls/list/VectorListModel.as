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
      
      public function VectorListModel(param1:Array = null)
      {
         super();
         if(param1 != null)
         {
            _elements = param1.concat();
         }
         else
         {
            _elements = [];
         }
      }
      
      public function append(param1:*, param2:int = -1) : void
      {
         if(param2 == -1)
         {
            param2 = _elements.length;
            _elements.push(param1);
         }
         else
         {
            _elements.splice(param2,0,param1);
         }
         fireIntervalAdded(this,param2,param2);
      }
      
      public function appendAll(param1:Array, param2:int = -1) : void
      {
         var _loc3_:* = null;
         if(param1 == null || param1.length <= 0)
         {
            return;
         }
         if(param2 == -1)
         {
            param2 = _elements.length;
         }
         if(param2 == 0)
         {
            _elements = param1.concat(_elements);
         }
         else if(param2 == _elements.length)
         {
            _elements = _elements.concat(param1);
         }
         else
         {
            _loc3_ = _elements.splice(param2);
            _elements = _elements.concat(param1);
            _elements = _elements.concat(_loc3_);
         }
         fireIntervalAdded(this,param2,param2 + param1.length - 1);
      }
      
      public function appendList(param1:IListData, param2:int = -1) : void
      {
         appendAll(param1.toArray(),param2);
      }
      
      public function clear() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = size() - 1;
         if(_loc1_ >= 0)
         {
            _loc2_ = toArray();
            _elements.splice(0);
            fireIntervalRemoved(this,0,_loc1_,_loc2_);
         }
      }
      
      public function contains(param1:*) : Boolean
      {
         return indexOf(param1) >= 0;
      }
      
      public function first() : *
      {
         return _elements[0];
      }
      
      public function get(param1:int) : *
      {
         return _elements[param1];
      }
      
      public function getElementAt(param1:int) : *
      {
         return _elements[param1];
      }
      
      public function getSize() : int
      {
         return size();
      }
      
      public function indexOf(param1:*) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _elements.length)
         {
            if(_elements[_loc2_] == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function insertElementAt(param1:*, param2:int) : void
      {
         append(param1,param2);
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
      
      public function remove(param1:*) : *
      {
         var _loc2_:int = indexOf(param1);
         if(_loc2_ >= 0)
         {
            return removeAt(_loc2_);
         }
         return null;
      }
      
      public function removeAt(param1:int) : *
      {
         if(param1 < 0 || param1 >= size())
         {
            return null;
         }
         var _loc2_:* = _elements[param1];
         _elements.splice(param1,1);
         fireIntervalRemoved(this,param1,param1,[_loc2_]);
         return _loc2_;
      }
      
      public function removeElementAt(param1:int) : void
      {
         removeAt(param1);
      }
      
      public function removeRange(param1:int, param2:int) : Array
      {
         var _loc3_:* = null;
         if(_elements.length > 0)
         {
            param1 = Math.max(0,param1);
            param2 = Math.min(param2,_elements.length - 1);
            if(param1 > param2)
            {
               return [];
            }
            _loc3_ = _elements.splice(param1,param2 - param1 + 1);
            fireIntervalRemoved(this,param1,param2,_loc3_);
            return _loc3_;
         }
         return [];
      }
      
      public function replaceAt(param1:int, param2:*) : *
      {
         if(param1 < 0 || param1 >= size())
         {
            return null;
         }
         var _loc3_:* = _elements[param1];
         _elements[param1] = param2;
         fireContentsChanged(this,param1,param1,[_loc3_]);
         return _loc3_;
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
      
      public function sort(param1:Object, param2:int) : Array
      {
         var _loc3_:Array = _elements.sort(param1,param2);
         fireContentsChanged(this,0,_elements.length - 1,[]);
         return _loc3_;
      }
      
      public function sortOn(param1:Object, param2:int) : Array
      {
         var _loc3_:Array = _elements.sortOn(param1,param2);
         fireContentsChanged(this,0,_elements.length - 1,[]);
         return _loc3_;
      }
      
      public function subArray(param1:int, param2:int) : Array
      {
         if(size() == 0 || param2 <= 0)
         {
            return [];
         }
         return _elements.slice(param1,Math.min(param1 + param2,size()));
      }
      
      public function toArray() : Array
      {
         return _elements.concat();
      }
      
      public function toString() : String
      {
         return "VectorListModel : " + _elements.toString();
      }
      
      public function valueChanged(param1:*) : void
      {
         valueChangedAt(indexOf(param1));
      }
      
      public function valueChangedAt(param1:int) : void
      {
         if(param1 >= 0 && param1 < _elements.length)
         {
            fireContentsChanged(this,param1,param1,[]);
         }
      }
      
      public function valueChangedRange(param1:int, param2:int) : void
      {
         fireContentsChanged(this,param1,param2,[]);
      }
      
      public function get elements() : Array
      {
         return _elements;
      }
      
      public function getCellPosFromIndex(param1:int) : Number
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = 0;
         var _loc3_:int = size();
         if(param1 > _loc3_)
         {
            param1 = _loc3_;
         }
         _loc5_ = 0;
         while(_loc5_ < param1)
         {
            if(_loc5_ != param1)
            {
               _loc4_ = get(_loc5_);
               _loc2_ = Number(_loc2_ + _loc4_.getCellHeight());
               _loc5_++;
               continue;
            }
            break;
         }
         return _loc2_;
      }
      
      public function getAllCellHeight() : Number
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = 0;
         var _loc2_:int = size();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = get(_loc4_);
            _loc1_ = Number(_loc1_ + _loc3_.getCellHeight());
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function getStartIndexByPosY(param1:Number) : int
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = 0;
         var _loc3_:int = size();
         var _loc5_:* = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = get(_loc6_);
            _loc5_ = Number(_loc5_ + _loc4_.getCellHeight());
            if(_loc5_ >= param1)
            {
               _loc2_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         return _loc2_;
      }
   }
}
