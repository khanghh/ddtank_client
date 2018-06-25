package stock.views
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import morn.core.handlers.Handler;
   import shop.view.ShopItemCell;
   import stock.StockMgr;
   import stock.mornUI.views.StockBuySubmitFrameUI;
   
   public class StockBuySubmitFrame extends StockBuySubmitFrameUI
   {
       
      
      private var _goodID:int = 0;
      
      private var _bagCell:ShopItemCell = null;
      
      public function StockBuySubmitFrame(id:int)
      {
         super();
         goodID = id;
      }
      
      override protected function initialize() : void
      {
         stockText1.text = LanguageMgr.GetTranslation("ddt.stock.allView.text16");
         stockText2.text = LanguageMgr.GetTranslation("ddt.stock.allView.text17");
         btnBuy.clickHandler = new Handler(buy);
         numStep.changeHandler = new Handler(updateView);
         btnClose.clickHandler = new Handler(close);
         initView();
      }
      
      private function initView() : void
      {
         var cellBG:Shape = new Shape();
         cellBG.graphics.beginFill(16777215,0);
         cellBG.graphics.drawRect(0,0,80,80);
         cellBG.graphics.endFill();
         _bagCell = new ShopItemCell(cellBG);
         _bagCell.cellSize = 80;
         PositionUtils.setPos(_bagCell,{
            "x":23,
            "y":62
         });
         addChild(_bagCell);
      }
      
      private function close() : void
      {
         super.dispose();
      }
      
      private function buy() : void
      {
         SoundManager.instance.playButtonSound();
         var shopItem:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_goodID);
         if(shopItem)
         {
            if(StockMgr.inst.model.stockAccoutData.fund < shopItem.AValue1 * numStep.numValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.noEnoughFund"));
               return;
            }
            SocketManager.Instance.out.sendNewBuyGoods(_goodID,1,numStep.numValue,"",-1,false,"",0,1,false);
         }
         dispose();
      }
      
      public function set goodID(value:int) : void
      {
         _goodID = value;
         numStep.numValue = 1;
         updateView();
      }
      
      private function updateView(value:int = 0) : void
      {
         var shopItem:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_goodID);
         if(shopItem)
         {
            _bagCell.info = ItemManager.Instance.getTemplateById(shopItem.TemplateID);
            numStep.minValue = 1;
            numStep.maxValue = shopItem.personalBuyCnt;
            if(_bagCell.info)
            {
               lablFund.text = (shopItem.AValue1 * numStep.numValue).toString();
               lablBuyNum.text = shopItem.personalBuyCnt.toString();
               btnBuy.disabled = shopItem.personalBuyCnt <= 0;
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
