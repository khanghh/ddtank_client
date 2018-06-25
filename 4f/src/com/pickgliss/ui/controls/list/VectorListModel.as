package com.pickgliss.ui.controls.list{   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;   import com.pickgliss.utils.IListData;      public class VectorListModel extends BaseListModel implements IMutableListModel, IListData   {            public static const CASEINSENSITIVE:int = 1;            public static const DESCENDING:int = 2;            public static const NUMERIC:int = 16;            public static const RETURNINDEXEDARRAY:int = 8;            public static const UNIQUESORT:int = 4;                   protected var _elements:Array;            public function VectorListModel(initalData:Array = null) { super(); }
            public function append(obj:*, index:int = -1) : void { }
            public function appendAll(arr:Array, index:int = -1) : void { }
            public function appendList(list:IListData, index:int = -1) : void { }
            public function clear() : void { }
            public function contains(obj:*) : Boolean { return false; }
            public function first() : * { return null; }
            public function get(i:int) : * { return null; }
            public function getElementAt(i:int) : * { return null; }
            public function getSize() : int { return 0; }
            public function indexOf(obj:*) : int { return 0; }
            public function insertElementAt(item:*, index:int) : void { }
            public function isEmpty() : Boolean { return false; }
            public function last() : * { return null; }
            public function pop() : * { return null; }
            public function remove(obj:*) : * { return null; }
            public function removeAt(index:int) : * { return null; }
            public function removeElementAt(index:int) : void { }
            public function removeRange(fromIndex:int, toIndex:int) : Array { return null; }
            public function replaceAt(index:int, obj:*) : * { return null; }
            public function shift() : * { return null; }
            public function size() : int { return 0; }
            public function sort(compare:Object, options:int) : Array { return null; }
            public function sortOn(key:Object, options:int) : Array { return null; }
            public function subArray(startIndex:int, length:int) : Array { return null; }
            public function toArray() : Array { return null; }
            public function toString() : String { return null; }
            public function valueChanged(obj:*) : void { }
            public function valueChangedAt(index:int) : void { }
            public function valueChangedRange(from:int, to:int) : void { }
            public function get elements() : Array { return null; }
            public function getCellPosFromIndex(index:int) : Number { return 0; }
            public function getAllCellHeight() : Number { return 0; }
            public function getStartIndexByPosY(posY:Number) : int { return 0; }
   }}