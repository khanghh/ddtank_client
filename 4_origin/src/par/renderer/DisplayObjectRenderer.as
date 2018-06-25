package par.renderer
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import par.particals.Particle;
   
   public class DisplayObjectRenderer extends Sprite implements IParticleRenderer
   {
       
      
      private var layers:Dictionary;
      
      public function DisplayObjectRenderer()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         layers = new Dictionary();
      }
      
      public function renderParticles(particles:Vector.<Particle>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = particles;
         for each(var p in particles)
         {
            p.image.transform.colorTransform = p.colorTransform;
            p.image.transform.matrix = p.matrixTransform;
         }
      }
      
      public function addParticle(particle:Particle) : void
      {
         var ly:Sprite = layers[particle.info];
         if(ly == null)
         {
            ly = new Sprite();
            layers[particle.info] = new Sprite();
            ly.blendMode = "layer";
            addChild(ly);
         }
         if(particle.info.keepOldFirst)
         {
            ly.addChild(particle.image);
         }
         else
         {
            ly.addChildAt(particle.image,0);
         }
      }
      
      public function removeParticle(particle:Particle) : void
      {
         var ly:Sprite = layers[particle.info];
         if(ly && ly.contains(particle.image))
         {
            ly.removeChild(particle.image);
         }
      }
      
      public function reset() : void
      {
         var i:int = 0;
         layers = new Dictionary();
         var len:Number = numChildren;
         for(i = 0; i < len; )
         {
            this.removeChildAt(0);
            i++;
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
