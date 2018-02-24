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
      
      public function ShopItemCell(param1:DisplayObject, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true){super(null,null,null,null);}
      
      public function get shopItemInfo() : ShopCarItemInfo{return null;}
      
      public function set shopItemInfo(param1:ShopCarItemInfo) : void{}
      
      public function set cellSize(param1:uint) : void{}
      
      override protected function updateSize(param1:Sprite) : void{}
      
      override protected function updateSizeII(param1:Sprite) : void{}
      
      override protected function createLoading() : void{}
      
      public function set tipInfo(param1:ShopItemInfo) : void{}
      
      override public function dispose() : void{}
   }
}
