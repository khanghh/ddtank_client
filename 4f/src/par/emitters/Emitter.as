package par.emitters{   import flash.events.Event;   import flash.events.EventDispatcher;   import par.enginees.ParticleEnginee;   import par.particals.Particle;   import par.particals.ParticleInfo;   import road7th.math.randRange;      [Event(name="complete",type="flash.events.Event")]   public class Emitter extends EventDispatcher   {                   public var x:Number = 0;            public var y:Number = 0;            private var _info:EmitterInfo;            private var _enginee:ParticleEnginee;            private var _interval:Number = 0;            private var _age:Number = 0;            public var angle:Number = 0;            public var autoRestart:Boolean = false;            public function Emitter() { super(); }
            public function setEnginee(enginee:ParticleEnginee) : void { }
            public function restart() : void { }
            public function get info() : EmitterInfo { return null; }
            public function set info(value:EmitterInfo) : void { }
            public function execute(time:Number) : void { }
            public function dispose() : void { }
            protected function emit() : void { }
   }}