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
      
      public function StockBuySubmitFrame(param1:int){super();}
      
      override protected function initialize() : void{}
      
      private function initView() : void{}
      
      private function close() : void{}
      
      private function buy() : void{}
      
      public function set goodID(param1:int) : void{}
      
      private function updateView(param1:int = 0) : void{}
      
      override public function dispose() : void{}
   }
}
