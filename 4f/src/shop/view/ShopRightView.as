package shop.view
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.greensock.TweenProxy;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.ShopType;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import shop.ShopController;
   import trainer.view.NewHandContainer;
   
   public class ShopRightView extends Sprite implements Disposeable
   {
      
      public static const TOP_RECOMMEND:uint = 0;
      
      public static const SHOP_ITEM_NUM:uint = 8;
      
      public static var CURRENT_GENDER:int = -1;
      
      public static var CURRENT_MONEY_TYPE:int = 1;
      
      public static var CURRENT_PAGE:int = 1;
      
      public static var TOP_TYPE:int = 0;
      
      public static var SUB_TYPE:int = 2;
      
      public static const SHOW_LIGHT:String = "SHOW_LIGHT";
      
      private static var isDiscountType:Boolean = false;
       
      
      private var _bg:Image;
      
      private var _bg1:Bitmap;
      
      private var _controller:ShopController;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _currentPageInput:Scale9CornerImage;
      
      private var _femaleBtn:SelectedButton;
      
      private var _genderContainer:VBox;
      
      private var _genderGroup:SelectedButtonGroup;
      
      private var _rightViewTitleBg:Bitmap;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _goodItemContainerBg:Image;
      
      private var _goodItemContainerTwoLine:Image;
      
      private var _goodItemGroup:SelectedButtonGroup;
      
      private var _goodItems:Vector.<ShopGoodItem>;
      
      private var _maleBtn:SelectedButton;
      
      private var _firstPage:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _endPageBtn:BaseButton;
      
      private var _subBtns:Vector.<SelectedTextButton>;
      
      private var _subBtnsContainers:Vector.<HBox>;
      
      private var _subBtnsGroups:Vector.<SelectedButtonGroup>;
      
      private var _currentSubBtnContainerIndex:int;
      
      private var _topBtns:Vector.<SelectedTextButton>;
      
      private var _topBtnsContainer:HBox;
      
      private var _topBtnsGroup:SelectedButtonGroup;
      
      private var _shopSearchBox:Sprite;
      
      private var _shopSearchEndBtnBg:Bitmap;
      
      private var _shopSearchColseBtn:BaseButton;
      
      private var _rightItemLightMc:MovieClip;
      
      private var _shopMoneySelectedCkBtn:SelectedCheckButton;
      
      private var _shopDDTMoneySelectedCkBtn:SelectedCheckButton;
      
      private var _shopMoneyGroup:SelectedButtonGroup;
      
      private var _moneyBg:Bitmap;
      
      private var _moneySeperateLine:Image;
      
      private var _tempTopType:int = -1;
      
      private var _tempCurrentPage:int = -1;
      
      private var _tempSubBtnHBox:HBox;
      
      private var _isSearch:Boolean;
      
      private var _searchShopItemList:Vector.<ShopItemInfo>;
      
      private var _searchItemTotalPage:int;
      
      public function ShopRightView(){super();}
      
      public function get genderGroup() : SelectedButtonGroup{return null;}
      
      public function setup(param1:ShopController) : void{}
      
      private function init() : void{}
      
      private function initBtns() : void{}
      
      private function updateBtn() : void{}
      
      private function subButtonSelectedChangeHandler(param1:Event) : void{}
      
      private function initEvent() : void{}
      
      protected function __moneySelectBtnChangeHandler(param1:Event) : void{}
      
      protected function __topBtnChangeHandler(param1:Event) : void{}
      
      private function __userGuide(param1:Event) : void{}
      
      private function reoveArrow() : void{}
      
      protected function __shopSearchColseBtnClick(param1:MouseEvent) : void{}
      
      public function loadList() : void{}
      
      private function getType() : int{return 0;}
      
      public function setCurrentSex(param1:int) : void{}
      
      public function setList(param1:Vector.<ShopItemInfo>) : void{}
      
      public function searchList(param1:Vector.<ShopItemInfo>) : void{}
      
      private function runSearch() : void{}
      
      private function __genderClick(param1:MouseEvent) : void{}
      
      private function __itemSelect(param1:ItemEvent) : void{}
      
      private function __itemClick(param1:ItemEvent) : void{}
      
      private function addCartEffects(param1:DisplayObject) : void{}
      
      private function twComplete(param1:TimelineLite, param2:TweenProxy, param3:Bitmap) : void{}
      
      private function itemClick(param1:ShopGoodItem) : void{}
      
      private function __pageBtnClick(param1:MouseEvent) : void{}
      
      private function __subBtnClick(param1:MouseEvent) : void{}
      
      private function __topBtnClick(param1:MouseEvent) : void{}
      
      private function disposeUserGuide() : void{}
      
      private function clearitems() : void{}
      
      private function removeEvent() : void{}
      
      private function showSubBtns(param1:int) : void{}
      
      public function gotoPage(param1:int = -1, param2:int = -1, param3:int = 1, param4:int = 1) : void{}
      
      public function dispose() : void{}
   }
}
