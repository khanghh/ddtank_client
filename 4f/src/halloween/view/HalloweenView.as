package halloween.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import halloween.HalloweenControl;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   import shop.manager.ShopBuyManager;
   
   public class HalloweenView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _halloweenDes:FilterFrameText;
      
      private var _halloweenTime:FilterFrameText;
      
      private var _exchangeView:HalloweenExchangeView;
      
      private var _pumpkin:BagCell;
      
      private var _pumpkinBuyBtn:SimpleBitmapButton;
      
      private var _candy:Bitmap;
      
      private var _candyNum:FilterFrameText;
      
      private var _listView:HalloweenListView;
      
      public function HalloweenView(){super();}
      
      private function sendPkg() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onPumpkinBuyClick(param1:MouseEvent) : void{}
      
      protected function __onGetCandyNum(param1:PkgEvent) : void{}
      
      protected function __onKeyDown(param1:KeyboardEvent) : void{}
      
      protected function __onSetExchangeInfo(param1:PkgEvent) : void{}
      
      private function setTimeText() : void{}
      
      private function addZero(param1:Number) : String{return null;}
      
      protected function __onCloseClick(param1:MouseEvent) : void{}
      
      public function show() : void{}
      
      private function __onMouseClickSetFocus(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
