package farm.view.compose.item
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import shop.view.ShopItemCell;
   
   public class FarmHouseItem extends Sprite implements Disposeable
   {
      
      public static const HOUSE_ITEM_WIDTH:int = 72;
       
      
      protected var _itemBg:DisplayObject;
      
      private var _itemCell:ShopItemCell;
      
      private var _index:int;
      
      private var _info:InventoryItemInfo;
      
      private var _count:FilterFrameText;
      
      public function FarmHouseItem(param1:int = -1)
      {
         super();
         _index = param1;
         initContent();
      }
      
      protected function initContent() : void
      {
         _itemBg = ComponentFactory.Instance.creat("asset.farm.baseImage5");
         addChild(_itemBg);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,62,62);
         _loc1_.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
         _itemCell.cellSize = 50;
         addChild(_itemCell);
         _count = ComponentFactory.Instance.creatComponentByStylename("farm.housepnl.count");
      }
      
      public function get info() : InventoryItemInfo
      {
         return _info;
      }
      
      public function set info(param1:InventoryItemInfo) : void
      {
         if(_info == param1)
         {
            return;
         }
         _info = param1;
         _itemCell.info = param1;
         if(_info)
         {
            _count.text = _info.Count.toString();
            addChild(_count);
         }
         else
         {
            _count.text = "";
         }
      }
      
      public function dispose() : void
      {
         _info = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
