package starling.animation{   import starling.events.Event;   import starling.events.EventDispatcher;      public class Juggler implements IAnimatable   {                   private var mObjects:Vector.<IAnimatable>;            private var mElapsedTime:Number;            public function Juggler() { super(); }
            public function add(object:IAnimatable) : void { }
            public function contains(object:IAnimatable) : Boolean { return false; }
            public function remove(object:IAnimatable) : void { }
            public function removeTweens(target:Object) : void { }
            public function containsTweens(target:Object) : Boolean { return false; }
            public function purge() : void { }
            public function delayCall(call:Function, delay:Number, ... args) : IAnimatable { return null; }
            public function repeatCall(call:Function, interval:Number, repeatCount:int = 0, ... args) : IAnimatable { return null; }
            private function onPooledDelayedCallComplete(event:Event) : void { }
            public function tween(target:Object, time:Number, properties:Object) : IAnimatable { return null; }
            private function onPooledTweenComplete(event:Event) : void { }
            public function advanceTime(time:Number) : void { }
            private function onRemove(event:Event) : void { }
            public function get elapsedTime() : Number { return 0; }
            protected function get objects() : Vector.<IAnimatable> { return null; }
   }}