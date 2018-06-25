package welfareCenter.callBackLotteryDraw.view{   import baglocked.BaglockedManager;   import com.greensock.TweenLite;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ArrayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawController;   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;   import welfareCenter.callBackLotteryDraw.LotteryDrawModel;      public class LuckeyLotteryDrawFrame extends Frame   {                   private var _nextCDTimeTf:FilterFrameText;            private var _cardShowMC:MovieClip;            private var _cardShuffleMC:MovieClip;            private var _cardOpenItemArr:Array;            private var _clickCardOpenItem:LuckeyCardOpenItem;            private var _startDrawBtn:SimpleBitmapButton;            private var _manager:CallBackLotteryDrawManager;            private var _model:LotteryDrawModel;            private var _timer:Timer;            private var _leftSec:int;            private var _buyBtnArr:Array;            private var _buyBtnClickIndex:int = -1;            private var _maskSp:Sprite;            private var _radomAwardArr:Array;            public function LuckeyLotteryDrawFrame() { super(); }
            private function initView() : void { }
            private function onInfoChange(evt:Event) : void { }
            private function onTimerTick(evt:TimerEvent) : void { }
            private function updateNextCDTimeTf() : void { }
            private function playCardShow() : void { }
            private function onCardShowEnterFrame(evt:Event) : void { }
            private function playCardShuffle() : void { }
            private function onCardShuffleEnterFrame(evt:Event) : void { }
            private function onCardShuffleOver() : void { }
            private function onClickCardOpenItem(evt:CEvent) : void { }
            private function onCardOpenPlayOver(evt:Event) : void { }
            private function onAllCardOpenPlayOver() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function onBtnClick(evt:MouseEvent) : void { }
            private function onBuy(evt:CEvent) : void { }
            private function responseHandler(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}