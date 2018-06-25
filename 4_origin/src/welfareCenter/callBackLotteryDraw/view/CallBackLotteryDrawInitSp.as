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
      
      public function CallBackLotteryDrawInitSp()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var card:* = null;
         _bg = UICreatShortcut.creatAndAdd("callbacklotterydraw.pic1",this);
         _manager = CallBackLotteryDrawManager.instance;
         _model = _manager.callBackLotteryDrawModel;
         _nextCDTimeTf = UICreatShortcut.creatAndAdd("callbacklotterydraw.nextCDTimeTf",this);
         for(i = 1; i <= 5; )
         {
            card = UICreatShortcut.creatAndAdd("callbacklotterydraw.pic5",this);
            PositionUtils.setPos(card,"callbacklotterydraw.cardBackSidePos" + i);
            i++;
         }
         _startDrawBtn = UICreatShortcut.creatAndAdd("callbacklotterydraw.startDrawBtn",this);
         _startDrawBtn.enable = false;
         onInfoChange(null);
      }
      
      private function onInfoChange(evt:Event) : void
      {
         _leftSec = _manager.getCallBackLeftSec();
         _offsetLeftSec = _leftSec + 2;
         if(_offsetLeftSec > 0)
         {
            if(_timer)
            {
               _timer.reset();
               _timer.delay = 1000;
               _timer.repeatCount = _offsetLeftSec;
               _timer.addEventListener("timer",onTimerTick);
               _timer.start();
            }
            else
            {
               _timer = new Timer(1000,_offsetLeftSec);
               _timer.addEventListener("timer",onTimerTick);
               _timer.start();
            }
         }
         updateNextCDTimeTf();
      }
      
      private function onTimerTick(evt:TimerEvent) : void
      {
         _leftSec = Number(_leftSec) - 1;
         if(_leftSec <= 0)
         {
            _leftSec = 0;
         }
         _offsetLeftSec = Number(_offsetLeftSec) - 1;
         if(_offsetLeftSec <= 0)
         {
            _offsetLeftSec = 0;
            _timer.removeEventListener("timer",onTimerTick);
            _timer.stop();
            if(_model.phase == 0)
            {
               _manager.queryLotteryGoods(0);
            }
         }
         updateNextCDTimeTf();
      }
      
      private function updateNextCDTimeTf() : void
      {
         var timeArr:Array = TimeManager.getHHMMSSArr(_leftSec);
         if(timeArr)
         {
            _nextCDTimeTf.text = LanguageMgr.GetTranslation("callbacklotterdraw.nextCDTimeTxt") + timeArr.join(":");
         }
         else
         {
            _nextCDTimeTf.text = LanguageMgr.GetTranslation("callbacklotterdraw.nextCDTimeTxt") + "00:00:00";
         }
      }
      
      public function dispose() : void
      {
         _timer && _timer.removeEventListener("timer",onTimerTick);
         _timer && _timer.stop();
         ObjectUtils.disposeAllChildren(this);
         _nextCDTimeTf = null;
         _timer = null;
         _bg = null;
         _startDrawBtn = null;
         _manager = null;
         _model = null;
      }
   }
}
