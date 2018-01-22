package church.view.churchFire
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ShopManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ChurchFireCell extends BaseCell implements Disposeable
   {
      
      public static const CONTENT_SIZE:int = 48;
       
      
      private var _fireIcon:Bitmap;
      
      private var _fireTemplateID:int;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var _fireItemBox:Bitmap;
      
      private var _fireItemBoxAc:Bitmap;
      
      private var _fireIconRectangle:Rectangle;
      
      private var _fireItemGlod:FilterFrameText;
      
      public function ChurchFireCell(param1:DisplayObject, param2:ShopItemInfo, param3:int)
      {
         super(param1,param2.TemplateInfo,true,true);
         _shopItemInfo = param2;
         _fireTemplateID = param3;
         initialize();
      }
      
      private function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         this.buttonMode = true;
         _fireIconRectangle = ComponentFactory.Instance.creatCustomObject("asset.church.room.fireIconRectangle");
         _fireItemBox = ComponentFactory.Instance.creatBitmap("asset.church.room.fireItemBoxAsset");
         addChild(_fireItemBox);
         _fireItemGlod = ComponentFactory.Instance.creat("church.room.fireItemGlodAsset");
         _fireItemGlod.text = String(_shopItemInfo.getItemPrice(1).goldValue) + "G";
         addChild(_fireItemGlod);
         _fireItemBoxAc = ComponentFactory.Instance.creatBitmap("asset.church.room.fireItemBoxAcAsset");
         _fireItemBoxAc.visible = false;
         addChild(_fireItemBoxAc);
      }
      
      override protected function createChildren() : void
      {
         addChildAt(_bg,0);
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("church.ChurchFireCell.bgPos");
         _bg.x = _loc1_.x;
         _bg.y = _loc1_.y;
         var _loc2_:int = 48;
         _bg.width = _loc2_;
         _contentWidth = _loc2_;
         _loc2_ = 48;
         _bg.height = _loc2_;
         _contentHeight = _loc2_;
      }
      
      public function get fireTemplateID() : int
      {
         return _fireTemplateID;
      }
      
      public function set fireTemplateID(param1:int) : void
      {
         _fireTemplateID = param1;
         _shopItemInfo = ShopManager.Instance.getGoldShopItemByTemplateID(_fireTemplateID);
      }
      
      private function setEvent() : void
      {
         addEventListener("mouseOver",onMouseOver);
         addEventListener("mouseOut",onMouseOut);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         super.onMouseOver(param1);
         _fireItemBoxAc.visible = true;
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
         _fireItemBoxAc.visible = false;
      }
   }
}
