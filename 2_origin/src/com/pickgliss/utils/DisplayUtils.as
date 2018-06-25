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
       
      
      public function DisplayUtils()
      {
         super();
      }
      
      public static function removeDisplay(... args) : DisplayObject
      {
         var _loc4_:int = 0;
         var _loc3_:* = args;
         for each(var display in args)
         {
            if(display && display.parent)
            {
               display.parent.removeChild(display);
            }
         }
         return args[0];
      }
      
      public static function drawRectShape($width:Number, $height:Number, target:Shape = null) : Shape
      {
         var sp:* = null;
         if(target == null)
         {
            sp = new Shape();
         }
         else
         {
            sp = target;
         }
         sp.graphics.clear();
         sp.graphics.beginFill(16711680,1);
         sp.graphics.drawRect(0,0,$width,$height);
         sp.graphics.endFill();
         return sp;
      }
      
      public static function drawTextShape(sourceTextField:TextField) : DisplayObject
      {
         var i:* = 0;
         var j:* = 0;
         var col:* = 0;
         var alphaChannel:* = 0;
         var alphaValue:Number = NaN;
         var textBitmapData:BitmapData = new BitmapData(sourceTextField.width,sourceTextField.height,true,16711680);
         textBitmapData.draw(sourceTextField);
         var textGraphics:Shape = new Shape();
         textGraphics.cacheAsBitmap = true;
         for(i = uint(0); i < textBitmapData.width; )
         {
            for(j = uint(0); j < textBitmapData.height; )
            {
               col = uint(textBitmapData.getPixel32(i,j));
               alphaChannel = uint(col >> 24 & 255);
               alphaValue = alphaChannel / 255;
               if(col > 0)
               {
                  textGraphics.graphics.beginFill(0,alphaValue);
                  textGraphics.graphics.drawCircle(i,j,1);
               }
               j++;
            }
            i++;
         }
         return textGraphics;
      }
      
      public static function isInTheStage(point:Point, parent:DisplayObjectContainer = null) : Boolean
      {
         var stagePoint:* = point;
         if(parent)
         {
            stagePoint = parent.localToGlobal(point);
         }
         if(stagePoint.x < 0 || stagePoint.y < 0 || stagePoint.x > StageReferance.stageWidth || stagePoint.y > StageReferance.stageHeight)
         {
            return false;
         }
         return true;
      }
      
      public static function layoutDisplayWithInnerRect(com:DisplayObject, innerRect:InnerRectangle, width:int, height:int) : void
      {
         if(innerRect == null)
         {
            return;
         }
         if(com is Component)
         {
            Component(com).beginChanges();
         }
         var rect:Rectangle = innerRect.getInnerRect(width,height);
         com.x = rect.x;
         com.y = rect.y;
         com.width = rect.width;
         com.height = rect.height;
         if(com is Component)
         {
            Component(com).commitChanges();
         }
      }
      
      public static function setFrame(display:DisplayObject, frameIndex:int) : void
      {
         if(display is Image)
         {
            Image(display).setFrame(frameIndex);
         }
         else if(display is MovieClip)
         {
            MovieClip(display).gotoAndStop(frameIndex);
         }
         else if(display is FilterFrameText)
         {
            FilterFrameText(display).setFrame(frameIndex);
         }
         else if(display is GradientText)
         {
            GradientText(display).setFrame(frameIndex);
         }
      }
      
      public static function setDisplayObjectNotEnable(display:DisplayObject) : void
      {
         if(display is InteractiveObject)
         {
            InteractiveObject(display).mouseEnabled = false;
         }
         if(display is DisplayObjectContainer)
         {
            DisplayObjectContainer(display).mouseChildren = false;
            DisplayObjectContainer(display).mouseEnabled = false;
         }
      }
      
      public static function getTextFieldLineHeight(field:TextField) : int
      {
         return field.getLineMetrics(0).height;
      }
      
      public static function getTextFieldCareLinePosY(field:TextField) : Number
      {
         var lastCareCharIndex:int = field.caretIndex - 1;
         var charCode:int = field.text.charCodeAt(lastCareCharIndex);
         var lastCareCharlineIndex:int = field.getLineIndexOfChar(lastCareCharIndex);
         var careCharLineIndex:* = 0;
         if(charCode == 13)
         {
            careCharLineIndex = int(lastCareCharlineIndex + 1);
         }
         else
         {
            careCharLineIndex = lastCareCharlineIndex;
         }
         return getTextFieldLineHeight(field) * careCharLineIndex;
      }
      
      public static function getTextFieldCareLinePosX(field:TextField) : Number
      {
         var lastCareCharIndex:int = field.caretIndex - 1;
         var lastCharPos:Rectangle = field.getCharBoundaries(lastCareCharIndex);
         if(lastCharPos == null)
         {
            return 0;
         }
         return lastCharPos.x + lastCharPos.width;
      }
      
      public static function getVisibleSize(o:DisplayObject) : Rectangle
      {
         var bounds:* = null;
         var bitmapDataSize:int = 2000;
         var bitmapData:BitmapData = new BitmapData(bitmapDataSize,bitmapDataSize,true,0);
         bitmapData.draw(o);
         bounds = bitmapData.getColorBoundsRect(4278190080,0,false);
         bitmapData.dispose();
         var retultRect:Rectangle = new Rectangle(bounds.x,bounds.y,bounds.x + bounds.width,bounds.y + bounds.height);
         return retultRect;
      }
      
      public static function getTextFieldMaxLineWidth(value:String, format:TextFormat, isHtmlText:Boolean) : Number
      {
         var linesText:* = null;
         var i:int = 0;
         var textField:TextField = new TextField();
         textField.autoSize = "left";
         if(isHtmlText)
         {
            value = value.replace("<BR>","\n");
            value = value.replace("<Br>","\n");
            value = value.replace("<bR>","\n");
            value = value.replace("<br>","\n");
         }
         linesText = value.split("\n");
         var maxWidth:* = 0;
         for(i = 0; i < linesText.length; )
         {
            if(isHtmlText)
            {
               textField.htmlText = linesText[i];
            }
            else
            {
               textField.text = linesText[i];
               textField.setTextFormat(format);
            }
            maxWidth = Number(Math.max(maxWidth,textField.width));
            i++;
         }
         return maxWidth + 2;
      }
      
      public static function isTargetOrContain(target:DisplayObject, container:DisplayObject) : Boolean
      {
         if(target == null)
         {
            return false;
         }
         if(target == container)
         {
            return true;
         }
         if(container is DisplayObjectContainer)
         {
            return DisplayObjectContainer(container).contains(target);
         }
         return false;
      }
      
      public static function getPointFromObject(point:Point, pointInDisplay:DisplayObject, targetDisplay:DisplayObject) : Point
      {
         var pt:Point = pointInDisplay.localToGlobal(point);
         var targetLocalPoint:Point = targetDisplay.globalToLocal(pt);
         return targetLocalPoint;
      }
      
      public static function clearChildren(container:Sprite) : void
      {
         while(container.numChildren > 0)
         {
            container.removeChildAt(0);
         }
      }
      
      public static function getDisplayBitmapData(display:DisplayObject) : BitmapData
      {
         if(display is Bitmap)
         {
            return Bitmap(display).bitmapData;
         }
         var bmd:BitmapData = new BitmapData(display.width,display.height,true,0);
         bmd.draw(display);
         return bmd;
      }
      
      public static function localizePoint(to:DisplayObject, from:DisplayObject, p:Point = null) : Point
      {
         return to.globalToLocal(from.localToGlobal(!!p?p:new Point(0,0)));
      }
      
      public static function setDisplayPos(display:DisplayObject, pos:Point) : void
      {
         display.x = pos.x;
         display.y = pos.y;
      }
      
      public static function changeSize(obj:DisplayObject, w:int, h:int) : void
      {
         obj.width = w;
         obj.height = h;
      }
      
      public static function horizontalArrange(obj:Sprite, column:int = 1, hSpace:Number = 0, vSpace:Number = 0) : void
      {
         var i:int = 0;
         var maxHeight:int = 0;
         var j:int = 0;
         var ch:* = null;
         var n:int = 0;
         var posX:int = ZERO_POINT.x;
         var posY:int = ZERO_POINT.y;
         var tempWidth:int = 0;
         var tempHeight:int = 0;
         var rowNum:int = Math.ceil(obj.numChildren / column);
         for(i = 0; i < rowNum; )
         {
            maxHeight = 0;
            for(j = 0; j < column; )
            {
               n++;
               ch = obj.getChildAt(n);
               ch.x = posX;
               ch.y = posY;
               tempWidth = Math.max(tempWidth,posX + ch.width);
               tempHeight = Math.max(tempHeight,posY + ch.height);
               posX = posX + (ch.width + hSpace);
               if(maxHeight < ch.height)
               {
                  maxHeight = ch.height;
               }
               if(n >= obj.numChildren)
               {
                  changeSize(obj,tempWidth,tempHeight);
                  return;
               }
               j++;
            }
            posX = ZERO_POINT.x;
            posY = posY + (maxHeight + vSpace);
            i++;
         }
         changeSize(obj,tempWidth,tempHeight);
      }
      
      public static function verticalArrange(obj:Sprite, column:int = 1, hSpace:Number = 0, vSpace:Number = 0) : void
      {
         var i:int = 0;
         var maxWidth:int = 0;
         var j:int = 0;
         var ch:* = null;
         var n:int = 0;
         var posX:int = ZERO_POINT.x;
         var posY:int = ZERO_POINT.y;
         var tempWidth:int = 0;
         var tempHeight:int = 0;
         var rowNum:int = Math.ceil(obj.numChildren / column);
         for(i = 0; i < rowNum; )
         {
            maxWidth = 0;
            for(j = 0; j < column; )
            {
               n++;
               ch = obj.getChildAt(n);
               ch.x = posX;
               ch.y = posY;
               tempWidth = Math.max(tempWidth,posX + ch.width);
               tempHeight = Math.max(tempHeight,posY + ch.height);
               posY = posY + (ch.height + vSpace);
               if(maxWidth < ch.width)
               {
                  maxWidth = ch.width;
               }
               if(n >= obj.numChildren)
               {
                  changeSize(obj,tempWidth,tempHeight);
                  return;
               }
               j++;
            }
            posX = posX + (maxWidth + hSpace);
            posY = ZERO_POINT.y;
            i++;
         }
         changeSize(obj,tempWidth,tempHeight);
      }
   }
}
