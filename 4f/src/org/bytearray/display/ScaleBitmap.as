package org.bytearray.display{   import com.pickgliss.ui.core.Disposeable;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.geom.Matrix;   import flash.geom.Rectangle;      public class ScaleBitmap extends Bitmap implements Disposeable   {                   protected var _originalBitmap:BitmapData;            protected var _scale9Grid:Rectangle = null;            public function ScaleBitmap(bmpData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false) { super(null,null,null); }
            override public function set bitmapData(bmpData:BitmapData) : void { }
            public function dispose() : void { }
            public function getOriginalBitmapData() : BitmapData { return null; }
            override public function set height(h:Number) : void { }
            override public function get scale9Grid() : Rectangle { return null; }
            override public function set scale9Grid(r:Rectangle) : void { }
            public function setSize(w:Number, h:Number) : void { }
            override public function set width(w:Number) : void { }
            protected function resizeBitmap(w:Number, h:Number) : void { }
            private function assignBitmapData(bmp:BitmapData) : void { }
            private function validGrid(r:Rectangle) : Boolean { return false; }
   }}