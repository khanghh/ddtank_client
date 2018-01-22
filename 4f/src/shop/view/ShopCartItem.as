package shop.view
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.Price;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import shop.manager.ShopBuyManager;
   
   public class ShopCartItem extends Sprite implements Disposeable
   {
      
      public static const DELETE_ITEM:String = "deleteitem";
      
      public static const CONDITION_CHANGE:String = "conditionchange";
      
      public static const ADD_LENGTH:String = "add_length";
       
      
      protected var _bg:DisplayObject;
      
      protected var _itemCellBg:DisplayObject;
      
      protected var _verticalLine:Image;
      
      protected var _cartItemGroup:SelectedButtonGroup;
      
      protected var _cartItemSelectVBox:VBox;
      
      protected var _closeBtn:BaseButton;
      
      public var id:int;
      
      public var type:int;
      
      public var upDataBtnState:Function;
      
      protected var _itemName:FilterFrameText;
      
      protected var _cell:ShopPlayerCell;
      
      protected var _shopItemInfo:ShopCarItemInfo;
      
      protected var _blueTF:TextFormat;
      
      protected var _yellowTF:TextFormat;
      
      public var seleBand:Function;
      
      private var _items:Vector.<SelectedCheckButton>;
      
      protected var _isBand:Boolean;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _movieBack:MovieClip;
      
      public function ShopCartItem(){super();}
      
      public function get closeBtn() : BaseButton{return null;}
      
      protected function drawBackground(param1:Boolean = false) : void{}
      
      protected function drawNameField() : void{}
      
      protected function drawCellField() : void{}
      
      public function get isBand() : Boolean{return false;}
      
      public function set isBand(param1:Boolean) : void{}
      
      protected function initListener() : void{}
      
      public function addItem(param1:Boolean = false) : void{}
      
      private function addSelectedBtn() : void{}
      
      private function addSelectedBandBtn() : void{}
      
      private function selectedHander(param1:MouseEvent) : void{}
      
      private function selectedBandHander(param1:MouseEvent) : void{}
      
      public function setDianquanType(param1:Boolean = false) : void{}
      
      private function rigthValue(param1:int) : int{return 0;}
      
      protected function clickHander(param1:Event) : void{}
      
      protected function removeEvent() : void{}
      
      protected function __closeClick(param1:MouseEvent) : void{}
      
      protected function __cartItemGroupChange(param1:Event) : void{}
      
      public function setShopItemInfo(param1:ShopCarItemInfo, param2:int = -10, param3:Boolean = false) : void{}
      
      public function set showCloseButton(param1:Boolean) : void{}
      
      protected function cartItemSelectVBoxInit() : void{}
      
      private function clearitem() : void{}
      
      protected function __soundPlay(param1:MouseEvent) : void{}
      
      public function get shopItemInfo() : ShopCarItemInfo{return null;}
      
      public function get info() : ItemTemplateInfo{return null;}
      
      public function get TemplateID() : int{return 0;}
      
      public function setColor(param1:*) : void{}
      
      public function dispose() : void{}
   }
}
