package calendar.view.goodsExchange
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.event.ActivityEvent;
   import ddt.data.GoodsExchangeInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   
   public class GoodsExchangeCell extends BaseCell
   {
       
      
      protected var _countText:FilterFrameText;
      
      private var _gooodsExchangeInfo:GoodsExchangeInfo;
      
      private var _type:Boolean;
      
      private var _haveCount:int;
      
      private var _needCount:int;
      
      private var _haveCountTemp:int;
      
      private var _id:int;
      
      public function GoodsExchangeCell(param1:GoodsExchangeInfo, param2:int = -1, param3:Boolean = true, param4:int = -1){super(null,null);}
      
      public function get itemInfo() : InventoryItemInfo{return null;}
      
      private function intEvent() : void{}
      
      protected function __updateCount(param1:BagEvent) : void{}
      
      public function get haveCount() : int{return 0;}
      
      public function get needCount() : int{return 0;}
      
      public function get gooodsExchangeInfo() : GoodsExchangeInfo{return null;}
      
      override public function dispose() : void{}
   }
}
