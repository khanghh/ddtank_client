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
      
      public function ExchangeGoodsCell(exchangeInfo:GiftRewardInfo, activeType:int = -1, type:Boolean = true, id:int = -1, num:int = 1)
      {
         var itemInfo:* = null;
         var item:* = null;
         var attrArr:* = null;
         var tempId:int = 0;
         intEvent();
         _gooodsExchangeInfo = exchangeInfo;
         _type = type;
         _id = id;
         _num = num;
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
            itemInfo = ItemManager.Instance.getTemplateById(_gooodsExchangeInfo.templateId);
            item = new InventoryItemInfo();
            item.TemplateID = itemInfo.TemplateID;
            ItemManager.fill(item);
            attrArr = _gooodsExchangeInfo.property.split(",");
            item.StrengthenLevel = parseInt(attrArr[0]);
            item.AttackCompose = parseInt(attrArr[1]);
            item.DefendCompose = parseInt(attrArr[2]);
            item.AgilityCompose = parseInt(attrArr[3]);
            item.LuckCompose = parseInt(attrArr[4]);
            if(EquipType.isMagicStone(item.CategoryID))
            {
               item.Level = item.StrengthenLevel;
               item.Attack = item.AttackCompose;
               item.Defence = item.DefendCompose;
               item.Agility = item.AgilityCompose;
               item.Luck = item.LuckCompose;
               item.MagicAttack = parseInt(attrArr[6]);
               item.MagicDefence = parseInt(attrArr[7]);
               item.StrengthenExp = parseInt(attrArr[8]);
            }
            item.IsBinds = true;
            item.isShowBind = _type != true;
            _info = item;
            if(_type)
            {
               tempId = exchangeInfo.templateId;
               if(item.CanStrengthen)
               {
                  _haveCount = PlayerManager.Instance.Self.findItemCount(tempId,item.StrengthenLevel);
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
               _countText.text = _haveCount.toString() + "/" + (_gooodsExchangeInfo.count * _num).toString();
            }
            else
            {
               _countText.text = (_gooodsExchangeInfo.count * _num).toString();
            }
         }
         _haveCountTemp = _haveCount;
         super(_bg,_info);
         addChild(_countText);
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         var array:Array = PlayerManager.Instance.Self.Bag.findItemsByTempleteID(_gooodsExchangeInfo.templateId);
         if(array.length == 0)
         {
            array = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_gooodsExchangeInfo.templateId);
         }
         if(array.length == 0)
         {
            array = PlayerManager.Instance.Self.BeadBag.findItemsByTempleteID(_gooodsExchangeInfo.templateId);
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
      
      private function __updateCount(event:BagEvent) : void
      {
         var evt:* = null;
         if(!_gooodsExchangeInfo)
         {
            return;
         }
         var tempId:int = _gooodsExchangeInfo.templateId;
         var itemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_gooodsExchangeInfo.templateId);
         var item:InventoryItemInfo = new InventoryItemInfo();
         item.TemplateID = itemInfo.TemplateID;
         ItemManager.fill(item);
         var attrArr:Array = _gooodsExchangeInfo.property.split(",");
         item.StrengthenLevel = parseInt(attrArr[0]);
         item.AttackCompose = parseInt(attrArr[1]);
         item.DefendCompose = parseInt(attrArr[2]);
         item.AgilityCompose = parseInt(attrArr[3]);
         item.LuckCompose = parseInt(attrArr[4]);
         item.IsBinds = true;
         item.isShowBind = _type != true;
         if(item.CanStrengthen)
         {
            _haveCount = PlayerManager.Instance.Self.findItemCount(tempId,item.StrengthenLevel);
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
            _countText.text = _haveCount.toString() + "/" + (_gooodsExchangeInfo.count * 1).toString();
         }
         else
         {
            _countText.text = (_gooodsExchangeInfo.count * 1).toString();
         }
      }
      
      public function get haveCount() : int
      {
         return _haveCount;
      }
      
      public function get needCount() : int
      {
         _needCount = int(haveCount / _gooodsExchangeInfo.count);
         return int(haveCount / _gooodsExchangeInfo.count);
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
