package ddt.display{   import com.pickgliss.ui.core.Disposeable;   import flash.display.Graphics;   import flash.display.Sprite;   import flash.geom.Matrix;      public class BitmapSprite extends Sprite implements Disposeable   {                   protected var _bitmap:BitmapObject;            protected var _matrix:Matrix;            protected var _repeat:Boolean;            protected var _smooth:Boolean;            protected var _w:int;            protected var _h:int;            public function BitmapSprite(bitmap:BitmapObject = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false) { super(); }
            public function set bitmapObject(val:BitmapObject) : void { }
            public function get bitmapObject() : BitmapObject { return null; }
            protected function drawBitmap() : void { }
            protected function configUI() : void { }
            public function dispose() : void { }
   }}