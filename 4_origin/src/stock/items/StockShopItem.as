package stock.items
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import morn.core.handlers.Handler;
   import shop.view.ShopItemCell;
   import stock.mornUI.items.StockShopItemUI;
   import stock.views.StockBuySubmitFrame;
   
   public class StockShopItem extends StockShopItemUI
   {
       
      
      private var _bagCell:ShopItemCell = null;
      
      private var _id:int = 0;
      
      public function StockShopItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         stockText1.text = LanguageMgr.GetTranslation("ddt.stock.allView.text1");
         stockText2.text = LanguageMgr.GetTranslation("ddt.stock.allView.text2");
         btnLoadIn.clickHandler = new Handler(buyItem);
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,80,80);
         _loc1_.graphics.endFill();
         _bagCell = new ShopItemCell(_loc1_);
         _bagCell.cellSize = 80;
         PositionUtils.setPos(_bagCell,{
            "x":1,
            "y":5
         });
         addChild(_bagCell);
      }
      
      public function hide() : void
      {
         _bagCell.info = null;
         this.visible = false;
      }
      
      private function buyItem() : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc1_:StockBuySubmitFrame = ComponentFactory.Instance.creatCustomObject("stock.submitFrame",[_id]);
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      public function set data(param1:int) : void
      {
         _id = param1;
         var _loc2_:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(param1);
         if(_loc2_)
         {
            _bagCell.info = ItemManager.Instance.getTemplateById(_loc2_.TemplateID);
            if(_bagCell.info)
            {
               lablName.text = _bagCell.info.Name;
               lablPrice.text = _loc2_.AValue1.toString();
               lablCnt.text = _loc2_.personalBuyCnt.toString();
               btnLoadIn.disabled = _loc2_.personalBuyCnt <= 0;
            }
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bagCell);
         _bagCell = null;
         super.dispose();
      }
   }
}
