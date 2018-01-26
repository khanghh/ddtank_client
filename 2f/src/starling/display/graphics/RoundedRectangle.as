package starling.display.graphics
{
   public class RoundedRectangle extends Graphic
   {
       
      
      private const DEGREES_TO_RADIANS:Number = 0.017453292519943295;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _topLeftRadius:Number;
      
      private var _topRightRadius:Number;
      
      private var _bottomLeftRadius:Number;
      
      private var _bottomRightRadius:Number;
      
      private var strokePoints:Vector.<Number>;
      
      public function RoundedRectangle(param1:Number = 100, param2:Number = 100, param3:Number = 10, param4:Number = 10, param5:Number = 10, param6:Number = 10){super();}
      
      override public function set width(param1:Number) : void{}
      
      override public function get height() : Number{return 0;}
      
      override public function set height(param1:Number) : void{}
      
      public function get cornerRadius() : Number{return 0;}
      
      public function set cornerRadius(param1:Number) : void{}
      
      public function get topLeftRadius() : Number{return 0;}
      
      public function set topLeftRadius(param1:Number) : void{}
      
      public function get topRightRadius() : Number{return 0;}
      
      public function set topRightRadius(param1:Number) : void{}
      
      public function get bottomLeftRadius() : Number{return 0;}
      
      public function set bottomLeftRadius(param1:Number) : void{}
      
      public function get bottomRightRadius() : Number{return 0;}
      
      public function set bottomRightRadius(param1:Number) : void{}
      
      public function getStrokePoints() : Vector.<Number>{return null;}
      
      override protected function buildGeometry() : void{}
   }
}
