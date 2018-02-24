package foodActivity.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import foodActivity.FoodActivityControl;
   import foodActivity.FoodActivityManager;
   import store.HelpFrame;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class FoodActivityFrame extends Frame
   {
      
      private static var MONEY:int = 100;
       
      
      private var _bg:Bitmap;
      
      private var _countBg:Bitmap;
      
      private var _boxArr:Vector.<FoodActivityBox>;
      
      private var _boxNumTxtArr:Vector.<FilterFrameText>;
      
      private var _sp:Sprite;
      
      private var _progress:Bitmap;
      
      private var _btnBg:ScaleBitmapImage;
      
      private var _simpleBtn:SimpleBitmapButton;
      
      private var _payBtn:SimpleBitmapButton;
      
      private var _ripeTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _boxMc:MovieClip;
      
      private var _getAwardBtn:MovieClip;
      
      private var _defaultLength:int = 11;
      
      private var _defaultRipeNum:int = 60;
      
      private var _giftState:int;
      
      private var _data:GmActivityInfo;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var frame:int;
      
      public function FoodActivityFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __helpHandler(param1:MouseEvent) : void{}
      
      public function updateProgress() : void{}
      
      protected function __simpleHandler(param1:MouseEvent) : void{}
      
      protected function __payHandler(param1:MouseEvent) : void{}
      
      protected function __confirm(param1:FrameEvent) : void{}
      
      protected function _response(param1:FrameEvent) : void{}
      
      private function click() : Boolean{return false;}
      
      public function updateBoxMc() : void{}
      
      public function failRewardUpdate() : void{}
      
      protected function __getAwardHandler(param1:MouseEvent) : void{}
      
      protected function __enterHandler(param1:Event) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
