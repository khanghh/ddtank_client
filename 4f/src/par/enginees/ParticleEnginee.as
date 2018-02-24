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
      
      public function ParticleEnginee(param1:IParticleRenderer){super();}
      
      public function setMaxCount(param1:Number) : void{}
      
      public function addEmitter(param1:Emitter) : void{}
      
      public function removeEmitter(param1:Emitter) : void{}
      
      public function addParticle(param1:Particle) : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      public function update() : void{}
      
      protected function cacheParticle(param1:Particle) : void{}
      
      public function reset() : void{}
      
      public function createParticle(param1:ParticleInfo) : Particle{return null;}
      
      public function dispose() : void{}
   }
}
