package welfareCenter.callBackLotteryDraw.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   import welfareCenter.callBackLotteryDraw.LotteryDrawModel;
   
   public class CallBackLotteryDrawInitSp extends Sprite implements Disposeable
   {
       
      
      private var _nextCDTimeTf:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _leftSec:int;
      
      private var _offsetLeftSec:int;
      
      private var _bg:Bitmap;
      
      private var _startDrawBtn:SimpleBitmapButton;
      
      private var _manager:CallBackLotteryDrawManager;
      
      private var _model:LotteryDrawModel;
      
      public function CallBackLotteryDrawInitSp(){super();}
      
      private function initView() : void{}
      
      private function onInfoChange(param1:Event) : void{}
      
      private function onTimerTick(param1:TimerEvent) : void{}
      
      private function updateNextCDTimeTf() : void{}
      
      public function dispose() : void{}
   }
}
