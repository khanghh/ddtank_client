package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   
   public class LuckeyLotteryDrawIcon extends Sprite implements Disposeable
   {
       
      
      private var _activityIcon:Bitmap;
      
      private var _leftTimeTf:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _firstEnterCdSec:int;
      
      public function LuckeyLotteryDrawIcon()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _activityIcon = ComponentFactory.Instance.creat("asset.hall.callBackLotteryDrawIcon2");
         this.buttonMode = true;
         this.useHandCursor = true;
         addChild(_activityIcon);
         _leftTimeTf = ComponentFactory.Instance.creat("bossbox.TimeBoxStyle");
         _leftTimeTf.x = _activityIcon.x + (_activityIcon.width - _leftTimeTf.width) / 2;
         _leftTimeTf.y = _activityIcon.y + 1;
         addChild(_leftTimeTf);
         _firstEnterCdSec = CallBackLotteryDrawManager.instance.getLuckeyLeftSec();
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
      
      private function initEvent() : void
      {
         this.addEventListener("click",showFrame);
      }
      
      protected function showFrame(param1:MouseEvent) : void
      {
         var _loc2_:int = CallBackLotteryDrawManager.instance.luckeyLotteryDrawModel.phase;
         if(_firstEnterCdSec <= 0 && _loc2_ == 0 || _firstEnterCdSec >= 0 && _loc2_ > 0)
         {
            SoundManager.instance.playButtonSound();
            CallBackLotteryDrawManager.instance.type = 1;
            CallBackLotteryDrawManager.instance.show();
         }
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",showFrame);
         _timer && _timer.removeEventListener("timer",onTimerTick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_activityIcon);
         _activityIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
