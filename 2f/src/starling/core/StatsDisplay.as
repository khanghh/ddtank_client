package starling.core{   import flash.system.System;   import starling.display.Quad;   import starling.display.Sprite;   import starling.events.EnterFrameEvent;   import starling.text.TextField;      class StatsDisplay extends Sprite   {                   private const UPDATE_INTERVAL:Number = 0.5;            private var mBackground:Quad;            private var mTextField:TextField;            private var mFrameCount:int = 0;            private var mTotalTime:Number = 0;            private var mFps:Number = 0;            private var mMemory:Number = 0;            private var mDrawCount:int = 0;            function StatsDisplay() { super(); }
            private function onAddedToStage() : void { }
            private function onRemovedFromStage() : void { }
            private function onEnterFrame(event:EnterFrameEvent) : void { }
            public function update() : void { }
            override public function render(support:RenderSupport, parentAlpha:Number) : void { }
            public function get drawCount() : int { return 0; }
            public function set drawCount(value:int) : void { }
            public function get fps() : Number { return 0; }
            public function set fps(value:Number) : void { }
            public function get memory() : Number { return 0; }
            public function set memory(value:Number) : void { }
   }}