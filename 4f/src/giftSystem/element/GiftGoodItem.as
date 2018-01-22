package giftSystem.element
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import giftSystem.GiftController;
   import shop.view.ShopItemCell;
   
   public class GiftGoodItem extends Sprite implements ISelectable, Disposeable
   {
      
      public static const MONEY:uint = 2;
      
      public static const GIFT:uint = 3;
      
      public static const MEDAL:uint = 4;
       
      
      private var _selected:Boolean;
      
      private var _info:ShopItemInfo;
      
      private var _background:ScaleFrameImage;
      
      private var _giftGoodItemBG:Bitmap;
      
      private var _icon:ScaleFrameImage;
      
      private var _itemCell:ShopItemCell;
      
      private var _giftName:FilterFrameText;
      
      private var _charmValue:FilterFrameText;
      
      private var _charmName:FilterFrameText;
      
      private var _moneyValue:FilterFrameText;
      
      private var _moneyName:FilterFrameText;
      
      private var _freeName:FilterFrameText;
      
      private var _freeValue:FilterFrameText;
      
      private var _presentBtn:BaseButton;
      
      private var _line:TiledImage;
      
      private var _line1:TiledImage;
      
      public function GiftGoodItem(){super();}
      
      private function init() : void{}
      
      private function __showClearingInterface(param1:MouseEvent) : void{}
      
      public function set info(param1:ShopItemInfo) : void{}
      
      public function get info() : ShopItemInfo{return null;}
      
      private function upView() : void{}
      
      protected function __upItemCount(param1:Event) : void{}
      
      override public function get height() : Number{return 0;}
      
      override public function get width() : Number{return 0;}
      
      public function set autoSelect(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
