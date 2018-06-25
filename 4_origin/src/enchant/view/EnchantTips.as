package enchant.view
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.view.tips.GoodTipInfo;
   import enchant.EnchantManager;
   import store.view.strength.LaterEquipmentView;
   import store.view.strength.StrengthTips;
   
   public class EnchantTips extends StrengthTips
   {
       
      
      public function EnchantTips()
      {
         super();
      }
      
      override protected function laterEquipment(goodTipInfo:GoodTipInfo) : void
      {
         var tInfo:InventoryItemInfo = null;
         var tGoodTipInfo:GoodTipInfo = null;
         var itemInfo:InventoryItemInfo = null;
         if(goodTipInfo)
         {
            itemInfo = goodTipInfo.itemInfo as InventoryItemInfo;
         }
         if(itemInfo && itemInfo.MagicLevel < EnchantManager.instance.infoVec.length)
         {
            tGoodTipInfo = new GoodTipInfo();
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            tInfo.MagicLevel = tInfo.MagicLevel + 1;
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
