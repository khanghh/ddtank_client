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
      
      public function Plane(width:Number = 100, height:Number = 100, numVerticesX:uint = 2, numVerticesY:uint = 2, vertexFunction:Function = null)
      {
         super();
         _width = width;
         _height = height;
         _numVerticesX = numVerticesX;
         _numVerticesY = numVerticesY;
         if(vertexFunction == null)
         {
            _vertexFunction = defaultVertexFunction;
         }
         else
         {
            _vertexFunction = vertexFunction;
         }
         setGeometryInvalid();
      }
      
      public static function defaultVertexFunction(column:int, row:int, width:Number, height:Number, numVerticesX:int, numVerticesY:int, output:Vector.<Number>, uvMatrix:Matrix = null) : void
      {
         var segmentWidth:Number = width / (numVerticesX - 1);
         var segmentHeight:Number = height / (numVerticesY - 1);
         output.push(segmentWidth * column,segmentHeight * row,0,1,1,1,1,column / (numVerticesX - 1),row / (numVerticesY - 1));
      }
      
      public static function alphaFadeVertically(column:int, row:int, width:Number, height:Number, numVerticesX:int, numVerticesY:int, output:Vector.<Number>, uvMatrix:Matrix = null) : void
      {
         var segmentWidth:Number = width / (numVerticesX - 1);
         var segmentHeight:Number = height / (numVerticesY - 1);
         output.push(segmentWidth * column,segmentHeight * row,0,1,1,1,row == 0 || row == numVerticesY - 1?0:1,column / (numVerticesX - 1),row / (numVerticesY - 1));
      }
      
      public static function alphaFadeHorizontally(column:int, row:int, width:Number, height:Number, numVerticesX:int, numVerticesY:int, output:Vector.<Number>, uvMatrix:Matrix = null) : void
      {
         var segmentWidth:Number = width / (numVerticesX - 1);
         var segmentHeight:Number = height / (numVerticesY - 1);
         output.push(segmentWidth * column,segmentHeight * row,0,1,1,1,column == 0 || column == numVerticesX - 1?0:1,column / (numVerticesX - 1),row / (numVerticesY - 1));
      }
      
      public static function alphaFadeAllSides(column:int, row:int, width:Number, height:Number, numVerticesX:int, numVerticesY:int, output:Vector.<Number>, uvMatrix:Matrix = null) : void
      {
         var segmentWidth:Number = width / (numVerticesX - 1);
         var segmentHeight:Number = height / (numVerticesY - 1);
         output.push(segmentWidth * column,segmentHeight * row,0,1,1,1,column == 0 || column == numVerticesX - 1 || row == 0 || row == numVerticesY - 1?0:1,column / (numVerticesX - 1),row / (numVerticesY - 1));
      }
      
      public function set vertexFunction(value:Function) : void
      {
         if(value == null)
         {
            throw new Error("Value must not be null");
         }
         _vertexFunction = value;
         setGeometryInvalid();
      }
      
      public function get vertexFunction() : Function
      {
         return _vertexFunction;
      }
      
      override protected function buildGeometry() : void
      {
         var i:int = 0;
         var column:int = 0;
         var row:int = 0;
         var m:int = 0;
         var n:int = 0;
         vertices = new Vector.<Number>();
         indices = new Vector.<uint>();
         var numVertices:int = _numVerticesX * _numVerticesY;
         for(i = 0; i < numVertices; )
         {
            column = i % _numVerticesX;
            row = i / _numVerticesX;
            _vertexFunction(column,row,_width,_height,_numVerticesX,_numVerticesY,vertices,_uvMatrix);
            i++;
         }
         var qn:int = 0;
         for(m = 0; m < _numVerticesY - 1; )
         {
            for(n = 0; n < _numVerticesX - 1; )
            {
               if(m == 0 && n == 0)
               {
                  indices.push(qn,qn + 1,qn + _numVerticesX + 1);
                  indices.push(qn + _numVerticesX,qn + _numVerticesX + 1,qn);
               }
               else if(m == _numVerticesY - 2 && n == _numVerticesX - 2)
               {
                  indices.push(qn,qn + _numVerticesX + 1,qn + 1);
                  indices.push(qn,qn + _numVerticesX,qn + _numVerticesX + 1);
               }
               else
               {
                  indices.push(qn,qn + 1,qn + _numVerticesX);
                  indices.push(qn + _numVerticesX,qn + _numVerticesX + 1,qn + 1);
               }
               qn++;
               n++;
            }
            qn++;
            m++;
         }
      }
      
      override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         minBounds.x = 0;
         minBounds.y = 0;
         maxBounds.x = _width;
         maxBounds.y = _height;
         return super.getBounds(targetSpace,resultRect);
      }
   }
}
