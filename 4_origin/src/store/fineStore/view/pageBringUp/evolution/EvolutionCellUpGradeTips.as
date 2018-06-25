package store.fineStore.view.pageBringUp.evolution
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import store.FineEvolutionManager;
   import store.data.EvolutionData;
   
   public class EvolutionCellUpGradeTips extends GoodTip
   {
       
      
      private var _upgradeBeadTip:GoodTip;
      
      public function EvolutionCellUpGradeTips()
      {
         super();
      }
      
      override public function set tipData(data:Object) : void
      {
         .super.tipData = data;
         evolutionUpgradTip(data as GoodTipInfo);
      }
      
      private function evolutionUpgradTip(pTipInfo:GoodTipInfo) : void
      {
         var data:* = null;
         var _rightArrows:* = null;
         var tInfo:InventoryItemInfo = null;
         var tGoodTipInfo:GoodTipInfo = null;
         var itemInfo:InventoryItemInfo = null;
         if(pTipInfo)
         {
            itemInfo = pTipInfo.itemInfo as InventoryItemInfo;
         }
         if(itemInfo)
         {
            tGoodTipInfo = new GoodTipInfo();
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            data = FineEvolutionManager.Instance.GetEvolutionDataByExp(tInfo.curExp);
            if(data)
            {
               if(data.isMax == false)
               {
                  tInfo.curExp = FineEvolutionManager.Instance.EvolutionDataByLv(data.Level + 1).Exp;
               }
               else
               {
                  tInfo.curExp = data.Exp;
               }
            }
            else
            {
               tInfo.curExp = FineEvolutionManager.Instance.EvolutionDataByLv(1).Exp;
            }
            tGoodTipInfo.itemInfo = tInfo;
            tGoodTipInfo.beadName = ItemManager.Instance.getTemplateById(tInfo.TemplateID).Name;
            if(!_upgradeBeadTip)
            {
               _upgradeBeadTip = new GoodTip();
            }
            _upgradeBeadTip.tipData = tGoodTipInfo;
            _upgradeBeadTip.x = _tipbackgound.x + _tipbackgound.width + 25;
            if(!this.contains(_upgradeBeadTip))
            {
               addChild(_upgradeBeadTip);
            }
            _rightArrows = ComponentFactory.Instance.creatBitmap("asset.ddtstore.rightArrows");
            _rightArrows.x = _tipbackgound.x + _tipbackgound.width - 20;
            _rightArrows.y = 90;
            addChild(_rightArrows);
         }
         else
         {
            if(_upgradeBeadTip)
            {
               ObjectUtils.disposeObject(_upgradeBeadTip);
            }
            _upgradeBeadTip = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_upgradeBeadTip)
         {
            ObjectUtils.disposeObject(_upgradeBeadTip);
         }
         _upgradeBeadTip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
