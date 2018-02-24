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
      
      public function FilterFrameTextMiddleLine(param1:FilterFrameText){super();}
      
      public function get filterFrameText() : FilterFrameText{return null;}
      
      public function drawMiddleLines(param1:Number, param2:uint, param3:Number) : void{}
      
      public function drawMiddleLine(param1:Number, param2:uint, param3:Number, param4:int, param5:int) : void{}
      
      public function dispose() : void{}
   }
}
