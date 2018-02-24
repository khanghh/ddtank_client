package store.forge.wishBead
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class WishTips extends Sprite implements Disposeable
   {
      
      public static const BEGIN_Y:int = 130;
       
      
      private var _timer:Timer;
      
      private var _successBit:Bitmap;
      
      private var _failBit:Bitmap;
      
      private var _moveSprite:Sprite;
      
      public var isDisplayerTip:Boolean = true;
      
      public function WishTips(){super();}
      
      private function init() : void{}
      
      private function createTween(param1:Function = null, param2:Array = null) : void{}
      
      public function showSuccess(param1:Function) : void{}
      
      private function strengthTweenComplete(param1:String) : void{}
      
      public function showFail(param1:Function) : void{}
      
      private function __timerComplete(param1:TimerEvent) : void{}
      
      private function removeTips() : void{}
      
      public function dispose() : void{}
   }
}
