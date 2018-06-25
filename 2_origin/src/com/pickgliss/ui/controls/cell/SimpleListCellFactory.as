package com.pickgliss.ui.controls.cell
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.StringUtils;
   
   public class SimpleListCellFactory implements IListCellFactory
   {
       
      
      private var _ViewWidthNoCount:int;
      
      private var _allCellHasSameHeight:Boolean;
      
      private var _cellHeight:int;
      
      private var _cellStyle:String;
      
      private var _shareCells:Boolean;
      
      public function SimpleListCellFactory(cellStyle:String, cellHeight:int, viewWidthNoCount:int = -1, allCellHasSameHeight:String = "true", shareCells:String = "true")
      {
         super();
         _cellStyle = cellStyle;
         _allCellHasSameHeight = StringUtils.converBoolean(allCellHasSameHeight);
         _shareCells = StringUtils.converBoolean(shareCells);
         _cellHeight = cellHeight;
         _ViewWidthNoCount = viewWidthNoCount;
      }
      
      public function createNewCell() : IListCell
      {
         var cell:IListCell = ComponentFactory.Instance.creat(_cellStyle);
         return cell;
      }
      
      public function getCellHeight() : int
      {
         return _cellHeight;
      }
      
      public function getViewWidthNoCount() : int
      {
         return _ViewWidthNoCount;
      }
      
      public function isAllCellHasSameHeight() : Boolean
      {
         return _allCellHasSameHeight;
      }
      
      public function isShareCells() : Boolean
      {
         return _shareCells;
      }
   }
}
