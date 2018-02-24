package mark.items
{
   import bagAndInfo.cell.BaseCell;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import mark.mornUI.items.MarkEquipItemUI;
   
   public class MarkEquipItem extends MarkEquipItemUI
   {
       
      
      private var _item:BaseCell;
      
      public function MarkEquipItem(){super();}
      
      override protected function initialize() : void{}
      
      public function set data(param1:ItemTemplateInfo) : void{}
   }
}
