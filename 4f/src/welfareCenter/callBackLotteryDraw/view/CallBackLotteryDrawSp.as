package welfareCenter.callBackLotteryDraw.view
{
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ArrayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawController;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   import welfareCenter.callBackLotteryDraw.LotteryDrawModel;
   
   public class CallBackLotteryDrawSp extends Sprite implements Disposeable
   {
       
      
      private var _nextCDTimeTf:FilterFrameText;
      
      private var _cardShowMC:MovieClip;
      
      private var _cardShuffleMC:MovieClip;
      
      private var _cardOpenItemArr:Array;
      
      private var _clickCardOpenItem:CallBackCardOpenItem;
      
      private var _startDrawBtn:SimpleBitmapButton;
      
      private var _manager:CallBackLotteryDrawManager;
      
      private var _model:LotteryDrawModel;
      
      private var _timer:Timer;
      
      private var _leftSec:int;
      
      private var _buyBtnArr:Array;
      
      private var _buyBtnClickIndex:int = -1;
      
      private var _maskSp:Sprite;
      
      private var _bg:Bitmap;
      
      private var _radomAwardArr:Array;
      
      public function CallBackLotteryDrawSp(){super();}
      
      private function initView() : void{}
      
      private function onInfoChange(param1:Event) : void{}
      
      private function onTimerTick(param1:TimerEvent) : void{}
      
      private function updateNextCDTimeTf() : void{}
      
      private function playCardShow() : void{}
      
      private function onCardShowEnterFrame(param1:Event) : void{}
      
      private function playCardShuffle() : void{}
      
      private function onCardShuffleEnterFrame(param1:Event) : void{}
      
      private function onCardShuffleOver() : void{}
      
      private function onClickCardOpenItem(param1:CEvent) : void{}
      
      private function onCardOpenPlayOver(param1:Event) : void{}
      
      private function onAllCardOpenPlayOver() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onBtnClick(param1:MouseEvent) : void{}
      
      private function onBuy(param1:CEvent) : void{}
      
      public function dispose() : void{}
   }
}
