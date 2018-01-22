package store.fineStore.view.pageBringUp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   
   public class FineBringUpUpgradeTip extends GoodTip
   {
       
      
      private var _upgradeBeadTip:GoodTip;
      
      public function FineBringUpUpgradeTip()
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
         bringUpUpgradeTip(param1 as GoodTipInfo);
      }
      
      override public function showTip(param1:ItemTemplateInfo, param2:Boolean = false) : void
      {
         super.showTip(param1,param2);
      }
      
      private function bringUpUpgradeTip(param1:GoodTipInfo) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:InventoryItemInfo = null;
         var _loc2_:GoodTipInfo = null;
         var _loc7_:InventoryItemInfo = null;
         if(param1)
         {
            _loc7_ = param1.itemInfo as InventoryItemInfo;
         }
         if(_loc7_ && _loc7_.FusionType != 0)
         {
            _loc2_ = new GoodTipInfo();
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc7_);
            _loc5_ = ItemManager.Instance.getTemplateById(_loc7_.FusionType);
            _loc3_.TemplateID = _loc5_.TemplateID;
            _loc3_.Name = _loc5_.Name;
            _loc3_.Attack = _loc5_.Attack;
            _loc3_.Defence = _loc5_.Defence;
            _loc3_.Agility = _loc5_.Agility;
            _loc3_.Luck = _loc5_.Luck;
            _loc3_.FusionType = _loc5_.FusionType;
            _loc3_.curExp = int(_loc5_.Property2);
            _loc3_.Property1 = _loc5_.Property1;
            if(_loc5_.FusionType == 0)
            {
               _loc3_.Property2 = "0";
            }
            else
            {
               _loc3_.Property2 = ItemManager.Instance.getTemplateById(_loc5_.FusionType).Property2;
            }
            _loc2_.itemInfo = _loc3_;
            _loc2_.beadName = ItemManager.Instance.getTemplateById(_loc3_.TemplateID).Name;
            if(!_upgradeBeadTip)
            {
               _upgradeBeadTip = new GoodTip();
            }
            _upgradeBeadTip.tipData = _loc2_;
            _loc6_ = ComponentFactory.Instance.creat("ddtstore.strengthTips.strengthenImageBG");
            _upgradeBeadTip.tipbackgound = _loc6_;
            _loc6_.width = _loc6_.width + 10;
            _loc6_.height = _loc6_.height + 10;
            _loc6_.x = _loc6_.x - 5;
            _loc6_.y = _loc6_.y - 5;
            _upgradeBeadTip.x = _tipbackgound.x + _tipbackgound.width + 35;
            if(!this.contains(_upgradeBeadTip))
            {
               addChild(_upgradeBeadTip);
            }
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.ddtstore.rightArrows");
            _loc4_.x = 190;
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
