package particleSystem{   import com.pickgliss.ui.core.Disposeable;   import flash.geom.Point;   import flash.utils.Dictionary;   import particleSystem.events.ParticleEvent;   import particleSystem.loader.ParticleZipLoader;   import starling.core.Starling;   import starling.display.DisplayObjectContainer;   import starling.events.Event;      public class ParticleRenderInfo implements Disposeable   {                   public var emitter:DisplayObjectContainer;            public var particleList:Vector.<PDParticleSystemWithID>;            public var isEmitting:Boolean;            public var isWeather:Boolean;            private var _propertiesDic:Dictionary;            private var _idList:Array;            private var _emitterPoint:Point;            public var id:Number = 0;            public var name:String = "";            private var _addAngle:Number = 0;            public function ParticleRenderInfo() { super(); }
            private function __particleLoaded(evt:ParticleEvent) : void { }
            private function updateProperties() : void { }
            public function set emitterPoint(p:Point) : void { }
            public function addParticles(arr:Array) : void { }
            public function removeParticleById(id:String) : void { }
            public function stopParticles() : void { }
            private function __particleComplete(evt:Event) : void { }
            public function update(duration:Number = 1.7976931348623157E308) : void { }
            public function set addAngle(value:Number) : void { }
            public function start(duration:Number = 1.7976931348623157E308) : void { }
            public function stop() : void { }
            public function reset() : void { }
            public function dispose() : void { }
            public function setPropertiesDic(name:String, value:int) : void { }
   }}