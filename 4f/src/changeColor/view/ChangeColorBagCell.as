package changeColor.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import flash.display.Sprite;
   
   public class ChangeColorBagCell extends BagCell
   {
       
      
      public function ChangeColorBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Sprite = null){super(null,null,null,null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
   }
}
