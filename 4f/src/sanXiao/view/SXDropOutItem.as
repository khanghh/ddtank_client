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
       
      
      public function SXDropOutItem(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null,null,null,null,null);}
      
      public function updateItem(param1:Object = null) : void{}
   }
}
