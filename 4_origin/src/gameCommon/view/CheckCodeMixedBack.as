package gameCommon.view
{
   import flash.display.Sprite;
   
   public class CheckCodeMixedBack extends Sprite
   {
      
      private static const CUVER_MAX:int = 10;
      
      private static const PointNum:int = 20;
      
      private static const CuverNum:int = 20;
       
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _color:uint;
      
      private var _renderBox:Sprite;
      
      private var masker:Sprite;
      
      public function CheckCodeMixedBack(param1:Number, param2:Number, param3:Number)
      {
         super();
         _color = param3;
         _height = param2;
         _width = param1;
         _renderBox = new Sprite();
         addChild(_renderBox);
         createPoint();
         creatCurver();
         render();
      }
      
      private function createPoint() : void
      {
         var _loc1_:int = 0;
         _renderBox.graphics.beginFill(_color,0.5);
         _loc1_ = 0;
         while(_loc1_ < 20)
         {
            _renderBox.graphics.drawCircle(Math.random() * _width,Math.random() * _height,Math.random() * 1.5);
            _loc1_++;
         }
         _renderBox.graphics.endFill();
      }
      
      private function creatCurver() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         _renderBox.graphics.lineStyle(1,_color,0.5);
         _loc3_ = 0;
         while(_loc3_ < 20)
         {
            _loc2_ = Math.random() * _width;
            _loc1_ = Math.random() * _height;
            _renderBox.graphics.moveTo(_loc2_ + (Math.random() * 10 - 10),_loc1_ + (Math.random() * 10 - 10));
            _renderBox.graphics.curveTo(_loc2_ + (Math.random() * 10 - 10),_loc1_ + (Math.random() * 10 - 10),_loc2_,_loc1_);
            _loc3_++;
         }
         _renderBox.graphics.endFill();
      }
      
      private function render() : void
      {
         addChild(_renderBox);
      }
   }
}
