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
      
      public function initView(index:int) : void
      {
         this.index = index;
         _bg = ComponentFactory.Instance.creat("wonderful.accumulative.itemBG");
         addChild(_bg);
         _bagCell = new BagCell(index);
         PositionUtils.setPos(_bagCell,"wonderful.Accumulative.bagCellPos");
         _bagCell.visible = false;
         addChild(_bagCell);
      }
      
      public function setCellData(gift:GiftRewardInfo) : void
      {
         if(!gift)
         {
            _bagCell.visible = false;
            return;
         }
         _bagCell.visible = true;
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = gift.templateId;
         info = ItemManager.fill(info);
         info.IsBinds = gift.isBind;
         info.ValidDate = gift.validDate;
         var attrArr:Array = gift.property.split(",");
         info.StrengthenLevel = parseInt(attrArr[0]);
         info.AttackCompose = parseInt(attrArr[1]);
         info.DefendCompose = parseInt(attrArr[2]);
         info.AgilityCompose = parseInt(attrArr[3]);
         info.LuckCompose = parseInt(attrArr[4]);
         if(EquipType.isMagicStone(info.CategoryID))
         {
            info.Level = info.StrengthenLevel;
            info.Attack = info.AttackCompose;
            info.Defence = info.DefendCompose;
            info.Agility = info.AgilityCompose;
            info.Luck = info.LuckCompose;
            info.MagicAttack = parseInt(attrArr[6]);
            info.MagicDefence = parseInt(attrArr[7]);
            info.StrengthenExp = parseInt(attrArr[8]);
         }
         _bagCell.info = info;
         _bagCell.setCount(gift.count);
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
