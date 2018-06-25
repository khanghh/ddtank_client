package bagAndInfo.cell
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class BankCell extends BagCell
   {
       
      
      public function BankCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,null,true,ComponentFactory.Instance.creatBitmap("asset.bagAndInfo.bankCellBg"),true);
      }
   }
}
