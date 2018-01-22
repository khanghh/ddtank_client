package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class ConsortiaDomainIcon extends Sprite implements Disposeable
   {
       
      
      private var _activityIcon:Bitmap;
      
      private var _lastClickTime:int = 0;
      
      private var _leftTimeTf:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _coldDownSec:int;
      
      public function ConsortiaDomainIcon()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _activityIcon = ComponentFactory.Instance.creat("asset.hall.consortiaDomainIcon");
         this.buttonMode = true;
         _activityIcon.y = -11;
         addChild(_activityIcon);
         _leftTimeTf = ComponentFactory.Instance.creat("bossbox.TimeBoxStyle");
         _leftTimeTf.x = _activityIcon.x + (_activityIcon.width - _leftTimeTf.width) / 2;
         _leftTimeTf.y = _activityIcon.y + 1;
         addChild(_leftTimeTf);
         _coldDownSec = (ConsortiaDomainManager.instance.model.BeginTime.time - TimeManager.Instance.NowTime()) / 1000;
         if(_coldDownSec > 0)
         {
            _timer = new Timer(1000,_coldDownSec);
            _timer.addEventListener("timer",onTimerTick);
            _timer.start();
         }
         updateLeftTimeTf();
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         _coldDownSec = Number(_coldDownSec) - 1;
         if(_coldDownSec <= 0)
         {
            _coldDownSec = 0;
            _timer.stop();
            _timer.removeEventListener("timer",onTimerTick);
         }
         updateLeftTimeTf();
      }
      
      private function updateLeftTimeTf() : void
      {
         var _loc1_:Array = TimeManager.getHHMMSSArr(_coldDownSec);
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
         this.addEventListener("click",enterBossSence);
      }
      
      protected function enterBossSence(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = getTimer();
         if(_loc2_ - _lastClickTime > 1000)
         {
            ConsortiaDomainManager.instance.enterScene(true);
            _lastClickTime = _loc2_;
         }
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",enterBossSence);
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
