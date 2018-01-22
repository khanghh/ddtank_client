package welfareCenter.icon
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.TimeManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   
   public class WelfareCenterItemTime extends WelfareCenterItem
   {
       
      
      private var _leftTimeTf:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _firstEnterCdSec:int;
      
      public function WelfareCenterItemTime(param1:int)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         _leftTimeTf = ComponentFactory.Instance.creat("bossbox.TimeBoxStyle");
         _leftTimeTf.x = _icon.x + (_icon.width - _leftTimeTf.width) / 2 - 12;
         _leftTimeTf.y = _icon.y + 1;
         addChild(_leftTimeTf);
         _firstEnterCdSec = CallBackLotteryDrawManager.instance.getCallBackLeftSec();
         if(_firstEnterCdSec > 0)
         {
            _timer = new Timer(1000,_firstEnterCdSec);
            _timer.addEventListener("timer",onTimerTick);
            _timer.start();
         }
         updateLeftTimeTf();
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         _firstEnterCdSec = Number(_firstEnterCdSec) - 1;
         if(_firstEnterCdSec <= 0)
         {
            _firstEnterCdSec = 0;
            _timer.stop();
            _timer.removeEventListener("timer",onTimerTick);
         }
         updateLeftTimeTf();
      }
      
      private function updateLeftTimeTf() : void
      {
         var _loc1_:Array = TimeManager.getHHMMSSArr(_firstEnterCdSec);
         if(_loc1_)
         {
            _leftTimeTf.text = _loc1_.join(":");
         }
         else
         {
            _leftTimeTf.text = "";
         }
      }
      
      override public function get canClick() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = CallBackLotteryDrawManager.instance.callBackLotteryDrawModel.phase;
         if(_firstEnterCdSec <= 0 && _loc1_ == 0 || _loc1_ > 0)
         {
            return true;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         _timer && _timer.removeEventListener("timer",onTimerTick);
         _timer && _timer.stop();
         super.dispose();
         _leftTimeTf = null;
         _timer = null;
      }
   }
}
