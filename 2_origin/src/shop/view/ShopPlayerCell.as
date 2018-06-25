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
      
      public function ShopPlayerCell(bg:DisplayObject)
      {
         super(bg);
      }
      
      public function set shopItemInfo(value:ShopCarItemInfo) : void
      {
         if(value == null)
         {
            .super.info = null;
         }
         else
         {
            .super.info = value.TemplateInfo;
         }
         _shopItemInfo = value;
         locked = false;
         if(value is ShopCarItemInfo)
         {
            setColor(ShopCarItemInfo(value).Color);
         }
         dispatchEvent(new ShopEvent("itemInfoChange",null,null));
      }
      
      public function get shopItemInfo() : ShopCarItemInfo
      {
         return _shopItemInfo;
      }
      
      public function setSkinColor(color:String) : void
      {
         var t:* = null;
         var cs:* = null;
         if(shopItemInfo && EquipType.hasSkin(shopItemInfo.CategoryID))
         {
            t = shopItemInfo.Color.split("|");
            cs = "";
            if(t.length > 2)
            {
               cs = t[0] + "|" + color + "|" + t[2];
            }
            else
            {
               cs = t[0] + "|" + color + "|" + t[1];
            }
            shopItemInfo.Color = cs;
            setColor(cs);
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
