package latentEnergy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.TimeManager;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   
   public class LatentEnergyPreTip extends GoodTip
   {
       
      
      private var _rightArrow:Bitmap;
      
      private var _laterGoodTip:GoodTip;
      
      public function LatentEnergyPreTip()
      {
         super();
      }
      
      override public function set tipData(param1:Object) : void
      {
         .super.tipData = param1;
         if(!param1)
         {
            return;
         }
         var _loc2_:GoodTipInfo = getPreGoodTipInfo(param1 as GoodTipInfo);
         if(!_loc2_)
         {
            return;
         }
         if(!_rightArrow)
         {
            _rightArrow = ComponentFactory.Instance.creatBitmap("asset.latentEnergy.rightArrows");
            _rightArrow.x = this.width - 10;
            _rightArrow.y = (this.height - _rightArrow.height) / 2;
         }
         if(!_laterGoodTip)
         {
            _laterGoodTip = new GoodTip();
            _laterGoodTip.x = _tipbackgound.x + _tipbackgound.width + 35;
         }
         addChild(_laterGoodTip);
         _laterGoodTip.tipData = _loc2_;
         addChild(_rightArrow);
         _width = _laterGoodTip.x + _laterGoodTip.width;
         _height = _laterGoodTip.height;
      }
      
      protected function getPreGoodTipInfo(param1:GoodTipInfo) : GoodTipInfo
      {
         var _loc5_:* = null;
         var _loc6_:InventoryItemInfo = param1.itemInfo as InventoryItemInfo;
         var _loc3_:GoodTipInfo = new GoodTipInfo();
         var _loc4_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc4_,_loc6_);
         _loc4_.gemstoneList = _loc6_.gemstoneList;
         _loc4_.IsBinds = true;
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1.latentEnergyItemId);
         if(!_loc2_)
         {
            return null;
         }
         var _loc7_:String = _loc2_.Property3;
         _loc4_.latentEnergyCurStr = _loc7_ + "," + _loc7_ + "," + _loc7_ + "," + _loc7_;
         if(_loc6_.isHasLatentEnergy)
         {
            _loc4_.latentEnergyEndTime = _loc6_.latentEnergyEndTime;
         }
         else
         {
            _loc5_ = new Date(TimeManager.Instance.Now().getTime() + int(_loc2_.Property4) * 86400000 - 3600000);
            _loc4_.latentEnergyEndTime = _loc5_;
         }
         _loc3_.itemInfo = _loc4_;
         return _loc3_;
      }
   }
}
