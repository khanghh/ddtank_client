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
      
      public function AwardCellItem(param1:int){super();}
      
      protected function initView() : void{}
      
      public function set info(param1:ItemTemplateInfo) : void{}
      
      public function getInfo() : InventoryItemInfo{return null;}
      
      public function set count(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
