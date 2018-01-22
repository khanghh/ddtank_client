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
      
      public function ExchangeGoodsCell(param1:GiftRewardInfo, param2:int = -1, param3:Boolean = true, param4:int = -1, param5:int = 1)
      {
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         intEvent();
         _gooodsExchangeInfo = param1;
         _type = param3;
         _id = param4;
         _num = param5;
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
            _loc8_ = ItemManager.Instance.getTemplateById(_gooodsExchangeInfo.templateId);
            _loc6_ = new InventoryItemInfo();
            _loc6_.TemplateID = _loc8_.TemplateID;
            ItemManager.fill(_loc6_);
            _loc7_ = _gooodsExchangeInfo.property.split(",");
            _loc6_.StrengthenLevel = parseInt(_loc7_[0]);
            _loc6_.AttackCompose = parseInt(_loc7_[1]);
            _loc6_.DefendCompose = parseInt(_loc7_[2]);
            _loc6_.AgilityCompose = parseInt(_loc7_[3]);
            _loc6_.LuckCompose = parseInt(_loc7_[4]);
            if(EquipType.isMagicStone(_loc6_.CategoryID))
            {
               _loc6_.Level = _loc6_.StrengthenLevel;
               _loc6_.Attack = _loc6_.AttackCompose;
               _loc6_.Defence = _loc6_.DefendCompose;
               _loc6_.Agility = _loc6_.AgilityCompose;
               _loc6_.Luck = _loc6_.LuckCompose;
               _loc6_.MagicAttack = parseInt(_loc7_[6]);
               _loc6_.MagicDefence = parseInt(_loc7_[7]);
               _loc6_.StrengthenExp = parseInt(_loc7_[8]);
            }
            _loc6_.IsBinds = true;
            _loc6_.isShowBind = _type != true;
            _info = _loc6_;
            if(_type)
            {
               _loc9_ = param1.templateId;
               if(_loc6_.CanStrengthen)
               {
                  _haveCount = PlayerManager.Instance.Self.findItemCount(_loc9_,_loc6_.StrengthenLevel);
               }
               else
               {
                  _haveCount = PlayerManager.Instance.Self.findItemCount(_loc9_);
               }
               if(_haveCount == 0)
               {
                  _haveCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_loc9_);
               }
               if(_haveCount == 0)
               {
                  _haveCount = PlayerManager.Instance.Self.BeadBag.getItemCountByTemplateId(_loc9_);
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
         var _loc1_:Array = PlayerManager.Instance.Self.Bag.findItemsByTempleteID(_gooodsExchangeInfo.templateId);
         if(_loc1_.length == 0)
         {
            _loc1_ = PlayerManager.Instance.Self.PropBag.findItemsByTempleteID(_gooodsExchangeInfo.templateId);
         }
         if(_loc1_.length == 0)
         {
            _loc1_ = PlayerManager.Instance.Self.BeadBag.findItemsByTempleteID(_gooodsExchangeInfo.templateId);
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
      
      private function __updateCount(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         if(!_gooodsExchangeInfo)
         {
            return;
         }
         var _loc6_:int = _gooodsExchangeInfo.templateId;
         var _loc5_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_gooodsExchangeInfo.templateId);
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.TemplateID = _loc5_.TemplateID;
         ItemManager.fill(_loc3_);
         var _loc4_:Array = _gooodsExchangeInfo.property.split(",");
         _loc3_.StrengthenLevel = parseInt(_loc4_[0]);
         _loc3_.AttackCompose = parseInt(_loc4_[1]);
         _loc3_.DefendCompose = parseInt(_loc4_[2]);
         _loc3_.AgilityCompose = parseInt(_loc4_[3]);
         _loc3_.LuckCompose = parseInt(_loc4_[4]);
         _loc3_.IsBinds = true;
         _loc3_.isShowBind = _type != true;
         if(_loc3_.CanStrengthen)
         {
            _haveCount = PlayerManager.Instance.Self.findItemCount(_loc6_,_loc3_.StrengthenLevel);
         }
         else
         {
            _haveCount = PlayerManager.Instance.Self.findItemCount(_loc6_);
         }
         if(_haveCount == 0)
         {
            _haveCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_loc6_);
         }
         if(_haveCount == 0)
         {
            _haveCount = PlayerManager.Instance.Self.BeadBag.getItemCountByTemplateId(_loc6_);
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
