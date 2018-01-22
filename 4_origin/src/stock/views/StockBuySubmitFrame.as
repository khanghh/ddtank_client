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
      
      public function StockBuySubmitFrame(param1:int)
      {
         super();
         goodID = param1;
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
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,80,80);
         _loc1_.graphics.endFill();
         _bagCell = new ShopItemCell(_loc1_);
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
         var _loc1_:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_goodID);
         if(_loc1_)
         {
            if(StockMgr.inst.model.stockAccoutData.fund < _loc1_.AValue1 * numStep.numValue)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.noEnoughFund"));
               return;
            }
            SocketManager.Instance.out.sendNewBuyGoods(_goodID,1,numStep.numValue,"",-1,false,"",0,1,false);
         }
         dispose();
      }
      
      public function set goodID(param1:int) : void
      {
         _goodID = param1;
         numStep.numValue = 1;
         updateView();
      }
      
      private function updateView(param1:int = 0) : void
      {
         var _loc2_:ShopItemInfo = ShopManager.Instance.getShopItemByGoodsID(_goodID);
         if(_loc2_)
         {
            _bagCell.info = ItemManager.Instance.getTemplateById(_loc2_.TemplateID);
            numStep.minValue = 1;
            numStep.maxValue = _loc2_.personalBuyCnt;
            if(_bagCell.info)
            {
               lablFund.text = (_loc2_.AValue1 * numStep.numValue).toString();
               lablBuyNum.text = _loc2_.personalBuyCnt.toString();
               btnBuy.disabled = _loc2_.personalBuyCnt <= 0;
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
