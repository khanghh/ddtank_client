package welfareCenter.callBackLotteryDraw.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextLineMetrics;
   
   public class FilterFrameTextMiddleLine extends Sprite implements Disposeable
   {
       
      
      private var _filterFrameText:FilterFrameText;
      
      private var _lineShape:Shape;
      
      public function FilterFrameTextMiddleLine(filterFrameText:FilterFrameText)
      {
         super();
         _filterFrameText = filterFrameText;
         addChild(_filterFrameText);
         _lineShape = new Shape();
         addChild(_lineShape);
      }
      
      public function get filterFrameText() : FilterFrameText
      {
         return _filterFrameText;
      }
      
      public function drawMiddleLines(thickness:Number, color:uint, alpha:Number) : void
      {
         var leading:int = 0;
         var offsetY:int = 0;
         var i:int = 0;
         var metrics:* = null;
         var metricsX:int = 0;
         var metricsW:int = 0;
         var metricsH:int = 0;
         var lineY:int = 0;
         var g:Graphics = _lineShape.graphics;
         g.clear();
         var numLines:int = _filterFrameText.numLines;
         if(numLines > 0)
         {
            g.lineStyle(thickness,color,alpha);
            leading = _filterFrameText.defaultTextFormat.leading;
            offsetY = 2;
            for(i = 0; i < numLines; )
            {
               metrics = _filterFrameText.getLineMetrics(i);
               metricsX = metrics.x;
               metricsW = metrics.width;
               metricsH = metrics.height;
               lineY = offsetY + (metricsH - leading) * 0.5;
               g.moveTo(metricsX,lineY);
               g.lineTo(metricsX + metricsW,lineY);
               offsetY = offsetY + metricsH;
               i++;
            }
         }
      }
      
      public function drawMiddleLine(thickness:Number, color:uint, alpha:Number, startIndex:int, endIndex:int) : void
      {
         var g:Graphics = _lineShape.graphics;
         g.clear();
         g.lineStyle(thickness,color,alpha);
         var startRect:Rectangle = _filterFrameText.getCharBoundaries(startIndex);
         var endRect:Rectangle = _filterFrameText.getCharBoundaries(endIndex);
         var leading:int = _filterFrameText.defaultTextFormat.leading;
         var offsetY:int = 2;
         var metrics:TextLineMetrics = _filterFrameText.getLineMetrics(0);
         var metricsX:int = metrics.x;
         var metricsW:int = metrics.width;
         var metricsH:int = metrics.height;
         var lineY:int = offsetY + (metricsH - leading) * 0.5;
         g.moveTo(startRect.x,lineY);
         g.lineTo(endRect.right,lineY);
      }
      
      public function dispose() : void
      {
         _filterFrameText.dispose();
         _filterFrameText = null;
         _lineShape.graphics.clear();
         _lineShape = null;
      }
   }
}
