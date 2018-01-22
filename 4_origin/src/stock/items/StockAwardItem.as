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
      
      public function StockAwardItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         _cell = new BagCell(0,null,true,ComponentFactory.Instance.creatBitmap("asset.stock.itemBg"));
         PositionUtils.setPos(_cell,"stock.awardCellPos");
         addChild(_cell);
         btnAward.clickHandler = new Handler(gain);
      }
      
      private function gain() : void
      {
         StockMgr.inst.requestAward(_data.index);
      }
      
      public function set data(param1:StockAwardData) : void
      {
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         render();
      }
      
      private function render() : void
      {
         lblScore.text = _data.score.toString();
         itemBg.index = _data.index % 2;
         _cell.info = ItemManager.Instance.getTemplateById(_data.awardId);
         if(_data.status == 2)
         {
            imgGained.visible = true;
            btnAward.visible = false;
         }
         else
         {
            imgGained.visible = false;
            btnAward.visible = true;
            btnAward.disabled = _data.status == 0;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_cell);
         _cell = null;
      }
   }
}
