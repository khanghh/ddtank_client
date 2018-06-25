package game.animations{   import com.greensock.TimelineMax;   import com.greensock.TweenMax;   import com.greensock.TweenProxy;   import com.pickgliss.ui.core.Disposeable;   import ddt.utils.BitmapUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Shape;   import flash.display.Sprite;   import flash.filters.GlowFilter;      public class ScaleEffect extends Sprite implements Disposeable   {                   private var src1:Bitmap;            private var src2:Bitmap;            private var mainTimeLine:TimelineMax;            private var tp1:TweenProxy;            private var tp2:TweenProxy;            public function ScaleEffect(type:int, srcBmd:BitmapData, dir:int = 1) { super(); }
            private function runScale(srcBmd:BitmapData) : void { }
            private function runUpToDown(srcBmd:BitmapData) : void { }
            private function runRightToLeft(srcBmd:BitmapData) : void { }
            private function changeRegist() : void { }
            private function runDownToUp(srcBmd:BitmapData) : void { }
            private function runLeftToRight(srcBmd:BitmapData) : void { }
            private function centerToScale(srcBmd:BitmapData) : void { }
            public function dispose() : void { }
   }}