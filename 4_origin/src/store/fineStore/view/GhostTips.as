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
       
      
      public function GhostTips()
      {
         super();
      }
      
      private function clearNextTip() : void
      {
         if(_laterEquipmentView)
         {
            ObjectUtils.disposeObject(_laterEquipmentView);
         }
         _laterEquipmentView = null;
      }
      
      override protected function laterEquipment(param1:GoodTipInfo) : void
      {
         var _loc4_:* = 0;
         var _loc7_:* = null;
         var _loc3_:* = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc5_:InventoryItemInfo = null;
         if(param1)
         {
            _loc5_ = param1.itemInfo as InventoryItemInfo;
         }
         if(_loc5_ == null)
         {
            clearNextTip();
         }
         else
         {
            _loc4_ = uint(0);
            _loc7_ = PlayerManager.Instance.Self.getGhostDataByCategoryID(_loc5_.CategoryID);
            if(_loc7_)
            {
               _loc4_ = uint(_loc7_.level);
            }
            _loc3_ = uint(EquipGhostManager.getInstance().model.topLvDic[_loc5_.CategoryID]);
            if(_loc4_ >= _loc3_)
            {
               clearNextTip();
            }
            else
            {
               _loc6_ = new GoodTipInfo();
               _loc2_ = new InventoryItemInfo();
               ObjectUtils.copyProperties(_loc2_,_loc5_);
               _loc6_.ghostLv = _loc4_ + 1;
               _loc6_.itemInfo = _loc2_;
               if(!_laterEquipmentView)
               {
                  _laterEquipmentView = new LaterEquipmentView();
               }
               _laterEquipmentView.x = _tipbackgound.x + _tipbackgound.width + 35;
               if(!this.contains(_laterEquipmentView))
               {
                  addChild(_laterEquipmentView);
               }
               _laterEquipmentView.tipData = _loc6_;
            }
         }
      }
   }
}
