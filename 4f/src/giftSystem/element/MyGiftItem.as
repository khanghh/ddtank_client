package giftSystem.element
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import giftSystem.MyGiftCellInfo;
   import shop.view.ShopItemCell;
   
   public class MyGiftItem extends Sprite implements Disposeable
   {
       
      
      private var _info:MyGiftCellInfo;
      
      private var _BG:MovieImage;
      
      private var _nameBG:Bitmap;
      
      private var _giftBG:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _ownCount:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _itemCell:ShopItemCell;
      
      public function MyGiftItem(){super();}
      
      private function initView() : void{}
      
      public function get info() : MyGiftCellInfo{return null;}
      
      public function set info(param1:MyGiftCellInfo) : void{}
      
      private function upView() : void{}
      
      public function set ownCount(param1:int) : void{}
      
      private function upCountAndownCount() : void{}
      
      private function getSpace(param1:String) : String{return null;}
      
      override public function get height() : Number{return 0;}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
