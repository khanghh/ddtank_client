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
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
