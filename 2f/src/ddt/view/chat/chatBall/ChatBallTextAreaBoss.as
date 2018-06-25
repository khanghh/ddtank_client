package ddt.view.chat.chatBall{   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Rectangle;   import flash.text.StyleSheet;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class ChatBallTextAreaBoss extends ChatBallTextAreaNPC   {                   private const TYPEDLENGTH:int = 1;            private const TYPEINTERVAL:int = 80;            private var _maskMC:Sprite;            private var _bmdata:BitmapData;            private var _bmp:Bitmap;            private var _typeTimer:TimerJuggler;            private var _count:int;            public var animation:Boolean = true;            public function ChatBallTextAreaBoss() { super(); }
            override protected function setFormat() : void { }
            override public function set text(value:String) : void { }
            private function __onTypeTimerTick(e:Event) : void { }
            private function drawFullMask() : void { }
            private function redrawMask(location:int) : void { }
            override protected function clear() : void { }
            private function textDisplayCompleted() : void { }
            override public function dispose() : void { }
   }}