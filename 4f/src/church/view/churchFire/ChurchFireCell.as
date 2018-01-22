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
      
      public function ChurchFireCell(param1:DisplayObject, param2:ShopItemInfo, param3:int){super(null,null,null,null);}
      
      private function initialize() : void{}
      
      private function setView() : void{}
      
      override protected function createChildren() : void{}
      
      public function get fireTemplateID() : int{return 0;}
      
      public function set fireTemplateID(param1:int) : void{}
      
      private function setEvent() : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
   }
}
