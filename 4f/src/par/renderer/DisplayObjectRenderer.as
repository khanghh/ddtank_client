package par.renderer
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import par.particals.Particle;
   
   public class DisplayObjectRenderer extends Sprite implements IParticleRenderer
   {
       
      
      private var layers:Dictionary;
      
      public function DisplayObjectRenderer(){super();}
      
      public function renderParticles(param1:Vector.<Particle>) : void{}
      
      public function addParticle(param1:Particle) : void{}
      
      public function removeParticle(param1:Particle) : void{}
      
      public function reset() : void{}
      
      public function dispose() : void{}
   }
}
