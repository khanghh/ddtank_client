package shop.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.manager.PlayerManager;
   import flash.display.DisplayObject;
   import shop.ShopEvent;
   
   public class ShopPlayerCell extends BaseCell
   {
       
      
      private var _shopItemInfo:ShopCarItemInfo;
      
      private var _light:MovieImage;
      
      public function ShopPlayerCell(param1:DisplayObject)
      {
         super(param1);
      }
      
      public function set shopItemInfo(param1:ShopCarItemInfo) : void
      {
         if(param1 == null)
         {
            .super.info = null;
         }
         else
         {
            .super.info = param1.TemplateInfo;
         }
         _shopItemInfo = param1;
         locked = false;
         if(param1 is ShopCarItemInfo)
         {
            setColor(ShopCarItemInfo(param1).Color);
         }
         dispatchEvent(new ShopEvent("itemInfoChange",null,null));
      }
      
      public function get shopItemInfo() : ShopCarItemInfo
      {
         return _shopItemInfo;
      }
      
      public function setSkinColor(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(shopItemInfo && EquipType.hasSkin(shopItemInfo.CategoryID))
         {
            _loc2_ = shopItemInfo.Color.split("|");
            _loc3_ = "";
            if(_loc2_.length > 2)
            {
               _loc3_ = _loc2_[0] + "|" + param1 + "|" + _loc2_[2];
            }
            else
            {
               _loc3_ = _loc2_[0] + "|" + param1 + "|" + _loc2_[1];
            }
            shopItemInfo.Color = _loc3_;
            setColor(_loc3_);
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_light == null)
         {
            _light = ComponentFactory.Instance.creatComponentByStylename("ddtshop.shopPlayerCell.RightItemLightMc");
         }
         addChild(_light);
         var _loc1_:* = false;
         _light.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _light.mouseChildren = _loc1_;
         _light.visible = _loc1_;
      }
      
      public function showLight() : void
      {
         _light.visible = true;
      }
      
      public function hideLight() : void
      {
         _light.visible = false;
      }
      
      override public function dispose() : void
      {
         if(locked)
         {
            if(_info != null && _info is InventoryItemInfo)
            {
               PlayerManager.Instance.Self.Bag.unlockItem(_info as InventoryItemInfo);
            }
            locked = false;
         }
         _shopItemInfo = null;
         if(_light)
         {
            ObjectUtils.disposeObject(_light);
         }
         _light = null;
         super.dispose();
      }
   }
}
