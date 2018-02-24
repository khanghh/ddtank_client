package rescue.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RescueQuickBuyFrame extends Frame
   {
       
      
      private var _bg:Image;
      
      private var _itemBmp:Bitmap;
      
      private var _number:NumberSelecter;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _totalTipText:FilterFrameText;
      
      protected var totalText:FilterFrameText;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoney:FilterFrameText;
      
      private var _submitButton:TextButton;
      
      private var _movieBack:MovieClip;
      
      private var _type:int;
      
      private var _perPrice:int;
      
      protected var _isBand:Boolean;
      
      public function RescueQuickBuyFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      protected function __buyBuff(param1:MouseEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      protected function selectedBandHander(param1:MouseEvent) : void{}
      
      protected function seletedHander(param1:MouseEvent) : void{}
      
      private function reConfirmHandler(param1:FrameEvent) : void{}
      
      private function getNeedMoney() : int{return 0;}
      
      private function selectHandler(param1:Event) : void{}
      
      protected function refreshNumText() : void{}
      
      public function setData(param1:int, param2:int) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function removeEvnets() : void{}
      
      override public function dispose() : void{}
   }
}
