package dreamlandChallenge.view.logicView
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import dreamlandChallenge.view.mornui.DCAwardCellUI;
   
   public class DCAwardCell extends DCAwardCellUI
   {
       
      
      private var _curCell:BaseCell;
      
      public function DCAwardCell()
      {
         super();
      }
      
      public function set info(goodID:String) : void
      {
         if(goodID == null)
         {
            if(_curCell)
            {
               _curCell.info = null;
            }
         }
         else
         {
            updateCell(int(goodID));
         }
      }
      
      private function updateCell(id:int) : void
      {
         var info:* = null;
         var item:ItemTemplateInfo = ItemManager.Instance.getTemplateById(id);
         _curCell = new BagCell(0);
         _curCell.setContentSize(44,44);
         if(item && item.CategoryID == 74)
         {
            info = ItemManager.fillByID(id);
            info.isShowBind = false;
            _curCell.info = info;
         }
         else
         {
            _curCell.info = item;
         }
         addChild(_curCell);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_curCell);
         _curCell = null;
         super.dispose();
      }
   }
}
