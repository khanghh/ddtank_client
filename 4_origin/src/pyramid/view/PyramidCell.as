package pyramid.view
{
   import bagAndInfo.cell.BagCell;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class PyramidCell extends BagCell
   {
       
      
      public function PyramidCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,bg,mouseOverEffBoolean);
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
