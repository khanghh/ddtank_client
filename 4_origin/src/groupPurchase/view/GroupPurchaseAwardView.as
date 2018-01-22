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
         var _loc1_:int = 0;
         super();
         _awardList = GroupPurchaseManager.instance.awardInfoList;
         _loc1_ = 1;
         while(_loc1_ <= 12)
         {
            createAwardCell(_loc1_);
            _loc1_++;
         }
      }
      
      private function createAwardCell(param1:int) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:GroupPurchaseAwardInfo = _awardList[param1];
         if(_loc2_)
         {
            _loc4_ = new BagCell(1,null,true,null,false);
            _loc4_.tipGapH = 0;
            _loc4_.tipGapV = 0;
            _loc3_ = new InventoryItemInfo();
            _loc3_.TemplateID = _loc2_.TemplateID;
            ItemManager.fill(_loc3_);
            _loc3_.StrengthenLevel = _loc2_.StrengthenLevel;
            _loc3_.AttackCompose = _loc2_.AttackCompose;
            _loc3_.DefendCompose = _loc2_.DefendCompose;
            _loc3_.LuckCompose = _loc2_.LuckCompose;
            _loc3_.AgilityCompose = _loc2_.AgilityCompose;
            _loc3_.IsBinds = _loc2_.IsBind;
            _loc3_.ValidDate = _loc2_.ValidDate;
            _loc3_.Count = _loc2_.Count;
            _loc4_.info = _loc3_;
            PositionUtils.setPos(_loc4_,"groupPurchase.awardCellPos" + param1);
            addChild(_loc4_);
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
