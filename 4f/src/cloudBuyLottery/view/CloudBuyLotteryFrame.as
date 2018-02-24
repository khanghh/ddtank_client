package cloudBuyLottery.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import cloudBuyLottery.CloudBuyLotteryManager;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import store.HelpFrame;
   
   public class CloudBuyLotteryFrame extends Frame
   {
      
      public static const MOVE_SPEED:Number = 0.8;
      
      public static var logFrameFlag:Boolean;
       
      
      private var _bg:Bitmap;
      
      private var showTimes:MovieClip;
      
      private var timeArray:Array;
      
      private var _timer:Timer;
      
      private var _helpBtn:BaseButton;
      
      private var _jubaoBtn:BaseButton;
      
      private var _buyBtn:BaseButton;
      
      private var _finish:Bitmap;
      
      private var _expBar:ExpBar;
      
      private var _luckNumTxt:FilterFrameText;
      
      private var _chanceTxt:FilterFrameText;
      
      private var _showBuyNumTxt:FilterFrameText;
      
      private var _buyNumTxt:FilterFrameText;
      
      private var _buyGoodsMoneyTxt:FilterFrameText;
      
      private var _helpTxt:FilterFrameText;
      
      private var _tipsframe:BaseAlerFrame;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _moneyNumText:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _text:FilterFrameText;
      
      private var _cell:BagCell;
      
      private var _logTxt:FilterFrameText;
      
      private var _logSprite:Sprite;
      
      private var winningLogFrame:TheWinningLog;
      
      private var _infoWidth:Number;
      
      private var _numberK:Bitmap;
      
      private var _numberKTxt:FilterFrameText;
      
      private var luckLooteryFrame:IndividualLottery;
      
      private var _buyGoodsSprite:Component;
      
      public function CloudBuyLotteryFrame(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      override public function set width(param1:Number) : void{}
      
      private function __updateInfo(param1:Event) : void{}
      
      private function __frmeUpdateInfo(param1:Event) : void{}
      
      private function __onLogClick(param1:MouseEvent) : void{}
      
      public function hideFrame() : void{}
      
      private function releaseRight(param1:Frame) : void{}
      
      protected function __onclose(param1:FrameEvent) : void{}
      
      private function __onBuyClick(param1:MouseEvent) : void{}
      
      private function changeMaxHandler(param1:MouseEvent) : void{}
      
      private function inputTextChangeHandler(param1:Event) : void{}
      
      private function showMoneyNum() : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function __onJuBaoClick(param1:MouseEvent) : void{}
      
      private function luckGoodsCell(param1:int) : void{}
      
      private function buyGoodsCell(param1:Array) : void{}
      
      private function __updateTimes(param1:TimerEvent) : void{}
      
      private function timesNum() : void{}
      
      protected function __onHelpClick(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      public function get expBar() : ExpBar{return null;}
      
      override public function dispose() : void{}
   }
}
