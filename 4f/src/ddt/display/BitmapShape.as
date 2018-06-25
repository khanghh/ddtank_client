package ddt.display{   import com.pickgliss.ui.core.Disposeable;   import flash.display.Graphics;   import flash.display.Shape;   import flash.geom.Matrix;      public class BitmapShape extends Shape implements Disposeable   {                   private var _bitmap:BitmapObject;            private var _matrix:Matrix;            private var _repeat:Boolean;            private var _smooth:Boolean;            public function BitmapShape(bitmap:BitmapObject = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false) { super(); }
            public function set bitmapObject(val:BitmapObject) : void { }
            public function get bitmapObject() : BitmapObject { return null; }
            protected function draw() : void { }
            public function dispose() : void { }
   }}