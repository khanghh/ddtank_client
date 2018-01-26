package farm.viewx.shop
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import shop.view.ShopItemCell;
   
   public class FarmShopPayPnl extends BaseAlerFrame
   {
      
      public static const GOLD:int = 1;
      
      public static const GIFT:int = 2;
      
      public static const MONEY:int = 3;
      
      private static const MaxNum:int = 50;
       
      
      private var _addBtn:BaseButton;
      
      private var _removeBtn:BaseButton;
      
      private var _alertTips:FilterFrameText;
      
      private var _payNumtxt:TextInput;
      
      private var _payNumBg:DisplayObject;
      
      private var _shopPayItem:ShopItemCell;
      
      private var _cellBg:DisplayObject;
      
      private var _goodsID:int;
      
      private var _payNum:int = 1;
      
      private var _alertTips2:FilterFrameText;
      
      private var _totalBg:Bitmap;
      
      private var _group:SelectedButtonGroup;
      
      private var _spendValue:int;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _back:MovieClip;
      
      private var _selectedXunzBtn:SelectedCheckButton;
      
      private var _isXun:Boolean;
      
      private var _xunZMoneyTxt:FilterFrameText;
      
      public function FarmShopPayPnl(){super();}
      
      private function initView() : void{}
      
      protected function selectedBandHander(param1:MouseEvent) : void{}
      
      private function selectedXunzHander(param1:MouseEvent) : void{}
      
      protected function seletedHander(param1:MouseEvent) : void{}
      
      private function setSeleBtnFalse() : void{}
      
      public function set goodsID(param1:int) : void{}
      
      private function applyGray(param1:DisplayObject) : void{}
      
      private function applyFilter(param1:DisplayObject, param2:Array) : void{}
      
      private function alertMoney() : void{}
      
      protected function creatItemCell() : ShopItemCell{return null;}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      protected function __selectedChange(param1:Event) : void{}
      
      private function __txtInputCheck(param1:Event) : void{}
      
      private function checkInput() : void{}
      
      protected function __framePesponse(param1:FrameEvent) : void{}
      
      private function sendFarmShop() : void{}
      
      protected function onCheckComplete() : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      private function okFastPurchaseGold() : void{}
      
      private function __selectPayNum(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
