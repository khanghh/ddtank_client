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
      
      public function VectorListModel(param1:Array = null){super();}
      
      public function append(param1:*, param2:int = -1) : void{}
      
      public function appendAll(param1:Array, param2:int = -1) : void{}
      
      public function appendList(param1:IListData, param2:int = -1) : void{}
      
      public function clear() : void{}
      
      public function contains(param1:*) : Boolean{return false;}
      
      public function first() : *{return null;}
      
      public function get(param1:int) : *{return null;}
      
      public function getElementAt(param1:int) : *{return null;}
      
      public function getSize() : int{return 0;}
      
      public function indexOf(param1:*) : int{return 0;}
      
      public function insertElementAt(param1:*, param2:int) : void{}
      
      public function isEmpty() : Boolean{return false;}
      
      public function last() : *{return null;}
      
      public function pop() : *{return null;}
      
      public function remove(param1:*) : *{return null;}
      
      public function removeAt(param1:int) : *{return null;}
      
      public function removeElementAt(param1:int) : void{}
      
      public function removeRange(param1:int, param2:int) : Array{return null;}
      
      public function replaceAt(param1:int, param2:*) : *{return null;}
      
      public function shift() : *{return null;}
      
      public function size() : int{return 0;}
      
      public function sort(param1:Object, param2:int) : Array{return null;}
      
      public function sortOn(param1:Object, param2:int) : Array{return null;}
      
      public function subArray(param1:int, param2:int) : Array{return null;}
      
      public function toArray() : Array{return null;}
      
      public function toString() : String{return null;}
      
      public function valueChanged(param1:*) : void{}
      
      public function valueChangedAt(param1:int) : void{}
      
      public function valueChangedRange(param1:int, param2:int) : void{}
      
      public function get elements() : Array{return null;}
      
      public function getCellPosFromIndex(param1:int) : Number{return 0;}
      
      public function getAllCellHeight() : Number{return 0;}
      
      public function getStartIndexByPosY(param1:Number) : int{return 0;}
   }
}
