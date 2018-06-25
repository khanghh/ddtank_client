package store.view.exalt
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.view.tips.GoodTipInfo;
   import store.view.strength.LaterEquipmentView;
   import store.view.strength.StrengthTips;
   import store.view.strength.manager.ItemStrengthenGoodsInfoManager;
   import store.view.strength.vo.ItemStrengthenGoodsInfo;
   
   public class ExaltTips extends StrengthTips
   {
       
      
      public function ExaltTips()
      {
         super();
      }
      
      override protected function laterEquipment(goodTipInfo:GoodTipInfo) : void
      {
         var itemStrengthenGoodsInfo:* = null;
         var itemTemplateInfo:* = null;
         if(syahTip != null)
         {
            syahTip.visible = false;
         }
         if(_laterEquipmentGoodView.visible)
         {
            _laterEquipmentGoodView.visible = false;
         }
         var tInfo:InventoryItemInfo = null;
         var tGoodTipInfo:GoodTipInfo = null;
         var itemInfo:InventoryItemInfo = null;
         if(goodTipInfo)
         {
            itemInfo = goodTipInfo.itemInfo as InventoryItemInfo;
         }
         if(itemInfo && itemInfo.StrengthenLevel < 15)
         {
            tGoodTipInfo = new GoodTipInfo();
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            tInfo.StrengthenLevel = tInfo.StrengthenLevel + 1;
            if(!tInfo.isGold)
            {
               itemStrengthenGoodsInfo = ItemStrengthenGoodsInfoManager.findItemStrengthenGoodsInfo(tInfo.TemplateID,tInfo.StrengthenLevel);
               if(itemStrengthenGoodsInfo)
               {
                  tInfo.TemplateID = itemStrengthenGoodsInfo.GainEquip;
                  itemTemplateInfo = ItemManager.Instance.getTemplateById(tInfo.TemplateID);
                  if(itemTemplateInfo)
                  {
                     tInfo.Attack = itemTemplateInfo.Attack;
                     tInfo.Defence = itemTemplateInfo.Defence;
                     tInfo.Agility = itemTemplateInfo.Agility;
                     tInfo.Luck = itemTemplateInfo.Luck;
                  }
               }
            }
            tGoodTipInfo.itemInfo = tInfo;
            if(!_laterEquipmentView)
            {
               _laterEquipmentView = new LaterEquipmentView();
            }
            _laterEquipmentView.x = _tipbackgound.x + _tipbackgound.width + 35;
            if(!this.contains(_laterEquipmentView))
            {
               addChild(_laterEquipmentView);
            }
            _laterEquipmentView.tipData = tGoodTipInfo;
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
   }
}
