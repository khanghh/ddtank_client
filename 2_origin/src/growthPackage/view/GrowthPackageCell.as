package growthPackage.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   
   public class GrowthPackageCell extends BagCell
   {
       
      
      public function GrowthPackageCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true)
      {
         super(index,info,showLoading,ComponentFactory.Instance.creatBitmap("assets.growthPackage.cellBg"),true);
      }
      
      override public function updateCount() : void
      {
         if(_tbxCount)
         {
            if(_info && itemInfo && itemInfo.Count > 1)
            {
               _tbxCount.text = String(itemInfo.Count);
               _tbxCount.visible = true;
               addChild(_tbxCount);
            }
            else
            {
               _tbxCount.visible = false;
            }
         }
      }
   }
}
