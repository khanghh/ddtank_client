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
      
      override public function set tipData(data:Object) : void
      {
         .super.tipData = data;
         if(!data)
         {
            return;
         }
         var tGoodTipInfo:GoodTipInfo = getPreGoodTipInfo(data as GoodTipInfo);
         if(!tGoodTipInfo)
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
         _laterGoodTip.tipData = tGoodTipInfo;
         addChild(_rightArrow);
         _width = _laterGoodTip.x + _laterGoodTip.width;
         _height = _laterGoodTip.height;
      }
      
      protected function getPreGoodTipInfo(goodTipInfo:GoodTipInfo) : GoodTipInfo
      {
         var tmpDate:* = null;
         var itemInfo:InventoryItemInfo = goodTipInfo.itemInfo as InventoryItemInfo;
         var tGoodTipInfo:GoodTipInfo = new GoodTipInfo();
         var tInfo:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(tInfo,itemInfo);
         tInfo.gemstoneList = itemInfo.gemstoneList;
         tInfo.IsBinds = true;
         var tmpItemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(goodTipInfo.latentEnergyItemId);
         if(!tmpItemInfo)
         {
            return null;
         }
         var valueStr:String = tmpItemInfo.Property3;
         tInfo.latentEnergyCurStr = valueStr + "," + valueStr + "," + valueStr + "," + valueStr;
         if(itemInfo.isHasLatentEnergy)
         {
            tInfo.latentEnergyEndTime = itemInfo.latentEnergyEndTime;
         }
         else
         {
            tmpDate = new Date(TimeManager.Instance.Now().getTime() + int(tmpItemInfo.Property4) * 86400000 - 3600000);
            tInfo.latentEnergyEndTime = tmpDate;
         }
         tGoodTipInfo.itemInfo = tInfo;
         return tGoodTipInfo;
      }
   }
}
