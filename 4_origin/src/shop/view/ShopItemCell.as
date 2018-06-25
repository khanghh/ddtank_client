package shop.view
{
   import bagAndInfo.cell.BaseCell;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class ShopItemCell extends BaseCell
   {
       
      
      private var _shopItemInfo:ShopCarItemInfo;
      
      protected var _cellSize:uint = 60;
      
      public function ShopItemCell(bg:DisplayObject, info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true)
      {
         super(bg,info,showLoading,showTip);
      }
      
      public function get shopItemInfo() : ShopCarItemInfo
      {
         return _shopItemInfo;
      }
      
      public function set shopItemInfo(value:ShopCarItemInfo) : void
      {
         _shopItemInfo = value;
      }
      
      public function set cellSize(value:uint) : void
      {
         _cellSize = value;
         updateSize(_pic);
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         var scale:Number = NaN;
         PositionUtils.setPos(sp,"ddtshop.ItemCellStartPos");
         if(sp.height >= _cellSize && _cellSize >= sp.width || sp.height >= sp.width && sp.width >= _cellSize || _cellSize >= sp.height && sp.height >= sp.width)
         {
            scale = sp.height / _cellSize;
         }
         else
         {
            scale = sp.width / _cellSize;
         }
         sp.height = sp.height / scale;
         sp.width = sp.width / scale;
         sp.x = sp.x + (_cellSize - sp.width) / 2;
         sp.y = sp.y + (_cellSize - sp.height) / 2;
      }
      
      override protected function updateSizeII(sp:Sprite) : void
      {
         var _loc2_:int = 70;
         sp.height = _loc2_;
         sp.width = _loc2_;
         PositionUtils.setPos(sp,"ddtshop.ItemCellStartPos");
      }
      
      override protected function createLoading() : void
      {
         super.createLoading();
         updateSize(_loadingasset);
      }
      
      public function set tipInfo(value:ShopItemInfo) : void
      {
         if(!value)
         {
            return;
         }
         tipData = value;
      }
      
      override public function dispose() : void
      {
         _shopItemInfo = null;
         super.dispose();
      }
   }
}
