package oldPlayerComeBack.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Sprite;
   
   public class AwardCellItem extends Sprite
   {
       
      
      private var _cell:BagCell;
      
      protected var _curPlace:int;
      
      public function AwardCellItem(index:int)
      {
         super();
         _curPlace = index;
         initView();
      }
      
      protected function initView() : void
      {
         _cell = new BagCell(_curPlace);
         _cell.BGVisible = false;
         addChild(_cell);
      }
      
      public function set info(info:ItemTemplateInfo) : void
      {
         _cell.info = info;
      }
      
      public function getInfo() : InventoryItemInfo
      {
         return _cell.info as InventoryItemInfo;
      }
      
      public function set count(value:int) : void
      {
         if(value > 1)
         {
            _cell.setCount(value);
         }
         else
         {
            _cell.setCountNotVisible();
         }
      }
      
      public function dispose() : void
      {
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(this && this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
