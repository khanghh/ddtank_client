package pyramid.view
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class PyramidCell extends BagCell
   {
       
      
      public function PyramidCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function updateCount() : void
      {
         super.updateCount();
         if(itemInfo && itemInfo.Count > 1)
         {
            _tbxCount.visible = true;
         }
         else
         {
            _tbxCount.visible = false;
         }
      }
   }
}
