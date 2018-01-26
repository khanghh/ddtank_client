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
      
      public function ConsortiaDomainIcon(){super();}
      
      private function initView() : void{}
      
      private function onTimerTick(param1:TimerEvent) : void{}
      
      private function updateLeftTimeTf() : void{}
      
      private function initEvent() : void{}
      
      protected function enterBossSence(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
