package kingDivision.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import shop.view.ShopItemCell;
   
   public class RewardGoodsListItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemCell:BagCell;
      
      public function RewardGoodsListItem(){super();}
      
      private function initView() : void{}
      
      public function goodsInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Boolean, param8:int) : void{}
      
      protected function creatItemCell() : ShopItemCell{return null;}
      
      public function dispose() : void{}
   }
}
