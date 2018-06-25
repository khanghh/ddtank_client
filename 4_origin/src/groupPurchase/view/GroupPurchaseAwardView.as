package groupPurchase.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import groupPurchase.GroupPurchaseManager;
   import groupPurchase.data.GroupPurchaseAwardInfo;
   
   public class GroupPurchaseAwardView extends Sprite implements Disposeable
   {
       
      
      private var _awardList:Object;
      
      public function GroupPurchaseAwardView()
      {
         var i:int = 0;
         super();
         _awardList = GroupPurchaseManager.instance.awardInfoList;
         for(i = 1; i <= 12; )
         {
            createAwardCell(i);
            i++;
         }
      }
      
      private function createAwardCell(index:int) : void
      {
         var awardCell:* = null;
         var itemInfo:* = null;
         var awardInfo:GroupPurchaseAwardInfo = _awardList[index];
         if(awardInfo)
         {
            awardCell = new BagCell(1,null,true,null,false);
            awardCell.tipGapH = 0;
            awardCell.tipGapV = 0;
            itemInfo = new InventoryItemInfo();
            itemInfo.TemplateID = awardInfo.TemplateID;
            ItemManager.fill(itemInfo);
            itemInfo.StrengthenLevel = awardInfo.StrengthenLevel;
            itemInfo.AttackCompose = awardInfo.AttackCompose;
            itemInfo.DefendCompose = awardInfo.DefendCompose;
            itemInfo.LuckCompose = awardInfo.LuckCompose;
            itemInfo.AgilityCompose = awardInfo.AgilityCompose;
            itemInfo.IsBinds = awardInfo.IsBind;
            itemInfo.ValidDate = awardInfo.ValidDate;
            itemInfo.Count = awardInfo.Count;
            awardCell.info = itemInfo;
            PositionUtils.setPos(awardCell,"groupPurchase.awardCellPos" + index);
            addChild(awardCell);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _awardList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
