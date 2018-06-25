package welfareCenter.callBackLotteryDraw.view{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import flash.display.Graphics;   import flash.display.Shape;   import flash.display.Sprite;   import flash.geom.Rectangle;   import flash.text.TextLineMetrics;      public class FilterFrameTextMiddleLine extends Sprite implements Disposeable   {                   private var _filterFrameText:FilterFrameText;            private var _lineShape:Shape;            public function FilterFrameTextMiddleLine(filterFrameText:FilterFrameText) { super(); }
            public function get filterFrameText() : FilterFrameText { return null; }
            public function drawMiddleLines(thickness:Number, color:uint, alpha:Number) : void { }
            public function drawMiddleLine(thickness:Number, color:uint, alpha:Number, startIndex:int, endIndex:int) : void { }
            public function dispose() : void { }
   }}