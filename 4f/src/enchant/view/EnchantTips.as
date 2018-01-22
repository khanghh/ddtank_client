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
       
      
      public function EnchantTips(){super();}
      
      override protected function laterEquipment(param1:GoodTipInfo) : void{}
   }
}
