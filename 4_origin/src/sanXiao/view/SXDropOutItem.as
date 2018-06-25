package sanXiao.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.view.pageSelector.IPageItem;
   import flash.display.DisplayObject;
   import sanXiao.model.SXGainedItemDATA;
   
   public class SXDropOutItem extends BagCell implements Disposeable, IPageItem
   {
       
      
      public function SXDropOutItem(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,bg,mouseOverEffBoolean);
      }
      
      public function updateItem(data:Object = null) : void
      {
         var __data:SXGainedItemDATA = data as SXGainedItemDATA;
         if(__data == null)
         {
            info = null;
            this.tbxCount.text = "0";
         }
         else
         {
            info = ItemManager.Instance.getTemplateById(__data.templeteID);
            this.tbxCount.text = __data.count.toString();
            this.tbxCount.visible = true;
            addChild(tbxCount);
         }
      }
   }
}
