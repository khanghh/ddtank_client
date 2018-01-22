package vipIntegralShop.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import vipIntegralShop.VipIntegralShopController;
   import vipIntegralShop.data.VipIntegralShopInfo;
   
   public class VipIntegralShopView extends Frame
   {
      
      private static const MAXNUM:int = 4;
       
      
      private var _bg:Bitmap;
      
      private var _infoText:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _integralNum:FilterFrameText;
      
      private var _callText:FilterFrameText;
      
      private var _foreBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _shopCellList:Vector.<VipIntegralShopCell>;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      public function VipIntegralShopView(){super();}
      
      private function initData() : void{}
      
      private function sendPkg() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onUpdatePlayerProperty(param1:PlayerPropertyEvent) : void{}
      
      public function refreshView() : void{}
      
      private function __changePageHandler(param1:MouseEvent) : void{}
      
      protected function __onAlertResponse(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
