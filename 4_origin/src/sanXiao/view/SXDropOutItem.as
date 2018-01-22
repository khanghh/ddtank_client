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
       
      
      public function SXDropOutItem(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function updateItem(param1:Object = null) : void
      {
         var _loc2_:SXGainedItemDATA = param1 as SXGainedItemDATA;
         if(_loc2_ == null)
         {
            info = null;
            this.tbxCount.text = "0";
         }
         else
         {
            info = ItemManager.Instance.getTemplateById(_loc2_.templeteID);
            this.tbxCount.text = _loc2_.count.toString();
            this.tbxCount.visible = true;
            addChild(tbxCount);
         }
      }
   }
}
