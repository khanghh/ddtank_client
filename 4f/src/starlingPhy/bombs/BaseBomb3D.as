package starlingPhy.bombs{   import bones.display.BoneMovieStarling;   import com.pickgliss.utils.StarlingObjectUtils;   import flash.display.Bitmap;   import flash.geom.Rectangle;   import road7th.utils.BoneMovieWrapper;   import starlingPhy.object.PhysicalObj3D;      public class BaseBomb3D extends PhysicalObj3D   {                   protected var _movieWrapper:BoneMovieWrapper;            protected var _movie:BoneMovieStarling;            protected var _shape:Bitmap;            protected var _border:Bitmap;            public function BaseBomb3D(id:int, mass:Number = 10, gfactor:Number = 100, windFactor:Number = 1, airResitFactor:Number = 1) { super(null,null,null,null,null,null); }
            public function setMovie(movie:BoneMovieStarling, shape:Bitmap, border:Bitmap) : void { }
            override public function update(dt:Number) : void { }
            override protected function collideGround() : void { }
            public function bomb() : void { }
            public function bombAtOnce() : void { }
            protected function DigMap() : void { }
            override public function die() : void { }
            override public function dispose() : void { }
   }}