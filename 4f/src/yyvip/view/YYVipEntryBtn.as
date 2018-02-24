package yyvip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yyvip.YYVipManager;
   
   public class YYVipEntryBtn extends Sprite implements Disposeable
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _isCanUsable:Boolean = true;
      
      public function YYVipEntryBtn(){super();}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      public function dispose() : void{}
   }
}
