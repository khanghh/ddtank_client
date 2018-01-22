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
      
      public function PanicBuyingCell(param1:int, param2:ItemTemplateInfo, param3:int, param4:int)
      {
         _buyType = param3;
         _expireTime = param4;
         super(param1,param2);
      }
      
      override protected function setDefaultTipData() : void
      {
         var _loc1_:* = null;
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
            _loc1_ = _info as InventoryItemInfo;
            if(_info.Property1 == "31")
            {
               if(_loc1_ && _loc1_.Hole2 > 0)
               {
                  GoodTipInfo(_tipData).exp = _loc1_.Hole2;
                  GoodTipInfo(_tipData).upExp = ServerConfigManager.instance.getBeadUpgradeExp()[_loc1_.Hole1 + 1];
                  GoodTipInfo(_tipData).beadName = _loc1_.Name + "-" + beadSystemManager.Instance.getBeadName(_loc1_);
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
               if(_loc1_ && _loc1_.StrengthenExp > 0)
               {
                  GoodTipInfo(_tipData).exp = _loc1_.StrengthenExp - MagicStoneManager.instance.getNeedExp(info.TemplateID,_loc1_.StrengthenLevel);
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
