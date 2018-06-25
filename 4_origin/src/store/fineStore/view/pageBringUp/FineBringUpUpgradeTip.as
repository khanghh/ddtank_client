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
      
      override public function set tipData(data:Object) : void
      {
         .super.tipData = data;
         bringUpUpgradeTip(data as GoodTipInfo);
      }
      
      override public function showTip(info:ItemTemplateInfo, typeIsSecond:Boolean = false) : void
      {
         super.showTip(info,typeIsSecond);
      }
      
      private function bringUpUpgradeTip(pTipInfo:GoodTipInfo) : void
      {
         var next:* = null;
         var bg:* = null;
         var _rightArrows:* = null;
         var tInfo:InventoryItemInfo = null;
         var tGoodTipInfo:GoodTipInfo = null;
         var itemInfo:InventoryItemInfo = null;
         if(pTipInfo)
         {
            itemInfo = pTipInfo.itemInfo as InventoryItemInfo;
         }
         if(itemInfo && itemInfo.FusionType != 0)
         {
            tGoodTipInfo = new GoodTipInfo();
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            next = ItemManager.Instance.getTemplateById(itemInfo.FusionType);
            tInfo.TemplateID = next.TemplateID;
            tInfo.Name = next.Name;
            tInfo.Attack = next.Attack;
            tInfo.Defence = next.Defence;
            tInfo.Agility = next.Agility;
            tInfo.Luck = next.Luck;
            tInfo.FusionType = next.FusionType;
            tInfo.curExp = int(next.Property2);
            tInfo.Property1 = next.Property1;
            if(next.FusionType == 0)
            {
               tInfo.Property2 = "0";
            }
            else
            {
               tInfo.Property2 = ItemManager.Instance.getTemplateById(next.FusionType).Property2;
            }
            tGoodTipInfo.itemInfo = tInfo;
            tGoodTipInfo.beadName = ItemManager.Instance.getTemplateById(tInfo.TemplateID).Name;
            if(!_upgradeBeadTip)
            {
               _upgradeBeadTip = new GoodTip();
            }
            _upgradeBeadTip.tipData = tGoodTipInfo;
            bg = ComponentFactory.Instance.creat("ddtstore.strengthTips.strengthenImageBG");
            _upgradeBeadTip.tipbackgound = bg;
            bg.width = bg.width + 10;
            bg.height = bg.height + 10;
            bg.x = bg.x - 5;
            bg.y = bg.y - 5;
            _upgradeBeadTip.x = _tipbackgound.x + _tipbackgound.width + 35;
            if(!this.contains(_upgradeBeadTip))
            {
               addChild(_upgradeBeadTip);
            }
            _rightArrows = ComponentFactory.Instance.creatBitmap("asset.ddtstore.rightArrows");
            _rightArrows.x = 190;
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
