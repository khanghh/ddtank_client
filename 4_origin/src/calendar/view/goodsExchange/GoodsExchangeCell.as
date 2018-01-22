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
      
      public function GoodsExchangeCell(param1:GoodsExchangeInfo, param2:int = -1, param3:Boolean = true, param4:int = -1)
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         intEvent();
         _gooodsExchangeInfo = param1;
         _type = param3;
         _id = param4;
         if(param1 && (param2 == 3 || param2 == 4))
         {
            if(param2 == 4)
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
            _loc6_ = ItemManager.Instance.getTemplateById(_gooodsExchangeInfo.TemplateID);
            _loc5_ = new InventoryItemInfo();
            _loc5_.TemplateID = _loc6_.TemplateID;
            ItemManager.fill(_loc5_);
            _loc5_.StrengthenLevel = _gooodsExchangeInfo.LimitValue;
            _loc5_.IsBinds = true;
            _loc5_.isShowBind = _type != true;
            _info = _loc5_;
            if(_type)
            {
               _loc7_ = param1.TemplateID;
               if(_loc5_.CanStrengthen)
               {
                  _haveCount = PlayerManager.Instance.Self.findItemCount(_loc7_,_gooodsExchangeInfo.LimitValue);
               }
               else
               {
                  _haveCount = PlayerManager.Instance.Self.findItemCount(_loc7_);
               }
               if(_haveCount == 0)
               {
                  _haveCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_loc7_);
               }
               if(_haveCount == 0)
               {
                  _haveCount = PlayerManager.Instance.Self.BeadBag.getItemCountByTemplateId(_loc7_);
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
         var _loc1_:Array = PlayerManager.Instance.Self.Bag.findItemsByTempleteID(_gooodsExchangeInfo.TemplateID);
         if(_loc1_.length == 0)
         {
            _loc1_ = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_gooodsExchangeInfo.TemplateID);
         }
         if(_loc1_.length == 0)
         {
            _loc1_ = PlayerManager.Instance.Self.BeadBag.findItemsByTempleteID(_gooodsExchangeInfo.TemplateID);
         }
         return _loc1_[0];
      }
      
      private function intEvent() : void
      {
         PlayerManager.Instance.Self.Bag.addEventListener("update",__updateCount);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__updateCount);
         PlayerManager.Instance.Self.Bag.addEventListener("afterDel",__updateCount);
         PlayerManager.Instance.Self.PropBag.addEventListener("afterDel",__updateCount);
      }
      
      protected function __updateCount(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         if(!_gooodsExchangeInfo)
         {
            return;
         }
         var _loc5_:int = _gooodsExchangeInfo.TemplateID;
         var _loc4_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_gooodsExchangeInfo.TemplateID);
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.TemplateID = _loc4_.TemplateID;
         ItemManager.fill(_loc3_);
         _loc3_.StrengthenLevel = _gooodsExchangeInfo.LimitValue;
         _loc3_.IsBinds = true;
         _loc3_.isShowBind = _type != true;
         if(_loc3_.CanStrengthen)
         {
            _haveCount = PlayerManager.Instance.Self.findItemCount(_loc5_,_gooodsExchangeInfo.LimitValue);
         }
         else
         {
            _haveCount = PlayerManager.Instance.Self.findItemCount(_loc5_);
         }
         if(_haveCount == 0)
         {
            _haveCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_loc5_);
         }
         if(_haveCount == 0)
         {
            _haveCount = PlayerManager.Instance.Self.BeadBag.getItemCountByTemplateId(_loc5_);
         }
         if(!_countText)
         {
            _countText = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.cellCount");
            addChild(_countText);
         }
         if(_haveCountTemp != _haveCount)
         {
            _haveCountTemp = _haveCount;
            _loc2_ = new ActivityEvent(ActivityEvent.UPDATE_COUNT);
            _loc2_.id = _id;
            dispatchEvent(_loc2_);
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
