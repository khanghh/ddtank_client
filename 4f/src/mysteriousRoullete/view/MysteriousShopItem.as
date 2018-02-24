package mysteriousRoullete.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import shop.view.ShopGoodItem;
   
   public class MysteriousShopItem extends ShopGoodItem
   {
      
      public static const TYPE_FREE:int = 0;
      
      public static const TYPE_DISCOUNT:int = 1;
       
      
      private var _itemCount:FilterFrameText;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var type:int = 1;
      
      private var _alertFrame:BaseAlerFrame;
      
      private var price:int;
      
      public function MysteriousShopItem(param1:int){super();}
      
      override protected function initContent() : void{}
      
      override public function set shopItemInfo(param1:ShopItemInfo) : void{}
      
      private function __getBtnClick(param1:MouseEvent) : void{}
      
      private function __buyBtnClick(param1:MouseEvent) : void{}
      
      protected function __alertBuyGoods(param1:FrameEvent) : void{}
      
      private function onResponseHander(param1:FrameEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function __alertResponseHandler(param1:FrameEvent) : void{}
      
      private function buy(param1:Boolean = false) : void{}
      
      public function turnGray(param1:Boolean = false) : void{}
      
      override protected function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
