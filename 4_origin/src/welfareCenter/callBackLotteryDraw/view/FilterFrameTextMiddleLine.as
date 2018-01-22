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
      
      public function FilterFrameTextMiddleLine(param1:FilterFrameText)
      {
         super();
         _filterFrameText = param1;
         addChild(_filterFrameText);
         _lineShape = new Shape();
         addChild(_lineShape);
      }
      
      public function get filterFrameText() : FilterFrameText
      {
         return _filterFrameText;
      }
      
      public function drawMiddleLines(param1:Number, param2:uint, param3:Number) : void
      {
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:* = null;
         var _loc13_:int = 0;
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Graphics = _lineShape.graphics;
         _loc4_.clear();
         var _loc6_:int = _filterFrameText.numLines;
         if(_loc6_ > 0)
         {
            _loc4_.lineStyle(param1,param2,param3);
            _loc10_ = _filterFrameText.defaultTextFormat.leading;
            _loc7_ = 2;
            _loc9_ = 0;
            while(_loc9_ < _loc6_)
            {
               _loc11_ = _filterFrameText.getLineMetrics(_loc9_);
               _loc13_ = _loc11_.x;
               _loc12_ = _loc11_.width;
               _loc8_ = _loc11_.height;
               _loc5_ = _loc7_ + (_loc8_ - _loc10_) * 0.5;
               _loc4_.moveTo(_loc13_,_loc5_);
               _loc4_.lineTo(_loc13_ + _loc12_,_loc5_);
               _loc7_ = _loc7_ + _loc8_;
               _loc9_++;
            }
         }
      }
      
      public function drawMiddleLine(param1:Number, param2:uint, param3:Number, param4:int, param5:int) : void
      {
         var _loc7_:Graphics = _lineShape.graphics;
         _loc7_.clear();
         _loc7_.lineStyle(param1,param2,param3);
         var _loc11_:Rectangle = _filterFrameText.getCharBoundaries(param4);
         var _loc10_:Rectangle = _filterFrameText.getCharBoundaries(param5);
         var _loc12_:int = _filterFrameText.defaultTextFormat.leading;
         var _loc8_:int = 2;
         var _loc13_:TextLineMetrics = _filterFrameText.getLineMetrics(0);
         var _loc15_:int = _loc13_.x;
         var _loc14_:int = _loc13_.width;
         var _loc9_:int = _loc13_.height;
         var _loc6_:int = _loc8_ + (_loc9_ - _loc12_) * 0.5;
         _loc7_.moveTo(_loc11_.x,_loc6_);
         _loc7_.lineTo(_loc10_.right,_loc6_);
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
