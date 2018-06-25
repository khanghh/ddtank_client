package treasure.view
{
   import bagAndInfo.cell.BaseCell;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class TreasureFieldCell extends BaseCell
   {
       
      
      public function TreasureFieldCell(bg:DisplayObject, $info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true)
      {
         super(bg,$info,showLoading,showTip);
      }
   }
}
