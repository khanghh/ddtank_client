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
      
      override protected function laterEquipment(goodTipInfo:GoodTipInfo) : void
      {
         var curGhostLv:* = 0;
         var equipGhost:* = null;
         var maxLv:* = 0;
         var nextTipInfo:* = null;
         var nextData:* = null;
         var curData:InventoryItemInfo = null;
         if(goodTipInfo)
         {
            curData = goodTipInfo.itemInfo as InventoryItemInfo;
         }
         if(curData == null)
         {
            clearNextTip();
         }
         else
         {
            curGhostLv = uint(0);
            equipGhost = PlayerManager.Instance.Self.getGhostDataByCategoryID(curData.CategoryID);
            if(equipGhost)
            {
               curGhostLv = uint(equipGhost.level);
            }
            maxLv = uint(EquipGhostManager.getInstance().model.topLvDic[curData.CategoryID]);
            if(curGhostLv >= maxLv)
            {
               clearNextTip();
            }
            else
            {
               nextTipInfo = new GoodTipInfo();
               nextData = new InventoryItemInfo();
               ObjectUtils.copyProperties(nextData,curData);
               nextTipInfo.ghostLv = curGhostLv + 1;
               nextTipInfo.itemInfo = nextData;
               if(!_laterEquipmentView)
               {
                  _laterEquipmentView = new LaterEquipmentView();
               }
               _laterEquipmentView.x = _tipbackgound.x + _tipbackgound.width + 35;
               if(!this.contains(_laterEquipmentView))
               {
                  addChild(_laterEquipmentView);
               }
               _laterEquipmentView.tipData = nextTipInfo;
            }
         }
      }
   }
}
