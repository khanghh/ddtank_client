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
      
      public function RewardGoodsListItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.rewardView.goodsbg");
         _itemCell = new BagCell(0,null,true,_bg);
         _itemCell.buttonMode = true;
         _itemCell.width = 47;
         _itemCell.height = 47;
         PositionUtils.setPos(_itemCell,"rewardGoodsListItem.cellPos");
         addChild(_bg);
         addChild(_itemCell);
      }
      
      public function goodsInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Boolean, param8:int) : void
      {
         var _loc9_:InventoryItemInfo = new InventoryItemInfo();
         _loc9_.TemplateID = param1;
         ItemManager.fill(_loc9_);
         _loc9_.AttackCompose = param2;
         _loc9_.DefendCompose = param3;
         _loc9_.AgilityCompose = param4;
         _loc9_.LuckCompose = param5;
         _loc9_.Count = param6;
         _loc9_.IsBinds = param7;
         _loc9_.ValidDate = param8;
         _itemCell.info = _loc9_;
         if(_loc9_.Count > 1)
         {
            _itemCell.setCount(_loc9_.Count);
         }
         else
         {
            _itemCell.setCountNotVisible();
         }
      }
      
      protected function creatItemCell() : ShopItemCell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,46,46);
         _loc1_.graphics.endFill();
         return CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
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
