package phy.bombs{   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.geom.Rectangle;   import phy.object.PhysicalObj;      public class BaseBomb extends PhysicalObj   {                   protected var _movie:Sprite;            protected var _shape:Bitmap;            protected var _border:Bitmap;            public function BaseBomb(id:int, mass:Number = 10, gfactor:Number = 100, windFactor:Number = 1, airResitFactor:Number = 1) { super(null,null,null,null,null,null); }
            public function setMovie(movie:Sprite, shape:Bitmap, border:Bitmap) : void { }
            override public function update(dt:Number) : void { }
            public function get bombRectang() : Rectangle { return null; }
            override protected function collideGround() : void { }
            public function bomb() : void { }
            public function bombAtOnce() : void { }
            protected function DigMap() : void { }
            override public function die() : void { }
            override public function dispose() : void { }
   }}