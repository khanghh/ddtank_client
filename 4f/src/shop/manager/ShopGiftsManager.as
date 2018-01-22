package shop.manager
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
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
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.ShopCartItem;
   import shop.view.ShopPresentClearingFrame;
   
   public class ShopGiftsManager
   {
      
      private static var _instance:ShopGiftsManager;
       
      
      private var _frame:Frame;
      
      private var _shopCartItem:ShopCartItem;
      
      private var _titleTxt:FilterFrameText;
      
      private var _commodityPricesText1:FilterFrameText;
      
      private var _commodityPricesText2:FilterFrameText;
      
      private var _commodityPricesText1Label:FilterFrameText;
      
      private var _commodityPricesText2Label:FilterFrameText;
      
      private var _needToPayTip:FilterFrameText;
      
      private var _giftsBtn:BaseButton;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _goodsID:int;
      
      private var _isDiscountType:Boolean = true;
      
      private var _shopPresentClearingFrame:ShopPresentClearingFrame;
      
      private var _isBand:Boolean;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      private var _back:MovieClip;
      
      private var _type:int = 0;
      
      private var _commodityPricesText3Label:FilterFrameText;
      
      private var _commodityPricesText3:FilterFrameText;
      
      public function ShopGiftsManager(){super();}
      
      public static function get Instance() : ShopGiftsManager{return null;}
      
      public function buy(param1:int, param2:Boolean = false, param3:int = 1) : void{}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      protected function selectedBandHander(param1:MouseEvent) : void{}
      
      protected function seletedHander(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function updateCommodityPrices() : void{}
      
      protected function __giftsBtnClick(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      protected function __presentBtnClick(param1:MouseEvent) : void{}
      
      protected function onPresent(param1:PkgEvent) : void{}
      
      protected function __numberSelecterChange(param1:Event) : void{}
      
      protected function __shopCartItemChange(param1:Event) : void{}
      
      protected function __framePesponse(param1:FrameEvent) : void{}
      
      private function dispose() : void{}
   }
}
