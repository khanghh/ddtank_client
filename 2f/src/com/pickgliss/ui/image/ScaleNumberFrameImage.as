package com.pickgliss.ui.image{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.geom.Point;   import flash.geom.Rectangle;      public class ScaleNumberFrameImage extends ScaleFrameImage   {                   private var _cutWidth:int;            private var _image:Bitmap;            public function ScaleNumberFrameImage() { super(); }
            public function set cutWidth(value:int) : void { }
            override protected function addChildren() : void { }
            override protected function resetDisplay() : void { }
            override public function setFrame(frameIndex:int) : void { }
            override public function dispose() : void { }
   }}