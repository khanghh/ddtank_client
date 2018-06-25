package par.enginees
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import par.emitters.Emitter;
   import par.particals.Particle;
   import par.particals.ParticleInfo;
   import par.renderer.IParticleRenderer;
   
   public class ParticleEnginee
   {
       
      
      private var _maxCount:int;
      
      private var _root:Sprite;
      
      private var _last:int;
      
      private var _emitters:Dictionary;
      
      public var spareParticles:Dictionary;
      
      public var particles:Vector.<Particle>;
      
      private var _render:IParticleRenderer;
      
      public var cachable:Boolean = true;
      
      public function ParticleEnginee(render:IParticleRenderer)
      {
         super();
         _render = render;
         _maxCount = 200;
         spareParticles = new Dictionary();
         particles = new Vector.<Particle>();
         _emitters = new Dictionary();
      }
      
      public function setMaxCount(value:Number) : void
      {
         _maxCount = value;
      }
      
      public function addEmitter(emitter:Emitter) : void
      {
         _emitters[emitter] = emitter;
         emitter.setEnginee(this);
      }
      
      public function removeEmitter(emitter:Emitter) : void
      {
         delete _emitters[emitter];
         emitter.setEnginee(null);
      }
      
      public function addParticle(particle:Particle) : void
      {
         particles.push(particle);
         _render.addParticle(particle);
      }
      
      private function __enterFrame(event:Event) : void
      {
         update();
      }
      
      public function update() : void
      {
         var p:* = null;
         var i:int = 0;
         while(particles.length > _maxCount)
         {
            p = particles.shift();
            _render.removeParticle(p);
            cacheParticle(p);
         }
         var time:* = 0.04;
         var _loc6_:int = 0;
         var _loc5_:* = _emitters;
         for each(var emitter in _emitters)
         {
            emitter.execute(time);
         }
         for(i = 0; i < particles.length; )
         {
            p = particles[i];
            p.age = p.age + time;
            if(p.age >= p.life)
            {
               particles.splice(i,1);
               _render.removeParticle(p);
               cacheParticle(p);
               i--;
            }
            else
            {
               p.update(time);
            }
            i++;
         }
         _render.renderParticles(particles);
      }
      
      protected function cacheParticle(particle:Particle) : void
      {
         particle.initialize();
         var cls:uint = particle.info.displayCreator;
         var cached:Array = spareParticles[cls];
         if(cached == null)
         {
            cached = [];
            spareParticles[cls] = [];
         }
         if(cached.length < 15)
         {
            cached.push(particle);
         }
      }
      
      public function reset() : void
      {
         particles = new Vector.<Particle>();
         spareParticles = new Dictionary();
         _emitters = new Dictionary();
         _render.reset();
      }
      
      public function createParticle(info:ParticleInfo) : Particle
      {
         if(spareParticles[info.displayCreator] && spareParticles[info.displayCreator].length > 0)
         {
            return spareParticles[info.displayCreator].shift();
         }
         return new Particle(info);
      }
      
      public function dispose() : void
      {
         _render.dispose();
      }
   }
}
