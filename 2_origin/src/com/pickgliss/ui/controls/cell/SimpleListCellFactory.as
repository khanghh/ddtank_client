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
      
      public function SimpleListCellFactory(param1:String, param2:int, param3:int = -1, param4:String = "true", param5:String = "true")
      {
         super();
         _cellStyle = param1;
         _allCellHasSameHeight = StringUtils.converBoolean(param4);
         _shareCells = StringUtils.converBoolean(param5);
         _cellHeight = param2;
         _ViewWidthNoCount = param3;
      }
      
      public function createNewCell() : IListCell
      {
         var _loc1_:IListCell = ComponentFactory.Instance.creat(_cellStyle);
         return _loc1_;
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
