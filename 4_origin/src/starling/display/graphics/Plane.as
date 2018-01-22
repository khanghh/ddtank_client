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
      
      public function Plane(param1:Number = 100, param2:Number = 100, param3:uint = 2, param4:uint = 2, param5:Function = null)
      {
         super();
         _width = param1;
         _height = param2;
         _numVerticesX = param3;
         _numVerticesY = param4;
         if(param5 == null)
         {
            _vertexFunction = defaultVertexFunction;
         }
         else
         {
            _vertexFunction = param5;
         }
         setGeometryInvalid();
      }
      
      public static function defaultVertexFunction(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:int, param7:Vector.<Number>, param8:Matrix = null) : void
      {
         var _loc9_:Number = param3 / (param5 - 1);
         var _loc10_:Number = param4 / (param6 - 1);
         param7.push(_loc9_ * param1,_loc10_ * param2,0,1,1,1,1,param1 / (param5 - 1),param2 / (param6 - 1));
      }
      
      public static function alphaFadeVertically(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:int, param7:Vector.<Number>, param8:Matrix = null) : void
      {
         var _loc9_:Number = param3 / (param5 - 1);
         var _loc10_:Number = param4 / (param6 - 1);
         param7.push(_loc9_ * param1,_loc10_ * param2,0,1,1,1,param2 == 0 || param2 == param6 - 1?0:1,param1 / (param5 - 1),param2 / (param6 - 1));
      }
      
      public static function alphaFadeHorizontally(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:int, param7:Vector.<Number>, param8:Matrix = null) : void
      {
         var _loc9_:Number = param3 / (param5 - 1);
         var _loc10_:Number = param4 / (param6 - 1);
         param7.push(_loc9_ * param1,_loc10_ * param2,0,1,1,1,param1 == 0 || param1 == param5 - 1?0:1,param1 / (param5 - 1),param2 / (param6 - 1));
      }
      
      public static function alphaFadeAllSides(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:int, param7:Vector.<Number>, param8:Matrix = null) : void
      {
         var _loc9_:Number = param3 / (param5 - 1);
         var _loc10_:Number = param4 / (param6 - 1);
         param7.push(_loc9_ * param1,_loc10_ * param2,0,1,1,1,param1 == 0 || param1 == param5 - 1 || param2 == 0 || param2 == param6 - 1?0:1,param1 / (param5 - 1),param2 / (param6 - 1));
      }
      
      public function set vertexFunction(param1:Function) : void
      {
         if(param1 == null)
         {
            throw new Error("Value must not be null");
         }
         _vertexFunction = param1;
         setGeometryInvalid();
      }
      
      public function get vertexFunction() : Function
      {
         return _vertexFunction;
      }
      
      override protected function buildGeometry() : void
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         vertices = new Vector.<Number>();
         indices = new Vector.<uint>();
         var _loc5_:int = _numVerticesX * _numVerticesY;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc3_ = _loc7_ % _numVerticesX;
            _loc6_ = _loc7_ / _numVerticesX;
            _vertexFunction(_loc3_,_loc6_,_width,_height,_numVerticesX,_numVerticesY,vertices,_uvMatrix);
            _loc7_++;
         }
         var _loc1_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _numVerticesY - 1)
         {
            _loc2_ = 0;
            while(_loc2_ < _numVerticesX - 1)
            {
               if(_loc4_ == 0 && _loc2_ == 0)
               {
                  indices.push(_loc1_,_loc1_ + 1,_loc1_ + _numVerticesX + 1);
                  indices.push(_loc1_ + _numVerticesX,_loc1_ + _numVerticesX + 1,_loc1_);
               }
               else if(_loc4_ == _numVerticesY - 2 && _loc2_ == _numVerticesX - 2)
               {
                  indices.push(_loc1_,_loc1_ + _numVerticesX + 1,_loc1_ + 1);
                  indices.push(_loc1_,_loc1_ + _numVerticesX,_loc1_ + _numVerticesX + 1);
               }
               else
               {
                  indices.push(_loc1_,_loc1_ + 1,_loc1_ + _numVerticesX);
                  indices.push(_loc1_ + _numVerticesX,_loc1_ + _numVerticesX + 1,_loc1_ + 1);
               }
               _loc1_++;
               _loc2_++;
            }
            _loc1_++;
            _loc4_++;
         }
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         minBounds.x = 0;
         minBounds.y = 0;
         maxBounds.x = _width;
         maxBounds.y = _height;
         return super.getBounds(param1,param2);
      }
   }
}
