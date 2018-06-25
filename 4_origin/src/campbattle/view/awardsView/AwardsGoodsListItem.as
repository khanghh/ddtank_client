package campbattle.view.awardsView
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
   
   public class AwardsGoodsListItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemCell:BagCell;
      
      public function AwardsGoodsListItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.campbattle.goodsbg");
         _itemCell = new BagCell(0,null,true,_bg);
         _itemCell.buttonMode = true;
         _itemCell.width = 47;
         _itemCell.height = 47;
         PositionUtils.setPos(_itemCell,"ddtCampBattle.awardGoodsListItem.cellPos");
         addChild(_bg);
         addChild(_itemCell);
      }
      
      public function goodsInfo(value:int, ac:int, dc:int, agc:int, lc:int, count:int, isBind:Boolean, validDate:int) : void
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = value;
         ItemManager.fill(itemInfo);
         itemInfo.AttackCompose = ac;
         itemInfo.DefendCompose = dc;
         itemInfo.AgilityCompose = agc;
         itemInfo.LuckCompose = lc;
         itemInfo.Count = count;
         itemInfo.IsBinds = isBind;
         itemInfo.ValidDate = validDate;
         _itemCell.info = itemInfo;
         if(itemInfo.Count > 1)
         {
            _itemCell.setCount(itemInfo.Count);
         }
         else
         {
            _itemCell.setCountNotVisible();
         }
      }
      
      protected function creatItemCell() : ShopItemCell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,46,46);
         sp.graphics.endFill();
         return CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _itemCell = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
