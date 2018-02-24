package giftSystem.element
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import shop.view.ShopItemCell;
   
   public class GiftCartItem extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:ShopItemCell;
      
      private var _name:FilterFrameText;
      
      private var _info:ShopItemInfo;
      
      private var _chooseNum:ChooseNum;
      
      private var _bg:ScaleBitmapImage;
      
      private var _itemCellBg:ScaleBitmapImage;
      
      private var _lineBg:ScaleBitmapImage;
      
      private var _InputBg:Scale9CornerImage;
      
      public function GiftCartItem(){super();}
      
      private function initView() : void{}
      
      public function get number() : int{return 0;}
      
      public function set info(param1:ShopItemInfo) : void{}
      
      private function upView() : void{}
      
      private function initEvent() : void{}
      
      private function __numberChange(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
