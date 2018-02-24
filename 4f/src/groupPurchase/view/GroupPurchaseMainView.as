package groupPurchase.view
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import groupPurchase.GroupPurchaseControl;
   import groupPurchase.GroupPurchaseManager;
   import wonderfulActivity.WonderfulActivityControl;
   import wonderfulActivity.WonderfulFrame;
   import wonderfulActivity.views.IRightView;
   
   public class GroupPurchaseMainView extends Sprite implements Disposeable, IRightView
   {
       
      
      private var _bg:Bitmap;
      
      private var _topBg:Bitmap;
      
      private var _rankBtn:SimpleBitmapButton;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _curDiscountTxt:FilterFrameText;
      
      private var _nextDiscountTxt:FilterFrameText;
      
      private var _nextNeedNumTxt:FilterFrameText;
      
      private var _totalNumTxt:FilterFrameText;
      
      private var _myNumTxt:FilterFrameText;
      
      private var _curRebateTxt:FilterFrameText;
      
      private var _nextRebateTxt:FilterFrameText;
      
      private var _miniNeedNum:FilterFrameText;
      
      private var _shopItemCell:GroupPurchaseShopCell;
      
      private var _rankFrame:GroupPurchaseRankFrame;
      
      private var _recordWonderfulFramePos:Point;
      
      private var _helpBtn:BaseButton;
      
      private var _endTime:Date;
      
      private var _timer:Timer;
      
      private var _timer2:Timer;
      
      private var _awardView:GroupPurchaseAwardView;
      
      public function GroupPurchaseMainView(){super();}
      
      private function initThis() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function initCountDown() : void{}
      
      private function initRefreshData() : void{}
      
      private function requestRefreshData(param1:TimerEvent) : void{}
      
      private function getRefreshDelay() : int{return 0;}
      
      private function rankBtnClickHandler(param1:MouseEvent) : void{}
      
      private function rankFrameDisposeHandler(param1:ComponentEvent) : void{}
      
      private function refreshView(param1:Event) : void{}
      
      private function refreshCountDownTime(param1:TimerEvent) : void{}
      
      public function init() : void{}
      
      public function content() : Sprite{return null;}
      
      public function setState(param1:int, param2:int) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
