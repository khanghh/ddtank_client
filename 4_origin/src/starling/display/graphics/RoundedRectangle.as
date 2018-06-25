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
      
      public function RoundedRectangle(width:Number = 100, height:Number = 100, topLeftRadius:Number = 10, topRightRadius:Number = 10, bottomLeftRadius:Number = 10, bottomRightRadius:Number = 10)
      {
         super();
         this.width = width;
         this.height = height;
         this.topLeftRadius = topLeftRadius;
         this.topRightRadius = topRightRadius;
         this.bottomLeftRadius = bottomLeftRadius;
         this.bottomRightRadius = bottomRightRadius;
      }
      
      override public function set width(value:Number) : void
      {
         value = value < 0?0:Number(value);
         _width = value;
         maxBounds.x = _width;
         setGeometryInvalid();
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      override public function set height(value:Number) : void
      {
         value = value < 0?0:Number(value);
         _height = value;
         maxBounds.y = _height;
         setGeometryInvalid();
      }
      
      public function get cornerRadius() : Number
      {
         return _topLeftRadius;
      }
      
      public function set cornerRadius(value:Number) : void
      {
         value = value < 0?0:Number(value);
         _bottomRightRadius = value;
         _bottomLeftRadius = value;
         _topRightRadius = value;
         _topLeftRadius = value;
         setGeometryInvalid();
      }
      
      public function get topLeftRadius() : Number
      {
         return _topLeftRadius;
      }
      
      public function set topLeftRadius(value:Number) : void
      {
         value = value < 0?0:Number(value);
         _topLeftRadius = value;
         setGeometryInvalid();
      }
      
      public function get topRightRadius() : Number
      {
         return _topRightRadius;
      }
      
      public function set topRightRadius(value:Number) : void
      {
         value = value < 0?0:Number(value);
         _topRightRadius = value;
         setGeometryInvalid();
      }
      
      public function get bottomLeftRadius() : Number
      {
         return _bottomLeftRadius;
      }
      
      public function set bottomLeftRadius(value:Number) : void
      {
         value = value < 0?0:Number(value);
         _bottomLeftRadius = value;
         setGeometryInvalid();
      }
      
      public function get bottomRightRadius() : Number
      {
         return _bottomRightRadius;
      }
      
      public function set bottomRightRadius(value:Number) : void
      {
         value = value < 0?0:Number(value);
         _bottomRightRadius = value;
         setGeometryInvalid();
      }
      
      public function getStrokePoints() : Vector.<Number>
      {
         validateNow();
         return strokePoints;
      }
      
      override protected function buildGeometry() : void
      {
         var numSides:int = 0;
         var i:int = 0;
         var radians:Number = NaN;
         var sin:Number = NaN;
         var cos:Number = NaN;
         var x:Number = NaN;
         var y:Number = NaN;
         strokePoints = new Vector.<Number>();
         vertices = new Vector.<Number>();
         indices = new Vector.<uint>();
         var halfWidth:Number = _width * 0.5;
         var halfHeight:Number = _height * 0.5;
         var tlr:Number = Math.min(halfWidth,halfHeight,_topLeftRadius);
         var trr:Number = Math.min(halfWidth,halfHeight,_topRightRadius);
         var blr:Number = Math.min(halfWidth,halfHeight,_bottomLeftRadius);
         var brr:Number = Math.min(halfWidth,halfHeight,_bottomRightRadius);
         vertices.push(tlr,0,0,1,1,1,1,tlr / _width,0);
         vertices.push(tlr,tlr,0,1,1,1,1,tlr / _width,tlr / _height);
         vertices.push(0,tlr,0,1,1,1,1,0,tlr / _height);
         vertices.push(_width - trr,0,0,1,1,1,1,(_width - trr) / _width,0);
         vertices.push(_width - trr,trr,0,1,1,1,1,(_width - trr) / _width,trr / _height);
         vertices.push(_width,trr,0,1,1,1,1,1,trr / _height);
         vertices.push(blr,_height,0,1,1,1,1,blr / _width,1);
         vertices.push(blr,_height - blr,0,1,1,1,1,blr / _width,(_height - blr) / _height);
         vertices.push(0,_height - blr,0,1,1,1,1,0,(_height - blr) / _height);
         vertices.push(_width - brr,_height,0,1,1,1,1,(_width - brr) / _width,1);
         vertices.push(_width - brr,_height - brr,0,1,1,1,1,(_width - brr) / _width,(_height - brr) / _height);
         vertices.push(_width,_height - brr,0,1,1,1,1,1,(_height - brr) / _height);
         var numVertices:int = 12;
         indices.push(0,3,1,1,3,4,2,1,8,8,1,7,7,1,4,7,4,10,10,4,5,10,5,11,6,7,10,6,10,9);
         strokePoints.push(0,tlr);
         if(tlr > 0)
         {
            numSides = tlr * 0.25;
            numSides = numSides < 1?1:numSides;
            for(i = 0; i < numSides; )
            {
               radians = (i + 1) / (numSides + 1) * 3.14159265358979 * 0.5;
               radians = radians + 3.14159265358979 * 1.5;
               sin = Math.sin(radians);
               cos = Math.cos(radians);
               x = tlr + sin * tlr;
               y = tlr - cos * tlr;
               vertices.push(x,y,0,1,1,1,1,x / _width,y / _height);
               strokePoints.push(x,y);
               numVertices++;
               if(i == 0)
               {
                  indices.push(1,2,numVertices - 1);
               }
               else
               {
                  indices.push(1,numVertices - 2,numVertices - 1);
               }
               if(i == numSides - 1)
               {
                  indices.push(1,numVertices - 1,0);
               }
               i++;
            }
         }
         strokePoints.push(tlr,0);
         strokePoints.push(_width - trr,0);
         if(trr > 0)
         {
            numSides = trr * 0.25;
            numSides = numSides < 1?1:numSides;
            for(i = 0; i < numSides; )
            {
               radians = (i + 1) / (numSides + 1) * 3.14159265358979 * 0.5;
               sin = Math.sin(radians);
               cos = Math.cos(radians);
               x = _width - trr + sin * trr;
               y = trr - cos * trr;
               vertices.push(x,y,0,1,1,1,1,x / _width,y / _height);
               strokePoints.push(x,y);
               numVertices++;
               if(i == 0)
               {
                  indices.push(4,3,numVertices - 1);
               }
               else
               {
                  indices.push(4,numVertices - 2,numVertices - 1);
               }
               if(i == numSides - 1)
               {
                  indices.push(4,numVertices - 1,5);
               }
               i++;
            }
         }
         strokePoints.push(_width,trr);
         strokePoints.push(_width,_height - brr);
         if(brr > 0)
         {
            numSides = brr * 0.25;
            numSides = numSides < 1?1:numSides;
            for(i = 0; i < numSides; )
            {
               radians = (i + 1) / (numSides + 1) * 3.14159265358979 * 0.5;
               radians = radians + 3.14159265358979 * 0.5;
               sin = Math.sin(radians);
               cos = Math.cos(radians);
               x = _width - brr + sin * brr;
               y = _height - brr - cos * brr;
               vertices.push(x,y,0,1,1,1,1,x / _width,y / _height);
               strokePoints.push(x,y);
               numVertices++;
               if(i == 0)
               {
                  indices.push(10,11,numVertices - 1);
               }
               else
               {
                  indices.push(10,numVertices - 2,numVertices - 1);
               }
               if(i == numSides - 1)
               {
                  indices.push(10,numVertices - 1,9);
               }
               i++;
            }
         }
         strokePoints.push(_width - brr,_height);
         strokePoints.push(blr,_height);
         if(blr > 0)
         {
            numSides = blr * 0.25;
            numSides = numSides < 1?1:numSides;
            for(i = 0; i < numSides; )
            {
               radians = (i + 1) / (numSides + 1) * 3.14159265358979 * 0.5;
               radians = radians + 3.14159265358979;
               sin = Math.sin(radians);
               cos = Math.cos(radians);
               x = blr + sin * blr;
               y = _height - blr - cos * blr;
               vertices.push(x,y,0,1,1,1,1,x / _width,y / _height);
               strokePoints.push(x,y);
               numVertices++;
               if(i == 0)
               {
                  indices.push(7,6,numVertices - 1);
               }
               else
               {
                  indices.push(7,numVertices - 2,numVertices - 1);
               }
               if(i == numSides - 1)
               {
                  indices.push(7,numVertices - 1,8);
               }
               i++;
            }
         }
         strokePoints.push(0,_height - blr);
         strokePoints.push(0,tlr);
      }
   }
}
