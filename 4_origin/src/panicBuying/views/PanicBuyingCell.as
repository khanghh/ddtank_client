package panicBuying.views
{
   import bagAndInfo.cell.BagCell;
   import beadSystem.beadSystemManager;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ServerConfigManager;
   import ddt.view.tips.GoodTipInfo;
   import magicStone.MagicStoneManager;
   
   public class PanicBuyingCell extends BagCell
   {
       
      
      private var _expireTime:int;
      
      private var _buyType:int;
      
      public function PanicBuyingCell(index:int, info:ItemTemplateInfo, buyType:int, expireTime:int)
      {
         _buyType = buyType;
         _expireTime = expireTime;
         super(index,info);
      }
      
      override protected function setDefaultTipData() : void
      {
         var vItemInfo:* = null;
         if(EquipType.isCardBox(_info))
         {
            tipStyle = "core.CardBoxTipPanel";
            tipData = _info;
         }
         else if(_info.CategoryID != 26)
         {
            tipStyle = "panicBuying.views.PanicBuyingTips";
            _tipData = new GoodTipInfo();
            GoodTipInfo(_tipData).itemInfo = _info;
            GoodTipInfo(_tipData).buyType = _buyType;
            GoodTipInfo(_tipData).expireTime = _expireTime;
            vItemInfo = _info as InventoryItemInfo;
            if(_info.Property1 == "31")
            {
               if(vItemInfo && vItemInfo.Hole2 > 0)
               {
                  GoodTipInfo(_tipData).exp = vItemInfo.Hole2;
                  GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[vItemInfo.Hole1 + 1];
                  GoodTipInfo(_tipData).beadName = vItemInfo.Name + "-" + beadSystemManager.Instance.getBeadName(vItemInfo);
               }
               else
               {
                  GoodTipInfo(_tipData).exp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID).BaseLevel];
                  GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID).BaseLevel + 1];
                  GoodTipInfo(_tipData).beadName = _info.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(_info.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(info.TemplateID).BaseLevel;
               }
            }
            else if(info.Property1 == "81")
            {
               if(vItemInfo && vItemInfo.StrengthenExp > 0)
               {
                  GoodTipInfo(_tipData).exp = vItemInfo.StrengthenExp - MagicStoneManager.instance.getNeedExp(info.TemplateID,vItemInfo.StrengthenLevel);
               }
               else
               {
                  GoodTipInfo(_tipData).exp = 0;
               }
               GoodTipInfo(_tipData).upExp = MagicStoneManager.instance.getNeedExpPerLevel(info.TemplateID,info.Level + 1);
               GoodTipInfo(_tipData).beadName = info.Name + "Lv" + info.Level;
            }
         }
      }
   }
}
