package wonderfulActivity.newActivity.ExchangeAct
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.event.ActivityEvent;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class ExchangeGoodsCell extends BaseCell
   {
       
      
      private var _gooodsExchangeInfo:GiftRewardInfo;
      
      private var _countText:FilterFrameText;
      
      private var _type:Boolean;
      
      private var _haveCount:int;
      
      private var _needCount:int;
      
      private var _haveCountTemp:int;
      
      private var _num:int;
      
      private var _id:int;
      
      public function ExchangeGoodsCell(param1:GiftRewardInfo, param2:int = -1, param3:Boolean = true, param4:int = -1, param5:int = 1){super(null,null);}
      
      public function get itemInfo() : InventoryItemInfo{return null;}
      
      private function intEvent() : void{}
      
      private function __updateCount(param1:BagEvent) : void{}
      
      public function get haveCount() : int{return 0;}
      
      public function get needCount() : int{return 0;}
      
      override public function dispose() : void{}
   }
}
