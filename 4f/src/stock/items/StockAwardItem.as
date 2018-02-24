package stock.items
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import morn.core.handlers.Handler;
   import stock.StockMgr;
   import stock.data.StockAwardData;
   import stock.mornUI.items.StockAwardItemUI;
   
   public class StockAwardItem extends StockAwardItemUI
   {
       
      
      private var _data:StockAwardData = null;
      
      private var _cell:BaseCell = null;
      
      public function StockAwardItem(){super();}
      
      override protected function initialize() : void{}
      
      private function gain() : void{}
      
      public function set data(param1:StockAwardData) : void{}
      
      private function render() : void{}
      
      override public function dispose() : void{}
   }
}
