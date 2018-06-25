package newChickenBox.view
{
   import bagAndInfo.cell.BaseCell;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class NewChickenBoxCell extends BaseCell
   {
       
      
      public function NewChickenBoxCell(bg:DisplayObject, $info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true)
      {
         super(bg,$info,showLoading,showTip);
         var point:Point = new Point(2,2);
         PicPos = point;
      }
   }
}
