package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class PrizeListItem extends Sprite implements Disposeable
   {
       
      
      private var index:int;
      
      private var _bg:Bitmap;
      
      private var _bagCell:BagCell;
      
      public function PrizeListItem()
      {
         super();
      }
      
      public function initView(param1:int) : void
      {
         this.index = param1;
         _bg = ComponentFactory.Instance.creat("wonderful.accumulative.itemBG");
         addChild(_bg);
         _bagCell = new BagCell(param1);
         PositionUtils.setPos(_bagCell,"wonderful.Accumulative.bagCellPos");
         _bagCell.visible = false;
         addChild(_bagCell);
      }
      
      public function setCellData(param1:GiftRewardInfo) : void
      {
         if(!param1)
         {
            _bagCell.visible = false;
            return;
         }
         _bagCell.visible = true;
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.TemplateID = param1.templateId;
         _loc3_ = ItemManager.fill(_loc3_);
         _loc3_.IsBinds = param1.isBind;
         _loc3_.ValidDate = param1.validDate;
         var _loc2_:Array = param1.property.split(",");
         _loc3_.StrengthenLevel = parseInt(_loc2_[0]);
         _loc3_.AttackCompose = parseInt(_loc2_[1]);
         _loc3_.DefendCompose = parseInt(_loc2_[2]);
         _loc3_.AgilityCompose = parseInt(_loc2_[3]);
         _loc3_.LuckCompose = parseInt(_loc2_[4]);
         if(EquipType.isMagicStone(_loc3_.CategoryID))
         {
            _loc3_.Level = _loc3_.StrengthenLevel;
            _loc3_.Attack = _loc3_.AttackCompose;
            _loc3_.Defence = _loc3_.DefendCompose;
            _loc3_.Agility = _loc3_.AgilityCompose;
            _loc3_.Luck = _loc3_.LuckCompose;
            _loc3_.MagicAttack = parseInt(_loc2_[6]);
            _loc3_.MagicDefence = parseInt(_loc2_[7]);
            _loc3_.StrengthenExp = parseInt(_loc2_[8]);
         }
         _bagCell.info = _loc3_;
         _bagCell.setCount(param1.count);
         _bagCell.setBgVisible(false);
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_bagCell)
         {
            ObjectUtils.disposeObject(_bagCell);
         }
         _bagCell = null;
      }
   }
}
