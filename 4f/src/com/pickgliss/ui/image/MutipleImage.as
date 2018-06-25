package com.pickgliss.ui.image{   import com.pickgliss.geom.InnerRectangle;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.geom.Rectangle;      public class MutipleImage extends Image   {            public static const P_imageRect:String = "imagesRect";                   private var _imageLinks:Array;            private var _imageRectString:String;            private var _images:Vector.<DisplayObject>;            private var _imagesRect:Vector.<InnerRectangle>;            public function MutipleImage() { super(); }
            override public function dispose() : void { }
            public function set imageRectString(value:String) : void { }
            override protected function addChildren() : void { }
            override protected function init() : void { }
            override protected function resetDisplay() : void { }
            override protected function updateSize() : void { }
            private function creatImages() : void { }
            private function removeImages() : void { }
   }}