package ddtmatch.view
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.ItemTemplateInfo;
   
   public class DDTMatchExpertCell extends BagCell
   {
       
      
      public function DDTMatchExpertCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true)
      {
         super(param1,param2,param3,null,true);
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
