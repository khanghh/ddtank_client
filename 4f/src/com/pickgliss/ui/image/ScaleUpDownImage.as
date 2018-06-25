package com.pickgliss.ui.image{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;      public class ScaleUpDownImage extends Image   {                   private var _bitmaps:Vector.<Bitmap>;            private var _imageLinks:Array;            public function ScaleUpDownImage() { super(); }
            override public function dispose() : void { }
            override protected function addChildren() : void { }
            override protected function resetDisplay() : void { }
            override protected function updateSize() : void { }
            private function creatImages() : void { }
            private function drawImage() : void { }
            private function removeImages() : void { }
   }}