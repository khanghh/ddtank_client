package ddt.view.bossbox
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class BoxAwardsCell extends BaseCell implements IListCell
   {
       
      
      protected var _itemName:FilterFrameText;
      
      protected var count_txt:FilterFrameText;
      
      private var di:ScaleBitmapImage;
      
      public function BoxAwardsCell(){super(null);}
      
      override protected function createChildren() : void{}
      
      protected function initII() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      private function addEvent() : void{}
      
      public function set count(param1:int) : void{}
      
      public function __setItemName(param1:Event) : void{}
      
      public function set itemName(param1:String) : void{}
      
      override public function get height() : Number{return 0;}
      
      override public function dispose() : void{}
   }
}
