package prayIndiana.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import flash.utils.setTimeout;   import invite.InviteManager;   import prayIndiana.PrayIndianaManager;   import store.HelpFrame;      public class PrayIndianaFrame extends Frame   {            public static var isFlag:Boolean;                   private var _BG:Bitmap;            private var _lotteryProTest:Bitmap;            private var _paopao:Bitmap;            private var _paopaoPray:Bitmap;            private var _tweenFrameBG:Bitmap;            private var _lotteryBtn:SimpleBitmapButton;            private var _refreshBtn:SimpleBitmapButton;            private var _prayBtn:SimpleBitmapButton;            private var _perfectPrayBtn:SimpleBitmapButton;            private var _helpText:FilterFrameText;            private var _prayText:FilterFrameText;            private var _paopaoText:FilterFrameText;            private var _probabilityText:FilterFrameText;            private var _paopaoPrayText:FilterFrameText;            private var _helpBtn:BaseButton;            private var _slide:SlideView;            private var _target:MovieClip;            private var _goodsView:PrayGoodsView;            private var _timerGoods:Timer;            private var _refreshTimer:Timer;            private var _isQuit:Boolean;            private var showStarTime:FilterFrameText;            private var _selectBtn3:SelectedCheckButton;            private var alert3:BaseAlerFrame;            private var _showTimer:Timer;            private var _selectBtn1:SelectedCheckButton;            private var alert1:BaseAlerFrame;            private var _selectBtn:SelectedCheckButton;            private var alert:BaseAlerFrame;            private var _selectBtn2:SelectedCheckButton;            private var alert2:BaseAlerFrame;            private var _goodsIndex:int;            private var indexNum:int;            public function PrayIndianaFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __refreshBtn(e:MouseEvent) : void { }
            private function __updateGoods(e:Event) : void { }
            private function __refreshTimerHandler(e:TimerEvent) : void { }
            private function __refreshComplete(e:TimerEvent) : void { }
            private function __showGoodsTimer(e:TimerEvent) : void { }
            private function __onClickRefreshSelectedBtn(e:MouseEvent) : void { }
            private function __onRecoverRefreshResponse(e:FrameEvent) : void { }
            private function __onKeyDownHander(event:KeyboardEvent) : void { }
            private function __onPrayBtn(e:MouseEvent) : void { }
            private function __prayStart(e:Event) : void { }
            private function updateSlide() : Number { return 0; }
            private function __PerfectPrayBtn(e:MouseEvent) : void { }
            private function __onClickSelectedBtn(e:MouseEvent) : void { }
            private function __onClickPraySelectedBtn(e:MouseEvent) : void { }
            private function __onRecoverResponse(e:FrameEvent) : void { }
            private function __onRecoverPrayResponse(e:FrameEvent) : void { }
            private function showSlide() : void { }
            private function __lotteryBtn(e:MouseEvent) : void { }
            public function goodsJump() : void { }
            private function __goodsTimerHandler(e:TimerEvent) : void { }
            private function goodsTimerComplete(index:int) : void { }
            private function __goodsTimerComplete(e:TimerEvent) : void { }
            private function showGoodsItem() : void { }
            private function showLotteryGoods(index:int) : void { }
            private function __onClickLotterySelectedBtn(e:MouseEvent) : void { }
            private function __onRecoverLotteryResponse(e:FrameEvent) : void { }
            protected function __onHelpClick(event:MouseEvent) : void { }
            private function enableBtnToFalse() : void { }
            private function enableBtnToTrue() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            public function updateLotteryNumber() : void { }
            private function visiblePaopao(num:int) : void { }
            private function visiblePaopaoPray(num:int) : void { }
            private function showTarget() : void { }
            override public function dispose() : void { }
   }}