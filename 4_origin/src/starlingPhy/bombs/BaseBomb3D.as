package starlingPhy.bombs
{
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import road7th.utils.BoneMovieWrapper;
   import starlingPhy.object.PhysicalObj3D;
   
   public class BaseBomb3D extends PhysicalObj3D
   {
       
      
      protected var _movieWrapper:BoneMovieWrapper;
      
      protected var _movie:BoneMovieStarling;
      
      protected var _shape:Bitmap;
      
      protected var _border:Bitmap;
      
      public function BaseBomb3D(id:int, mass:Number = 10, gfactor:Number = 100, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super(id,1,mass,gfactor,windFactor,airResitFactor);
         _testRect = new Rectangle(-3,-3,6,6);
      }
      
      public function setMovie(movie:BoneMovieStarling, shape:Bitmap, border:Bitmap) : void
      {
         StarlingObjectUtils.disposeObject(_movie);
         _movie = movie;
         _movieWrapper = new BoneMovieWrapper(_movie,true);
         if(_movie)
         {
            _movie.x = 0;
            _movie.y = 0;
            addChild(_movie);
         }
         _shape = shape;
         _border = border;
      }
      
      override public function update(dt:Number) : void
      {
         super.update(dt);
      }
      
      override protected function collideGround() : void
      {
         this.bomb();
      }
      
      public function bomb() : void
      {
         DigMap();
         this.die();
      }
      
      public function bombAtOnce() : void
      {
      }
      
      protected function DigMap() : void
      {
         if(_shape && _shape.width > 0 && _shape.height > 0)
         {
            _map.Dig(pos,_shape,_border);
         }
      }
      
      override public function die() : void
      {
         super.die();
         if(_map)
         {
            _map.removePhysical(this);
         }
      }
      
      override public function dispose() : void
      {
         _movieWrapper.dispose();
         _movieWrapper = null;
         StarlingObjectUtils.disposeObject(_movie);
         _movie = null;
         _shape = null;
         _border = null;
         super.dispose();
      }
   }
}
