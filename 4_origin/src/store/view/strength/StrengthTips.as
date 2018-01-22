package store.view.strength
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   import store.view.strength.manager.ItemStrengthenGoodsInfoManager;
   import store.view.strength.vo.ItemStrengthenGoodsInfo;
   
   public class StrengthTips extends GoodTip
   {
       
      
      protected var _laterEquipmentView:LaterEquipmentView;
      
      public function StrengthTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
      }
      
      override public function set tipData(param1:Object) : void
      {
         .super.tipData = param1;
         laterEquipment(param1 as GoodTipInfo);
      }
      
      override public function showTip(param1:ItemTemplateInfo, param2:Boolean = false) : void
      {
         super.showTip(param1,param2);
      }
      
      protected function laterEquipment(param1:GoodTipInfo) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         if(syahTip != null)
         {
            syahTip.visible = false;
         }
         if(_laterEquipmentGoodView.visible)
         {
            _laterEquipmentGoodView.visible = false;
         }
         var _loc3_:InventoryItemInfo = null;
         var _loc2_:GoodTipInfo = null;
         var _loc5_:InventoryItemInfo = null;
         if(param1)
         {
            _loc5_ = param1.itemInfo as InventoryItemInfo;
         }
         if(_loc5_ && _loc5_.StrengthenLevel < 12)
         {
            _loc2_ = new GoodTipInfo();
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc5_);
            _loc3_.StrengthenLevel = _loc3_.StrengthenLevel + 1;
            _loc6_ = ItemStrengthenGoodsInfoManager.findItemStrengthenGoodsInfo(_loc3_.TemplateID,_loc3_.StrengthenLevel);
            if(_loc6_)
            {
               _loc3_.TemplateID = _loc6_.GainEquip;
               _loc4_ = ItemManager.Instance.getTemplateById(_loc3_.TemplateID);
               if(_loc4_)
               {
                  _loc3_.Attack = _loc4_.Attack;
                  _loc3_.Defence = _loc4_.Defence;
                  _loc3_.Agility = _loc4_.Agility;
                  _loc3_.Luck = _loc4_.Luck;
               }
            }
            _loc2_.itemInfo = _loc3_;
            if(!_laterEquipmentView)
            {
               _laterEquipmentView = new LaterEquipmentView();
            }
            _laterEquipmentView.x = _tipbackgound.x + _tipbackgound.width + 35;
            if(!this.contains(_laterEquipmentView))
            {
               addChild(_laterEquipmentView);
            }
            _laterEquipmentView.tipData = _loc2_;
         }
         else
         {
            if(_laterEquipmentView)
            {
               ObjectUtils.disposeObject(_laterEquipmentView);
            }
            _laterEquipmentView = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_laterEquipmentView)
         {
            ObjectUtils.disposeObject(_laterEquipmentView);
         }
         _laterEquipmentView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
