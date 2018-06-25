package par.enginees{   import flash.display.Sprite;   import flash.events.Event;   import flash.utils.Dictionary;   import par.emitters.Emitter;   import par.particals.Particle;   import par.particals.ParticleInfo;   import par.renderer.IParticleRenderer;      public class ParticleEnginee   {                   private var _maxCount:int;            private var _root:Sprite;            private var _last:int;            private var _emitters:Dictionary;            public var spareParticles:Dictionary;            public var particles:Vector.<Particle>;            private var _render:IParticleRenderer;            public var cachable:Boolean = true;            public function ParticleEnginee(render:IParticleRenderer) { super(); }
            public function setMaxCount(value:Number) : void { }
            public function addEmitter(emitter:Emitter) : void { }
            public function removeEmitter(emitter:Emitter) : void { }
            public function addParticle(particle:Particle) : void { }
            private function __enterFrame(event:Event) : void { }
            public function update() : void { }
            protected function cacheParticle(particle:Particle) : void { }
            public function reset() : void { }
            public function createParticle(info:ParticleInfo) : Particle { return null; }
            public function dispose() : void { }
   }}