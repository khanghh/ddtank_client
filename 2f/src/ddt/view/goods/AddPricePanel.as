package ddt.view.goods
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.text.TextFormat;
   
   public class AddPricePanel extends Frame
   {
      
      private static var _instance:AddPricePanel;
       
      
      private var _infoLabel:FilterFrameText;
      
      private var _payButton:TextButton;
      
      private var _cancelButton:TextButton;
      
      private var _leftLabel:Bitmap;
      
      private var _moneyButton:SelectedButton;
      
      private var _ddtmoneyButton:SelectedButton;
      
      private var _petStoneButton:SelectedButton;
      
      private var _leagueButton:SelectedButton;
      
      private var _radioGroup:SelectedButtonGroup;
      
      private var _armShellClipButton:SelectedButton;
      
      private var _medalButton:SelectedButton;
      
      private var _payComBox:ComboBox;
      
      private var _isDress:Boolean;
      
      private var _info:InventoryItemInfo;
      
      private var _blueTF:TextFormat;
      
      private var _yellowTF:TextFormat;
      
      private var _grayFilter:ColorMatrixFilter;
      
      private var _currentAlert:BaseAlerFrame;
      
      private var _currentPayType:int;
      
      private var _currentPayTypeArr:Array;
      
      protected var _cartItemGroup:SelectedButtonGroup;
      
      protected var _cartItemSelectVBox:VBox;
      
      private var _bgLeft:ScaleBitmapImage;
      
      private var _bgRight:ScaleBitmapImage;
      
      private var _textI:FilterFrameText;
      
      private var _textII:FilterFrameText;
      
      private var _textIII:FilterFrameText;
      
      private var _textImg:Image;
      
      private var _moneyBg:ScaleBitmapImage;
      
      private var _ddtmoneyBg:ScaleBitmapImage;
      
      private var _petStoneBg:ScaleBitmapImage;
      
      private var _medalBg:ScaleBitmapImage;
      
      private var _leagueBg:ScaleBitmapImage;
      
      private var _armShellClipBg:ScaleBitmapImage;
      
      private var _moneyLogo:Bitmap;
      
      private var _ddtmoneyLogo:Bitmap;
      
      private var _petStoneLogo:Bitmap;
      
      private var _leagueLogo:Bitmap;
      
      private var _armShellClipLogo:Bitmap;
      
      private var _medalBitmapLogo:Bitmap;
      
      private var _moneyFFT:FilterFrameText;
      
      private var _petStoneFFT:FilterFrameText;
      
      private var _ddtmoneyFFT:FilterFrameText;
      
      private var _medalFFT:FilterFrameText;
      
      private var _leagueFFT:FilterFrameText;
      
      private var _armShellClipFFT:FilterFrameText;
      
      private var _isBand:Boolean = false;
      
      private var _type:int;
      
      private var _shopItems:Array;
      
      private var _currentShopItem:ShopCarItemInfo;
      
      private var _isXun:Boolean;
      
      private var thirdFFTPos:Point;
      
      private var thirdLogoPos:Point;
      
      private var thirdBgPos:Point;
      
      private var thirdButtonPos:Point;
      
      private var chooseType:int;
      
      public function AddPricePanel(){super();}
      
      public static function get Instance() : AddPricePanel{return null;}
      
      private function configUI() : void{}
      
      public function setInfo(param1:InventoryItemInfo, param2:Boolean) : void{}
      
      protected function cartItemSelectVBoxInit() : void{}
      
      protected function __cartItemGroupChange(param1:Event) : void{}
      
      private function fillToShopCarInfo(param1:ShopItemInfo) : ShopCarItemInfo{return null;}
      
      private function resetRadioBtn(param1:Array) : void{}
      
      public function show() : void{}
      
      private function __onSelectRadioBtn(param1:MouseEvent) : void{}
      
      private function updateCurrentShopItem() : void{}
      
      private function addEvent() : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __onPay(param1:MouseEvent) : void{}
      
      private function leagueConfirmHandler(param1:FrameEvent) : void{}
      
      private function armShellClipConfirmHandler(param1:FrameEvent) : void{}
      
      protected function petStoneConfirmed(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      private function __onPayResponse(param1:FrameEvent) : void{}
      
      private function __onCancelClick(param1:MouseEvent) : void{}
      
      override protected function __onCloseClick(param1:MouseEvent) : void{}
      
      private function doPay() : void{}
      
      public function close() : void{}
   }
}
