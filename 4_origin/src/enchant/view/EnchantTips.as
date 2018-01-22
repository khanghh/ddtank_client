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
      
      override protected function laterEquipment(param1:GoodTipInfo) : void
      {
         var _loc3_:InventoryItemInfo = null;
         var _loc2_:GoodTipInfo = null;
         var _loc4_:InventoryItemInfo = null;
         if(param1)
         {
            _loc4_ = param1.itemInfo as InventoryItemInfo;
         }
         if(_loc4_ && _loc4_.MagicLevel < EnchantManager.instance.infoVec.length)
         {
            _loc2_ = new GoodTipInfo();
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc4_);
            _loc3_.MagicLevel = _loc3_.MagicLevel + 1;
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
   }
}
