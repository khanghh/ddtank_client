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
      
      public function BeadUpgradeTip(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      override public function showTip(param1:ItemTemplateInfo, param2:Boolean = false) : void{}
      
      private function beadUpgradeTip(param1:GoodTipInfo) : void{}
      
      override public function dispose() : void{}
   }
}
