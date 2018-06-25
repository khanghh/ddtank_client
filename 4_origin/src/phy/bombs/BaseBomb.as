package phy.bombs
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import phy.object.PhysicalObj;
   
   public class BaseBomb extends PhysicalObj
   {
       
      
      protected var _movie:Sprite;
      
      protected var _shape:Bitmap;
      
      protected var _border:Bitmap;
      
      public function BaseBomb(id:int, mass:Number = 10, gfactor:Number = 100, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super(id,1,mass,gfactor,windFactor,airResitFactor);
         _testRect = new Rectangle(-3,-3,6,6);
      }
      
      public function setMovie(movie:Sprite, shape:Bitmap, border:Bitmap) : void
      {
         _movie = movie;
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
      
      public function get bombRectang() : Rectangle
      {
         if(_map && _shape)
         {
            return _shape.getRect(_map);
         }
         return new Rectangle(x - 200,y - 200,400,400);
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
         super.dispose();
         if(_movie && _movie.parent)
         {
            _movie.parent.removeChild(_movie);
         }
         _shape = null;
         _border = null;
      }
   }
}
