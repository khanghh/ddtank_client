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
      
      public function ParticleEnginee(param1:IParticleRenderer)
      {
         super();
         _render = param1;
         _maxCount = 200;
         spareParticles = new Dictionary();
         particles = new Vector.<Particle>();
         _emitters = new Dictionary();
      }
      
      public function setMaxCount(param1:Number) : void
      {
         _maxCount = param1;
      }
      
      public function addEmitter(param1:Emitter) : void
      {
         _emitters[param1] = param1;
         param1.setEnginee(this);
      }
      
      public function removeEmitter(param1:Emitter) : void
      {
         delete _emitters[param1];
         param1.setEnginee(null);
      }
      
      public function addParticle(param1:Particle) : void
      {
         particles.push(param1);
         _render.addParticle(param1);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         update();
      }
      
      public function update() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         while(particles.length > _maxCount)
         {
            _loc2_ = particles.shift();
            _render.removeParticle(_loc2_);
            cacheParticle(_loc2_);
         }
         var _loc1_:* = 0.04;
         var _loc6_:int = 0;
         var _loc5_:* = _emitters;
         for each(var _loc3_ in _emitters)
         {
            _loc3_.execute(_loc1_);
         }
         _loc4_ = 0;
         while(_loc4_ < particles.length)
         {
            _loc2_ = particles[_loc4_];
            _loc2_.age = _loc2_.age + _loc1_;
            if(_loc2_.age >= _loc2_.life)
            {
               particles.splice(_loc4_,1);
               _render.removeParticle(_loc2_);
               cacheParticle(_loc2_);
               _loc4_--;
            }
            else
            {
               _loc2_.update(_loc1_);
            }
            _loc4_++;
         }
         _render.renderParticles(particles);
      }
      
      protected function cacheParticle(param1:Particle) : void
      {
         param1.initialize();
         var _loc3_:uint = param1.info.displayCreator;
         var _loc2_:Array = spareParticles[_loc3_];
         if(_loc2_ == null)
         {
            _loc2_ = [];
            spareParticles[_loc3_] = [];
         }
         if(_loc2_.length < 15)
         {
            _loc2_.push(param1);
         }
      }
      
      public function reset() : void
      {
         particles = new Vector.<Particle>();
         spareParticles = new Dictionary();
         _emitters = new Dictionary();
         _render.reset();
      }
      
      public function createParticle(param1:ParticleInfo) : Particle
      {
         if(spareParticles[param1.displayCreator] && spareParticles[param1.displayCreator].length > 0)
         {
            return spareParticles[param1.displayCreator].shift();
         }
         return new Particle(param1);
      }
      
      public function dispose() : void
      {
         _render.dispose();
      }
   }
}
