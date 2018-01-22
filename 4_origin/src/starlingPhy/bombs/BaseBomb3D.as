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
      
      public function BaseBomb3D(param1:int, param2:Number = 10, param3:Number = 100, param4:Number = 1, param5:Number = 1)
      {
         super(param1,1,param2,param3,param4,param5);
         _testRect = new Rectangle(-3,-3,6,6);
      }
      
      public function setMovie(param1:BoneMovieStarling, param2:Bitmap, param3:Bitmap) : void
      {
         StarlingObjectUtils.disposeObject(_movie);
         _movie = param1;
         _movieWrapper = new BoneMovieWrapper(_movie,true);
         if(_movie)
         {
            _movie.x = 0;
            _movie.y = 0;
            addChild(_movie);
         }
         _shape = param2;
         _border = param3;
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
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
