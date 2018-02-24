package store.fineStore.view
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.PlayerManager;
   import ddt.view.tips.GoodTipInfo;
   import store.equipGhost.EquipGhostManager;
   import store.equipGhost.data.EquipGhostData;
   import store.view.strength.LaterEquipmentView;
   import store.view.strength.StrengthTips;
   
   public class GhostTips extends StrengthTips
   {
       
      
      public function GhostTips(){super();}
      
      private function clearNextTip() : void{}
      
      override protected function laterEquipment(param1:GoodTipInfo) : void{}
   }
}
