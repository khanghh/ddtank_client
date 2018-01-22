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
      
      public function ShopItemCell(param1:DisplayObject, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get shopItemInfo() : ShopCarItemInfo
      {
         return _shopItemInfo;
      }
      
      public function set shopItemInfo(param1:ShopCarItemInfo) : void
      {
         _shopItemInfo = param1;
      }
      
      public function set cellSize(param1:uint) : void
      {
         _cellSize = param1;
         updateSize(_pic);
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         var _loc2_:Number = NaN;
         PositionUtils.setPos(param1,"ddtshop.ItemCellStartPos");
         if(param1.height >= _cellSize && _cellSize >= param1.width || param1.height >= param1.width && param1.width >= _cellSize || _cellSize >= param1.height && param1.height >= param1.width)
         {
            _loc2_ = param1.height / _cellSize;
         }
         else
         {
            _loc2_ = param1.width / _cellSize;
         }
         param1.height = param1.height / _loc2_;
         param1.width = param1.width / _loc2_;
         param1.x = param1.x + (_cellSize - param1.width) / 2;
         param1.y = param1.y + (_cellSize - param1.height) / 2;
      }
      
      override protected function updateSizeII(param1:Sprite) : void
      {
         var _loc2_:int = 70;
         param1.height = _loc2_;
         param1.width = _loc2_;
         PositionUtils.setPos(param1,"ddtshop.ItemCellStartPos");
      }
      
      override protected function createLoading() : void
      {
         super.createLoading();
         updateSize(_loadingasset);
      }
      
      public function set tipInfo(param1:ShopItemInfo) : void
      {
         if(!param1)
         {
            return;
         }
         tipData = param1;
      }
      
      override public function dispose() : void
      {
         _shopItemInfo = null;
         super.dispose();
      }
   }
}
