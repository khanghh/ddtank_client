package store.forge.wishBead{   import com.greensock.TweenMax;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class WishTips extends Sprite implements Disposeable   {            public static const BEGIN_Y:int = 130;                   private var _timer:Timer;            private var _successBit:Bitmap;            private var _failBit:Bitmap;            private var _moveSprite:Sprite;            public var isDisplayerTip:Boolean = true;            public function WishTips() { super(); }
            private function init() : void { }
            private function createTween(onComplete:Function = null, completeParam:Array = null) : void { }
            public function showSuccess(callback:Function) : void { }
            private function strengthTweenComplete(content:String) : void { }
            public function showFail(callback:Function) : void { }
            private function __timerComplete(evt:TimerEvent) : void { }
            private function removeTips() : void { }
            public function dispose() : void { }
   }}