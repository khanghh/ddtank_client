package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.ShopController;
   import shop.ShopEvent;
   import shop.ShopModel;
   import shop.manager.ShopBuyManager;
   
   public class ShopCheckOutView extends Sprite implements Disposeable
   {
      
      public static const COUNT:uint = 3;
      
      public static const DDT_MONEY:uint = 1;
      
      public static const BAND_MONEY:uint = 2;
      
      public static const LACK:uint = 1;
      
      public static const MONEY:uint = 0;
      
      public static const PLAYER:uint = 0;
      
      public static const PRESENT:int = 2;
      
      public static const PURCHASE:int = 1;
      
      public static const SAVE:int = 3;
      
      public static const ASKTYPE:int = 4;
       
      
      protected var _commodityNumberText:FilterFrameText;
      
      protected var _commodityNumberTip:FilterFrameText;
      
      protected var _commodityPricesText1:FilterFrameText;
      
      protected var _commodityPricesText2:FilterFrameText;
      
      private var _commodityPricesText1Bg:Scale9CornerImage;
      
      private var _commodityPricesText2Bg:Scale9CornerImage;
      
      private var _commodityPricesText3Bg:Scale9CornerImage;
      
      protected var _commodityPricesText1Label:FilterFrameText;
      
      protected var _commodityPricesText2Label:FilterFrameText;
      
      protected var _needToPayTip:FilterFrameText;
      
      protected var _purchaseConfirmationBtn:BaseButton;
      
      protected var _giftsBtn:BaseButton;
      
      protected var _askBtn:SimpleBitmapButton;
      
      protected var _saveImageBtn:BaseButton;
      
      private var _buyArray:Array;
      
      protected var _cartList:VBox;
      
      private var _castList2:Sprite;
      
      private var _cartItemList:Vector.<ShopCartItem>;
      
      private var _cartScroll:ScrollPanel;
      
      protected var _controller:ShopController;
      
      protected var _frame:Frame;
      
      private var _giveArray:Array;
      
      protected var _innerBg1:Image;
      
      private var _innerBg:Image;
      
      protected var _model:ShopModel;
      
      protected var _tempList:Array;
      
      protected var _type:int;
      
      private var _isDisposed:Boolean;
      
      private var shopPresent:ShopPresentView;
      
      protected var _list:Array;
      
      private var _bandMoneyTotal:int;
      
      private var _MoneyTotal:int;
      
      private var _shopPresentClearingFrame:ShopPresentClearingFrame;
      
      private var _commodityPricesText3Label:FilterFrameText;
      
      private var _commodityPricesText3:FilterFrameText;
      
      private var _isAsk:Boolean;
      
      public function ShopCheckOutView(){super();}
      
      protected function drawFrame() : void{}
      
      protected function drawItemCountField() : void{}
      
      protected function drawPayListField() : void{}
      
      protected function init() : void{}
      
      private function clearList() : void{}
      
      protected function initEvent() : void{}
      
      protected function __purchaseConfirmationBtnClick(param1:MouseEvent = null) : void{}
      
      private function sendAsk() : void{}
      
      private function seleBand(param1:int, param2:int, param3:Boolean) : void{}
      
      protected function addItemEvent(param1:ShopCartItem) : void{}
      
      protected function addLength(param1:Event) : void{}
      
      protected function removeItemEvent(param1:ShopCartItem) : void{}
      
      public function setList(param1:Array, param2:int = 0, param3:Boolean = false) : void{}
      
      private function upDataBtnState() : void{}
      
      private function updateList() : void{}
      
      protected function createShopItem() : ShopCartItem{return null;}
      
      public function setup(param1:ShopController, param2:ShopModel, param3:Array, param4:int) : void{}
      
      private function __conditionChange(param1:Event) : void{}
      
      private function upDataListInfo(param1:int) : void{}
      
      private function __deleteItem(param1:Event) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function get extraButton() : BaseButton{return null;}
      
      protected function removeEvent() : void{}
      
      private function __dispatchFrameEvent(param1:MouseEvent) : void{}
      
      private function isMoneyGoods(param1:*, param2:int, param3:Array) : Boolean{return false;}
      
      private function notPresentGoods() : Array{return null;}
      
      private function onBuyedGoods(param1:PkgEvent) : void{}
      
      private function onPresent(param1:PkgEvent) : void{}
      
      private function presentCheckOut() : void{}
      
      private function __shopPresentClearingFrameResponseHandler(param1:FrameEvent) : void{}
      
      protected function __presentBtnClick(param1:MouseEvent) : void{}
      
      private function saveFigureCheckOut() : void{}
      
      private function shopCarCheckOut() : void{}
      
      protected function updateTxt() : void{}
      
      public function dispose() : void{}
   }
}
