package beadSystem.tips
{
   import beadSystem.views.BeadUpgradeTipView;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.BeadTemplateManager;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   
   public class BeadUpgradeTip extends GoodTip
   {
       
      
      private var _upgradeBeadTip:BeadUpgradeTipView;
      
      public function BeadUpgradeTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
      }
      
      override public function set tipData(param1:Object) : void
      {
         .super.tipData = param1;
         beadUpgradeTip(param1 as GoodTipInfo);
      }
      
      override public function showTip(param1:ItemTemplateInfo, param2:Boolean = false) : void
      {
         super.showTip(param1,param2);
      }
      
      private function beadUpgradeTip(param1:GoodTipInfo) : void
      {
         var _loc3_:InventoryItemInfo = null;
         var _loc2_:GoodTipInfo = null;
         var _loc4_:InventoryItemInfo = null;
         if(param1)
         {
            _loc4_ = param1.itemInfo as InventoryItemInfo;
         }
         if(_loc4_ && _loc4_.Hole1 < 21)
         {
            _loc2_ = new GoodTipInfo();
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc4_);
            _loc3_.Hole1 = _loc3_.Hole1 + 1;
            _loc3_.TemplateID = BeadTemplateManager.Instance.GetBeadTemplateIDByLv(_loc3_.Hole1,_loc4_.TemplateID);
            _loc2_.itemInfo = _loc3_;
            _loc2_.beadName = _loc3_.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(_loc3_.TemplateID).Name + "Lv" + _loc3_.Hole1;
            if(!_upgradeBeadTip)
            {
               _upgradeBeadTip = new BeadUpgradeTipView();
            }
            _upgradeBeadTip.x = _tipbackgound.x + _tipbackgound.width + 35;
            if(!this.contains(_upgradeBeadTip))
            {
               addChild(_upgradeBeadTip);
            }
            _upgradeBeadTip.tipData = _loc2_;
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
