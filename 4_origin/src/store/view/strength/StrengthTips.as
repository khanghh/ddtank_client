package store.view.strength
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   import store.view.strength.manager.ItemStrengthenGoodsInfoManager;
   import store.view.strength.vo.ItemStrengthenGoodsInfo;
   
   public class StrengthTips extends GoodTip
   {
       
      
      protected var _laterEquipmentView:LaterEquipmentView;
      
      public function StrengthTips()
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
         laterEquipment(data as GoodTipInfo);
      }
      
      override public function showTip(info:ItemTemplateInfo, typeIsSecond:Boolean = false) : void
      {
         super.showTip(info,typeIsSecond);
      }
      
      protected function laterEquipment(goodTipInfo:GoodTipInfo) : void
      {
         var itemStrengthenGoodsInfo:* = null;
         var itemTemplateInfo:* = null;
         if(syahTip != null)
         {
            syahTip.visible = false;
         }
         if(_laterEquipmentGoodView.visible)
         {
            _laterEquipmentGoodView.visible = false;
         }
         var tInfo:InventoryItemInfo = null;
         var tGoodTipInfo:GoodTipInfo = null;
         var itemInfo:InventoryItemInfo = null;
         if(goodTipInfo)
         {
            itemInfo = goodTipInfo.itemInfo as InventoryItemInfo;
         }
         if(itemInfo && itemInfo.StrengthenLevel < 12)
         {
            tGoodTipInfo = new GoodTipInfo();
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            tInfo.StrengthenLevel = tInfo.StrengthenLevel + 1;
            itemStrengthenGoodsInfo = ItemStrengthenGoodsInfoManager.findItemStrengthenGoodsInfo(tInfo.TemplateID,tInfo.StrengthenLevel);
            if(itemStrengthenGoodsInfo)
            {
               tInfo.TemplateID = itemStrengthenGoodsInfo.GainEquip;
               itemTemplateInfo = ItemManager.Instance.getTemplateById(tInfo.TemplateID);
               if(itemTemplateInfo)
               {
                  tInfo.Attack = itemTemplateInfo.Attack;
                  tInfo.Defence = itemTemplateInfo.Defence;
                  tInfo.Agility = itemTemplateInfo.Agility;
                  tInfo.Luck = itemTemplateInfo.Luck;
               }
            }
            tGoodTipInfo.itemInfo = tInfo;
            if(!_laterEquipmentView)
            {
               _laterEquipmentView = new LaterEquipmentView();
            }
            _laterEquipmentView.x = _tipbackgound.x + _tipbackgound.width + 35;
            if(!this.contains(_laterEquipmentView))
            {
               addChild(_laterEquipmentView);
            }
            _laterEquipmentView.tipData = tGoodTipInfo;
         }
         else
         {
            if(_laterEquipmentView)
            {
               ObjectUtils.disposeObject(_laterEquipmentView);
            }
            _laterEquipmentView = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_laterEquipmentView)
         {
            ObjectUtils.disposeObject(_laterEquipmentView);
         }
         _laterEquipmentView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
