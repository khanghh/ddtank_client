package GodSyah
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   
   public class SyahCell extends BaseCell
   {
       
      
      public function SyahCell()
      {
         super(ComponentFactory.Instance.creatBitmap("wonderfulactivity.GodSyah.syahView.itemcell"));
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
