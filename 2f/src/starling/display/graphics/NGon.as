package starling.display.graphics
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import starling.display.graphics.util.TriangleUtil;
   
   public class NGon extends Graphic
   {
      
      private static var _uv:Point;
       
      
      private const DEGREES_TO_RADIANS:Number = 0.017453292519943295;
      
      private var _radius:Number;
      
      private var _innerRadius:Number;
      
      private var _startAngle:Number;
      
      private var _endAngle:Number;
      
      private var _numSides:int;
      
      private var _color:uint = 16777215;
      
      private var _textureAlongPath:Boolean = false;
      
      public function NGon(param1:Number = 100, param2:int = 10, param3:Number = 0, param4:Number = 0, param5:Number = 360, param6:Boolean = false){super();}
      
      private static function buildSimpleNGon(param1:Number, param2:int, param3:Vector.<Number>, param4:Vector.<uint>, param5:Matrix, param6:uint) : void{}
      
      private static function buildHoop(param1:Number, param2:Number, param3:int, param4:Vector.<Number>, param5:Vector.<uint>, param6:Matrix, param7:uint, param8:Boolean) : void{}
      
      private static function buildFan(param1:Number, param2:Number, param3:Number, param4:int, param5:Vector.<Number>, param6:Vector.<uint>, param7:Matrix, param8:uint) : void{}
      
      private static function buildArc(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Vector.<Number>, param7:Vector.<uint>, param8:Matrix, param9:uint, param10:Boolean) : void{}
      
      public function get endAngle() : Number{return 0;}
      
      public function set endAngle(param1:Number) : void{}
      
      public function get startAngle() : Number{return 0;}
      
      public function set startAngle(param1:Number) : void{}
      
      public function get radius() : Number{return 0;}
      
      public function set color(param1:uint) : void{}
      
      public function set radius(param1:Number) : void{}
      
      public function get innerRadius() : Number{return 0;}
      
      public function set innerRadius(param1:Number) : void{}
      
      public function get numSides() : int{return 0;}
      
      public function set numSides(param1:int) : void{}
      
      override protected function buildGeometry() : void{}
      
      override protected function shapeHitTestLocalInternal(param1:Number, param2:Number) : Boolean{return false;}
   }
}
