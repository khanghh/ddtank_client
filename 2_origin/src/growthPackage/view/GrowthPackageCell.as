package growthPackage.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   
   public class GrowthPackageCell extends BagCell
   {
       
      
      public function GrowthPackageCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true)
      {
         super(param1,param2,param3,ComponentFactory.Instance.creatBitmap("assets.growthPackage.cellBg"),true);
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
