package com.pickgliss.utils
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public final class DisplayUtils
   {
      
      private static const ZERO_POINT:Point = new Point(0,0);
       
      
      public function DisplayUtils(){super();}
      
      public static function removeDisplay(... rest) : DisplayObject{return null;}
      
      public static function drawRectShape(param1:Number, param2:Number, param3:Shape = null) : Shape{return null;}
      
      public static function drawTextShape(param1:TextField) : DisplayObject{return null;}
      
      public static function isInTheStage(param1:Point, param2:DisplayObjectContainer = null) : Boolean{return false;}
      
      public static function layoutDisplayWithInnerRect(param1:DisplayObject, param2:InnerRectangle, param3:int, param4:int) : void{}
      
      public static function setFrame(param1:DisplayObject, param2:int) : void{}
      
      public static function setDisplayObjectNotEnable(param1:DisplayObject) : void{}
      
      public static function getTextFieldLineHeight(param1:TextField) : int{return 0;}
      
      public static function getTextFieldCareLinePosY(param1:TextField) : Number{return 0;}
      
      public static function getTextFieldCareLinePosX(param1:TextField) : Number{return 0;}
      
      public static function getVisibleSize(param1:DisplayObject) : Rectangle{return null;}
      
      public static function getTextFieldMaxLineWidth(param1:String, param2:TextFormat, param3:Boolean) : Number{return 0;}
      
      public static function isTargetOrContain(param1:DisplayObject, param2:DisplayObject) : Boolean{return false;}
      
      public static function getPointFromObject(param1:Point, param2:DisplayObject, param3:DisplayObject) : Point{return null;}
      
      public static function clearChildren(param1:Sprite) : void{}
      
      public static function getDisplayBitmapData(param1:DisplayObject) : BitmapData{return null;}
      
      public static function localizePoint(param1:DisplayObject, param2:DisplayObject, param3:Point = null) : Point{return null;}
      
      public static function setDisplayPos(param1:DisplayObject, param2:Point) : void{}
      
      public static function changeSize(param1:DisplayObject, param2:int, param3:int) : void{}
      
      public static function horizontalArrange(param1:Sprite, param2:int = 1, param3:Number = 0, param4:Number = 0) : void{}
      
      public static function verticalArrange(param1:Sprite, param2:int = 1, param3:Number = 0, param4:Number = 0) : void{}
   }
}
