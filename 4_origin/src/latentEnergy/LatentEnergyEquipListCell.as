package latentEnergy
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class LatentEnergyEquipListCell extends BagCell
   {
       
      
      public function LatentEnergyEquipListCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,bg,mouseOverEffBoolean);
         _isShowIsUsedBitmap = true;
      }
   }
}
