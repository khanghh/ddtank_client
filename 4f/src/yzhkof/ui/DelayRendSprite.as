package yzhkof.ui{   import flash.display.Sprite;   import flash.events.Event;      public class DelayRendSprite extends Sprite   {                   private var _isCanceled:Boolean = false;            public function DelayRendSprite() { super(); }
            protected function upDateNextRend() : void { }
            protected function cancelUpDataNextRend() : void { }
            protected function cancelCurrentRend() : void { }
            protected function beforDraw() : void { }
            protected function onDraw() : void { }
            protected function afterDraw() : void { }
            private function __addToStage(e:Event) : void { }
            public final function draw() : void { }
            private function __onScreenRend(e:Event) : void { }
   }}