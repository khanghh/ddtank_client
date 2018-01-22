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
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,56,56);
         _loc1_.graphics.endFill();
         _item = new BaseCell(_loc1_);
         _item.setContentSize(56,56);
         PositionUtils.setPos(_item,{
            "x":6,
            "y":11
         });
         addChild(_item);
      }
      
      public function set data(param1:ItemTemplateInfo) : void
      {
         _item.info = param1;
      }
   }
}
