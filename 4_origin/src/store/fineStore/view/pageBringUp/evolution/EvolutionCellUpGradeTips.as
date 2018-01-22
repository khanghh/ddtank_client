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
      
      override public function set tipData(param1:Object) : void
      {
         .super.tipData = param1;
         evolutionUpgradTip(param1 as GoodTipInfo);
      }
      
      private function evolutionUpgradTip(param1:GoodTipInfo) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:InventoryItemInfo = null;
         var _loc2_:GoodTipInfo = null;
         var _loc6_:InventoryItemInfo = null;
         if(param1)
         {
            _loc6_ = param1.itemInfo as InventoryItemInfo;
         }
         if(_loc6_)
         {
            _loc2_ = new GoodTipInfo();
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc6_);
            _loc5_ = FineEvolutionManager.Instance.GetEvolutionDataByExp(_loc3_.curExp);
            if(_loc5_)
            {
               if(_loc5_.isMax == false)
               {
                  _loc3_.curExp = FineEvolutionManager.Instance.EvolutionDataByLv(_loc5_.Level + 1).Exp;
               }
               else
               {
                  _loc3_.curExp = _loc5_.Exp;
               }
            }
            else
            {
               _loc3_.curExp = FineEvolutionManager.Instance.EvolutionDataByLv(1).Exp;
            }
            _loc2_.itemInfo = _loc3_;
            _loc2_.beadName = ItemManager.Instance.getTemplateById(_loc3_.TemplateID).Name;
            if(!_upgradeBeadTip)
            {
               _upgradeBeadTip = new GoodTip();
            }
            _upgradeBeadTip.tipData = _loc2_;
            _upgradeBeadTip.x = _tipbackgound.x + _tipbackgound.width + 25;
            if(!this.contains(_upgradeBeadTip))
            {
               addChild(_upgradeBeadTip);
            }
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.ddtstore.rightArrows");
            _loc4_.x = _tipbackgound.x + _tipbackgound.width - 20;
            _loc4_.y = 90;
            addChild(_loc4_);
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
