package particleSystem{   import flash.geom.Point;   import starling.core.Starling;   import starling.display.DisplayObjectContainer;   import starling.display.Sprite;   import starling.events.Event;   import starling.events.ResizeEvent;      public class ParticleRender   {            private static var _instance:ParticleRender;                   private var _renderList:Vector.<ParticleRenderInfo>;            public function ParticleRender() { super(); }
            public static function get Instance() : ParticleRender { return null; }
            public function registerParticle(emitter:DisplayObjectContainer, particleId:Number, particleIdList:Array, emitterPoint:Point = null) : ParticleRenderInfo { return null; }
            public function unRegisterParticle(emitter:DisplayObjectContainer) : void { }
            public function addWeather(layer:DisplayObjectContainer, particleId:*, particleIdList:Array) : void { }
            public function addParticleAtPoint(layer:DisplayObjectContainer, point:Point, particleId:Number, particleIdList:Array) : void { }
            public function turnOn() : void { }
            public function turnOff() : void { }
            private function __resizeStarling(evt:ResizeEvent) : void { }
            private function __render(evt:Event) : void { }
   }}