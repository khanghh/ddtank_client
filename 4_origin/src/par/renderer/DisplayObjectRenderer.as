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
      
      public function renderParticles(param1:Vector.<Particle>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc2_.image.transform.colorTransform = _loc2_.colorTransform;
            _loc2_.image.transform.matrix = _loc2_.matrixTransform;
         }
      }
      
      public function addParticle(param1:Particle) : void
      {
         var _loc2_:Sprite = layers[param1.info];
         if(_loc2_ == null)
         {
            _loc2_ = new Sprite();
            layers[param1.info] = new Sprite();
            _loc2_.blendMode = "layer";
            addChild(_loc2_);
         }
         if(param1.info.keepOldFirst)
         {
            _loc2_.addChild(param1.image);
         }
         else
         {
            _loc2_.addChildAt(param1.image,0);
         }
      }
      
      public function removeParticle(param1:Particle) : void
      {
         var _loc2_:Sprite = layers[param1.info];
         if(_loc2_ && _loc2_.contains(param1.image))
         {
            _loc2_.removeChild(param1.image);
         }
      }
      
      public function reset() : void
      {
         var _loc2_:int = 0;
         layers = new Dictionary();
         var _loc1_:Number = numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.removeChildAt(0);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
