package vip.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class VipGrowUpFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleBm:Bitmap;
      
      private var _halfYearBtn:SelectedButton;
      
      private var _threeMonthBtn:SelectedButton;
      
      private var _oneMonthBtn:SelectedButton;
      
      private var _openVipTimeBtnGroup:SelectedButtonGroup;
      
      private var _discountIcon:Image;
      
      private var _openVipTip1:FilterFrameText;
      
      private var _openVipTip2:FilterFrameText;
      
      private var _openVipBtn:BaseButton;
      
      protected var payNum:int = 0;
      
      protected var time:String = "";
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _moneyConfirm:BaseAlerFrame;
      
      protected var days:int = 0;
      
      public function VipGrowUpFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __upPayNum(param1:Event) : void{}
      
      protected function upPayMoneyText() : void{}
      
      private function __openVipBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __confirm(param1:FrameEvent) : void{}
      
      protected function sendVip() : void{}
      
      protected function send() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
