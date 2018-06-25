package store.forge.wishBead
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class WishBeadEquipListCell extends BagCell
   {
       
      
      public function WishBeadEquipListCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,bg,mouseOverEffBoolean);
         _isShowIsUsedBitmap = true;
      }
   }
}
