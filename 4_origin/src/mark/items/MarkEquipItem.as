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
      
      public function MarkEquipItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var cellBG:Shape = new Shape();
         cellBG.graphics.beginFill(16777215,0);
         cellBG.graphics.drawRect(0,0,56,56);
         cellBG.graphics.endFill();
         _item = new BaseCell(cellBG);
         _item.setContentSize(56,56);
         PositionUtils.setPos(_item,{
            "x":-1,
            "y":0
         });
         addChild(_item);
      }
      
      public function set data(value:ItemTemplateInfo) : void
      {
         _item.info = value;
      }
   }
}
