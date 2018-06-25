package com.pickgliss.utils{   import com.pickgliss.geom.InnerRectangle;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;   import flash.display.InteractiveObject;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.text.TextField;   import flash.text.TextFormat;      public final class DisplayUtils   {            private static const ZERO_POINT:Point = new Point(0,0);                   public function DisplayUtils() { super(); }
            public static function removeDisplay(... args) : DisplayObject { return null; }
            public static function drawRectShape($width:Number, $height:Number, target:Shape = null) : Shape { return null; }
            public static function drawTextShape(sourceTextField:TextField) : DisplayObject { return null; }
            public static function isInTheStage(point:Point, parent:DisplayObjectContainer = null) : Boolean { return false; }
            public static function layoutDisplayWithInnerRect(com:DisplayObject, innerRect:InnerRectangle, width:int, height:int) : void { }
            public static function setFrame(display:DisplayObject, frameIndex:int) : void { }
            public static function setDisplayObjectNotEnable(display:DisplayObject) : void { }
            public static function getTextFieldLineHeight(field:TextField) : int { return 0; }
            public static function getTextFieldCareLinePosY(field:TextField) : Number { return 0; }
            public static function getTextFieldCareLinePosX(field:TextField) : Number { return 0; }
            public static function getVisibleSize(o:DisplayObject) : Rectangle { return null; }
            public static function getTextFieldMaxLineWidth(value:String, format:TextFormat, isHtmlText:Boolean) : Number { return 0; }
            public static function isTargetOrContain(target:DisplayObject, container:DisplayObject) : Boolean { return false; }
            public static function getPointFromObject(point:Point, pointInDisplay:DisplayObject, targetDisplay:DisplayObject) : Point { return null; }
            public static function clearChildren(container:Sprite) : void { }
            public static function getDisplayBitmapData(display:DisplayObject) : BitmapData { return null; }
            public static function localizePoint(to:DisplayObject, from:DisplayObject, p:Point = null) : Point { return null; }
            public static function setDisplayPos(display:DisplayObject, pos:Point) : void { }
            public static function changeSize(obj:DisplayObject, w:int, h:int) : void { }
            public static function horizontalArrange(obj:Sprite, column:int = 1, hSpace:Number = 0, vSpace:Number = 0) : void { }
            public static function verticalArrange(obj:Sprite, column:int = 1, hSpace:Number = 0, vSpace:Number = 0) : void { }
   }}