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
      
      public function CheckCodeMixedBack($width:Number, $height:Number, $color:Number)
      {
         super();
         _color = $color;
         _height = $height;
         _width = $width;
         _renderBox = new Sprite();
         addChild(_renderBox);
         createPoint();
         creatCurver();
         render();
      }
      
      private function createPoint() : void
      {
         var i:int = 0;
         _renderBox.graphics.beginFill(_color,0.5);
         for(i = 0; i < 20; )
         {
            _renderBox.graphics.drawCircle(Math.random() * _width,Math.random() * _height,Math.random() * 1.5);
            i++;
         }
         _renderBox.graphics.endFill();
      }
      
      private function creatCurver() : void
      {
         var i:int = 0;
         var rW:Number = NaN;
         var rH:Number = NaN;
         _renderBox.graphics.lineStyle(1,_color,0.5);
         for(i = 0; i < 20; )
         {
            rW = Math.random() * _width;
            rH = Math.random() * _height;
            _renderBox.graphics.moveTo(rW + (Math.random() * 10 - 10),rH + (Math.random() * 10 - 10));
            _renderBox.graphics.curveTo(rW + (Math.random() * 10 - 10),rH + (Math.random() * 10 - 10),rW,rH);
            i++;
         }
         _renderBox.graphics.endFill();
      }
      
      private function render() : void
      {
         addChild(_renderBox);
      }
   }
}
