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
      
      public function FarmHouseItem(index:int = -1)
      {
         super();
         _index = index;
         initContent();
      }
      
      protected function initContent() : void
      {
         _itemBg = ComponentFactory.Instance.creat("asset.farm.baseImage5");
         addChild(_itemBg);
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,62,62);
         sp.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
         _itemCell.cellSize = 50;
         addChild(_itemCell);
         _count = ComponentFactory.Instance.creatComponentByStylename("farm.housepnl.count");
      }
      
      public function get info() : InventoryItemInfo
      {
         return _info;
      }
      
      public function set info(info:InventoryItemInfo) : void
      {
         if(_info == info)
         {
            return;
         }
         _info = info;
         _itemCell.info = info;
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
