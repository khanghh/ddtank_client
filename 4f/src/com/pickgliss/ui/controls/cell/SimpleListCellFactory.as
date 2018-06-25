package com.pickgliss.ui.controls.cell{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.StringUtils;      public class SimpleListCellFactory implements IListCellFactory   {                   private var _ViewWidthNoCount:int;            private var _allCellHasSameHeight:Boolean;            private var _cellHeight:int;            private var _cellStyle:String;            private var _shareCells:Boolean;            public function SimpleListCellFactory(cellStyle:String, cellHeight:int, viewWidthNoCount:int = -1, allCellHasSameHeight:String = "true", shareCells:String = "true") { super(); }
            public function createNewCell() : IListCell { return null; }
            public function getCellHeight() : int { return 0; }
            public function getViewWidthNoCount() : int { return 0; }
            public function isAllCellHasSameHeight() : Boolean { return false; }
            public function isShareCells() : Boolean { return false; }
   }}