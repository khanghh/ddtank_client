package starling.display.graphics
{
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import starling.display.DisplayObject;
   
   public class Plane extends Graphic
   {
       
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _numVerticesX:uint;
      
      private var _numVerticesY:uint;
      
      private var _vertexFunction:Function;
      
      public function Plane(param1:Number = 100, param2:Number = 100, param3:uint = 2, param4:uint = 2, param5:Function = null){super();}
      
      public static function defaultVertexFunction(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:int, param7:Vector.<Number>, param8:Matrix = null) : void{}
      
      public static function alphaFadeVertically(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:int, param7:Vector.<Number>, param8:Matrix = null) : void{}
      
      public static function alphaFadeHorizontally(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:int, param7:Vector.<Number>, param8:Matrix = null) : void{}
      
      public static function alphaFadeAllSides(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:int, param7:Vector.<Number>, param8:Matrix = null) : void{}
      
      public function set vertexFunction(param1:Function) : void{}
      
      public function get vertexFunction() : Function{return null;}
      
      override protected function buildGeometry() : void{}
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
   }
}
