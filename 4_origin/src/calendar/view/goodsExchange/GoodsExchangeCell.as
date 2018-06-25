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
      
      public function GoodsExchangeCell(exchangeInfo:GoodsExchangeInfo, activeType:int = -1, type:Boolean = true, id:int = -1)
      {
         var itemInfo:* = null;
         var item:* = null;
         var tempId:int = 0;
         intEvent();
         _gooodsExchangeInfo = exchangeInfo;
         _type = type;
         _id = id;
         if(exchangeInfo && (activeType == 3 || activeType == 4))
         {
            if(activeType == 4)
            {
               if(_type)
               {
                  _bg = ComponentFactory.Instance.creatBitmap("asset.activity.wordBg");
               }
               else
               {
                  _bg = ComponentFactory.Instance.creatBitmap("asset.activity.seedBg");
               }
               _bg.alpha = 0;
            }
            else
            {
               _bg = ComponentFactory.Instance.creatBitmap("asset.activity.seedBg");
            }
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("ddtcalendar.exchange.cellBg");
         }
         _countText = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.cellCount");
         if(_gooodsExchangeInfo == null)
         {
            _info = null;
            _countText.text = "";
         }
         else
         {
            itemInfo = ItemManager.Instance.getTemplateById(_gooodsExchangeInfo.TemplateID);
            item = new InventoryItemInfo();
            item.TemplateID = itemInfo.TemplateID;
            ItemManager.fill(item);
            item.StrengthenLevel = _gooodsExchangeInfo.LimitValue;
            item.IsBinds = true;
            item.isShowBind = _type != true;
            _info = item;
            if(_type)
            {
               tempId = exchangeInfo.TemplateID;
               if(item.CanStrengthen)
               {
                  _haveCount = PlayerManager.Instance.Self.findItemCount(tempId,_gooodsExchangeInfo.LimitValue);
               }
               else
               {
                  _haveCount = PlayerManager.Instance.Self.findItemCount(tempId);
               }
               if(_haveCount == 0)
               {
                  _haveCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(tempId);
               }
               if(_haveCount == 0)
               {
                  _haveCount = PlayerManager.Instance.Self.BeadBag.getItemCountByTemplateId(tempId);
               }
               _countText.text = _haveCount.toString() + "/" + (_gooodsExchangeInfo.ItemCount * _gooodsExchangeInfo.Num).toString();
            }
            else
            {
               _countText.text = (_gooodsExchangeInfo.ItemCount * _gooodsExchangeInfo.Num).toString();
            }
         }
         _haveCountTemp = _haveCount;
         super(_bg,_info);
         addChild(_countText);
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         var array:Array = PlayerManager.Instance.Self.Bag.findItemsByTempleteID(_gooodsExchangeInfo.TemplateID);
         if(array.length == 0)
         {
            array = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_gooodsExchangeInfo.TemplateID);
         }
         if(array.length == 0)
         {
            array = PlayerManager.Instance.Self.BeadBag.findItemsByTempleteID(_gooodsExchangeInfo.TemplateID);
         }
         return array[0];
      }
      
      private function intEvent() : void
      {
         PlayerManager.Instance.Self.Bag.addEventListener("update",__updateCount);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__updateCount);
         PlayerManager.Instance.Self.Bag.addEventListener("afterDel",__updateCount);
         PlayerManager.Instance.Self.PropBag.addEventListener("afterDel",__updateCount);
      }
      
      protected function __updateCount(event:BagEvent) : void
      {
         var evt:* = null;
         if(!_gooodsExchangeInfo)
         {
            return;
         }
         var tempId:int = _gooodsExchangeInfo.TemplateID;
         var itemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_gooodsExchangeInfo.TemplateID);
         var item:InventoryItemInfo = new InventoryItemInfo();
         item.TemplateID = itemInfo.TemplateID;
         ItemManager.fill(item);
         item.StrengthenLevel = _gooodsExchangeInfo.LimitValue;
         item.IsBinds = true;
         item.isShowBind = _type != true;
         if(item.CanStrengthen)
         {
            _haveCount = PlayerManager.Instance.Self.findItemCount(tempId,_gooodsExchangeInfo.LimitValue);
         }
         else
         {
            _haveCount = PlayerManager.Instance.Self.findItemCount(tempId);
         }
         if(_haveCount == 0)
         {
            _haveCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(tempId);
         }
         if(_haveCount == 0)
         {
            _haveCount = PlayerManager.Instance.Self.BeadBag.getItemCountByTemplateId(tempId);
         }
         if(!_countText)
         {
            _countText = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.cellCount");
            addChild(_countText);
         }
         if(_haveCountTemp != _haveCount)
         {
            _haveCountTemp = _haveCount;
            evt = new ActivityEvent(ActivityEvent.UPDATE_COUNT);
            evt.id = _id;
            dispatchEvent(evt);
         }
         if(_type)
         {
            _countText.text = _haveCount.toString() + "/" + (_gooodsExchangeInfo.ItemCount * 1).toString();
         }
         else
         {
            _countText.text = (_gooodsExchangeInfo.ItemCount * 1).toString();
         }
      }
      
      public function get haveCount() : int
      {
         return _haveCount;
      }
      
      public function get needCount() : int
      {
         _needCount = int(haveCount / _gooodsExchangeInfo.ItemCount);
         return int(haveCount / _gooodsExchangeInfo.ItemCount);
      }
      
      public function get gooodsExchangeInfo() : GoodsExchangeInfo
      {
         return _gooodsExchangeInfo;
      }
      
      override public function dispose() : void
      {
         PlayerManager.Instance.Self.Bag.removeEventListener("update",__updateCount);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__updateCount);
         PlayerManager.Instance.Self.Bag.removeEventListener("afterDel",__updateCount);
         PlayerManager.Instance.Self.PropBag.removeEventListener("afterDel",__updateCount);
         super.dispose();
         if(_countText)
         {
            ObjectUtils.disposeObject(_countText);
         }
         _countText = null;
      }
   }
}
