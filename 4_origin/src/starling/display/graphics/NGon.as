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
      
      public function NGon(radius:Number = 100, numSides:int = 10, innerRadius:Number = 0, startAngle:Number = 0, endAngle:Number = 360, textureAlongPath:Boolean = false)
      {
         super();
         this.radius = radius;
         this.numSides = numSides;
         this.innerRadius = innerRadius;
         this.startAngle = startAngle;
         this.endAngle = endAngle;
         this._textureAlongPath = textureAlongPath;
         var _loc7_:* = -radius;
         minBounds.y = _loc7_;
         minBounds.x = _loc7_;
         _loc7_ = radius;
         maxBounds.y = _loc7_;
         maxBounds.x = _loc7_;
         if(!_uv)
         {
            _uv = new Point();
         }
      }
      
      private static function buildSimpleNGon(radius:Number, numSides:int, vertices:Vector.<Number>, indices:Vector.<uint>, uvMatrix:Matrix, color:uint) : void
      {
         var i:int = 0;
         var x:Number = NaN;
         var y:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc15_:Number = NaN;
         var numVertices:int = 0;
         _uv.x = 0;
         _uv.y = 0;
         if(uvMatrix)
         {
            _uv = uvMatrix.transformPoint(_uv);
         }
         var r:Number = (color >> 16) / 255;
         var g:Number = ((color & 65280) >> 8) / 255;
         var b:Number = (color & 255) / 255;
         vertices.push(0,0,0,r,g,b,1,_uv.x,_uv.y);
         numVertices++;
         var anglePerSide:Number = 3.14159265358979 * 2 / numSides;
         var cosA:Number = Math.cos(anglePerSide);
         var sinB:Number = Math.sin(anglePerSide);
         var s:* = 0;
         var c:* = 1;
         for(i = 0; i < numSides; )
         {
            x = s * radius;
            y = -c * radius;
            _uv.x = x;
            _uv.y = y;
            if(uvMatrix)
            {
               _uv = uvMatrix.transformPoint(_uv);
            }
            vertices.push(x,y,0,r,g,b,1,_uv.x,_uv.y);
            numVertices++;
            indices.push(0,numVertices - 1,i == numSides - 1?1:numVertices);
            _loc8_ = sinB * c + cosA * s;
            _loc15_ = cosA * c - sinB * s;
            c = _loc15_;
            s = _loc8_;
            i++;
         }
      }
      
      private static function buildHoop(innerRadius:Number, radius:Number, numSides:int, vertices:Vector.<Number>, indices:Vector.<uint>, uvMatrix:Matrix, color:uint, textureAlongPath:Boolean) : void
      {
         var i:int = 0;
         var x:Number = NaN;
         var y:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc17_:Number = NaN;
         var numVertices:int = 0;
         var anglePerSide:Number = 3.14159265358979 * 2 / numSides;
         var cosA:Number = Math.cos(anglePerSide);
         var sinB:Number = Math.sin(anglePerSide);
         var s:* = 0;
         var c:* = 1;
         var r:Number = (color >> 16) / 255;
         var g:Number = ((color & 65280) >> 8) / 255;
         var b:Number = (color & 255) / 255;
         for(i = 0; i < numSides; )
         {
            x = s * radius;
            y = -c * radius;
            if(textureAlongPath)
            {
               _uv.x = i / numSides;
               _uv.y = 0;
            }
            else
            {
               _uv.x = x;
               _uv.y = y;
            }
            if(uvMatrix)
            {
               _uv = uvMatrix.transformPoint(_uv);
            }
            vertices.push(x,y,0,r,g,b,1,_uv.x,_uv.y);
            numVertices++;
            x = s * innerRadius;
            y = -c * innerRadius;
            if(textureAlongPath)
            {
               _uv.x = i / numSides;
               _uv.y = 1;
            }
            else
            {
               _uv.x = x;
               _uv.y = y;
            }
            if(uvMatrix)
            {
               _uv = uvMatrix.transformPoint(_uv);
            }
            vertices.push(x,y,0,r,g,b,1,_uv.x,_uv.y);
            numVertices++;
            if(i == numSides - 1)
            {
               indices.push(numVertices - 2,numVertices - 1,0,0,numVertices - 1,1);
            }
            else
            {
               indices.push(numVertices - 2,numVertices,numVertices - 1,numVertices,numVertices + 1,numVertices - 1);
            }
            _loc10_ = sinB * c + cosA * s;
            _loc17_ = cosA * c - sinB * s;
            c = _loc17_;
            s = _loc10_;
            i++;
         }
      }
      
      private static function buildFan(radius:Number, startAngle:Number, endAngle:Number, numSides:int, vertices:Vector.<Number>, indices:Vector.<uint>, uvMatrix:Matrix, color:uint) : void
      {
         var i:int = 0;
         var radians:Number = NaN;
         var nextRadians:Number = NaN;
         var x:Number = NaN;
         var y:Number = NaN;
         var prevRadians:Number = NaN;
         var t:Number = NaN;
         var nextX:Number = NaN;
         var nextY:Number = NaN;
         var prevX:Number = NaN;
         var prevY:Number = NaN;
         var numVertices:int = 0;
         var r:Number = (color >> 16) / 255;
         var g:Number = ((color & 65280) >> 8) / 255;
         var b:Number = (color & 255) / 255;
         vertices.push(0,0,0,r,g,b,1,0.5,0.5);
         numVertices++;
         var radiansPerDivision:Number = 3.14159265358979 * 2 / numSides;
         var startRadians:Number = startAngle / radiansPerDivision;
         startRadians = startRadians < 0?-Math.ceil(-startRadians):int(startRadians);
         startRadians = startRadians * radiansPerDivision;
         for(i = 0; i <= numSides + 1; )
         {
            radians = startRadians + i * radiansPerDivision;
            nextRadians = radians + radiansPerDivision;
            if(nextRadians >= startAngle)
            {
               x = Math.sin(radians) * radius;
               y = -Math.cos(radians) * radius;
               prevRadians = radians - radiansPerDivision;
               if(radians < startAngle && nextRadians > startAngle)
               {
                  nextX = Math.sin(nextRadians) * radius;
                  nextY = -Math.cos(nextRadians) * radius;
                  t = (startAngle - radians) / radiansPerDivision;
                  x = x + t * (nextX - x);
                  y = y + t * (nextY - y);
               }
               else if(radians > endAngle && prevRadians < endAngle)
               {
                  prevX = Math.sin(prevRadians) * radius;
                  prevY = -Math.cos(prevRadians) * radius;
                  t = (endAngle - prevRadians) / radiansPerDivision;
                  x = prevX + t * (x - prevX);
                  y = prevY + t * (y - prevY);
               }
               _uv.x = x;
               _uv.y = y;
               if(uvMatrix)
               {
                  _uv = uvMatrix.transformPoint(_uv);
               }
               vertices.push(x,y,0,r,g,b,1,_uv.x,_uv.y);
               numVertices++;
               if(vertices.length > 18)
               {
                  indices.push(0,numVertices - 2,numVertices - 1);
               }
               if(radians >= endAngle)
               {
                  break;
               }
            }
            i++;
         }
      }
      
      private static function buildArc(innerRadius:Number, radius:Number, startAngle:Number, endAngle:Number, numSides:int, vertices:Vector.<Number>, indices:Vector.<uint>, uvMatrix:Matrix, color:uint, textureAlongPath:Boolean) : void
      {
         var i:int = 0;
         var angle:Number = NaN;
         var nextAngle:Number = NaN;
         var sin:Number = NaN;
         var cos:Number = NaN;
         var x:Number = NaN;
         var y:Number = NaN;
         var x2:Number = NaN;
         var y2:Number = NaN;
         var prevAngle:Number = NaN;
         var t:Number = NaN;
         var nextX:Number = NaN;
         var nextY:Number = NaN;
         var nextX2:Number = NaN;
         var nextY2:Number = NaN;
         var prevX:Number = NaN;
         var prevY:Number = NaN;
         var prevX2:Number = NaN;
         var prevY2:Number = NaN;
         var nv:int = 0;
         var radiansPerDivision:Number = 3.14159265358979 * 2 / numSides;
         var startRadians:Number = startAngle / radiansPerDivision;
         startRadians = startRadians < 0?-Math.ceil(-startRadians):int(startRadians);
         startRadians = startRadians * radiansPerDivision;
         var r:Number = (color >> 16) / 255;
         var g:Number = ((color & 65280) >> 8) / 255;
         var b:Number = (color & 255) / 255;
         for(i = 0; i <= numSides + 1; )
         {
            angle = startRadians + i * radiansPerDivision;
            nextAngle = angle + radiansPerDivision;
            if(nextAngle >= startAngle)
            {
               sin = Math.sin(angle);
               cos = Math.cos(angle);
               x = sin * radius;
               y = -cos * radius;
               x2 = sin * innerRadius;
               y2 = -cos * innerRadius;
               prevAngle = angle - radiansPerDivision;
               if(angle < startAngle && nextAngle > startAngle)
               {
                  sin = Math.sin(nextAngle);
                  cos = Math.cos(nextAngle);
                  nextX = sin * radius;
                  nextY = -cos * radius;
                  nextX2 = sin * innerRadius;
                  nextY2 = -cos * innerRadius;
                  t = (startAngle - angle) / radiansPerDivision;
                  x = x + t * (nextX - x);
                  y = y + t * (nextY - y);
                  x2 = x2 + t * (nextX2 - x2);
                  y2 = y2 + t * (nextY2 - y2);
               }
               else if(angle > endAngle && prevAngle < endAngle)
               {
                  sin = Math.sin(prevAngle);
                  cos = Math.cos(prevAngle);
                  prevX = sin * radius;
                  prevY = -cos * radius;
                  prevX2 = sin * innerRadius;
                  prevY2 = -cos * innerRadius;
                  t = (endAngle - prevAngle) / radiansPerDivision;
                  x = prevX + t * (x - prevX);
                  y = prevY + t * (y - prevY);
                  x2 = prevX2 + t * (x2 - prevX2);
                  y2 = prevY2 + t * (y2 - prevY2);
               }
               if(textureAlongPath)
               {
                  _uv.x = i / numSides;
                  _uv.y = 0;
               }
               else
               {
                  _uv.x = x;
                  _uv.y = y;
               }
               if(uvMatrix)
               {
                  _uv = uvMatrix.transformPoint(_uv);
               }
               vertices.push(x,y,0,r,g,b,1,_uv.x,_uv.y);
               nv++;
               if(textureAlongPath)
               {
                  _uv.x = i / numSides;
                  _uv.y = 1;
               }
               else
               {
                  _uv.x = x2;
                  _uv.y = y2;
               }
               if(uvMatrix)
               {
                  _uv = uvMatrix.transformPoint(_uv);
               }
               vertices.push(x2,y2,0,r,g,b,1,_uv.x,_uv.y);
               nv++;
               if(vertices.length > 27)
               {
                  indices.push(nv - 3,nv - 2,nv - 1,nv - 3,nv - 4,nv - 2);
               }
               if(angle >= endAngle)
               {
                  break;
               }
            }
            i++;
         }
      }
      
      public function get endAngle() : Number
      {
         return _endAngle;
      }
      
      public function set endAngle(value:Number) : void
      {
         _endAngle = value;
         setGeometryInvalid();
      }
      
      public function get startAngle() : Number
      {
         return _startAngle;
      }
      
      public function set startAngle(value:Number) : void
      {
         _startAngle = value;
         setGeometryInvalid();
      }
      
      public function get radius() : Number
      {
         return _radius;
      }
      
      public function set color(value:uint) : void
      {
         _color = value;
         setGeometryInvalid();
      }
      
      public function set radius(value:Number) : void
      {
         value = value < 0?0:Number(value);
         _radius = value;
         var maxRadius:Number = Math.max(_radius,_innerRadius);
         var _loc3_:* = -maxRadius;
         minBounds.y = _loc3_;
         minBounds.x = _loc3_;
         _loc3_ = maxRadius;
         maxBounds.y = _loc3_;
         maxBounds.x = _loc3_;
         setGeometryInvalid();
      }
      
      public function get innerRadius() : Number
      {
         return _innerRadius;
      }
      
      public function set innerRadius(value:Number) : void
      {
         value = value < 0?0:Number(value);
         _innerRadius = value;
         var maxRadius:Number = Math.max(_radius,_innerRadius);
         var _loc3_:* = -maxRadius;
         minBounds.y = _loc3_;
         minBounds.x = _loc3_;
         _loc3_ = maxRadius;
         maxBounds.y = _loc3_;
         maxBounds.x = _loc3_;
         setGeometryInvalid();
      }
      
      public function get numSides() : int
      {
         return _numSides;
      }
      
      public function set numSides(value:int) : void
      {
         value = value < 3?3:value;
         _numSides = value;
         setGeometryInvalid();
      }
      
      override protected function buildGeometry() : void
      {
         vertices = new Vector.<Number>();
         indices = new Vector.<uint>();
         var sa:Number = _startAngle;
         var ea:Number = _endAngle;
         var isEqual:* = sa == ea;
         var sSign:int = sa < 0?-1:1;
         var eSign:int = ea < 0?-1:1;
         sa = sa * sSign;
         ea = ea * eSign;
         ea = ea % 360;
         ea = ea * eSign;
         sa = sa % 360;
         if(ea < sa)
         {
            ea = ea + 360;
         }
         sa = sa * (sSign * 0.0174532925199433);
         ea = ea * 0.0174532925199433;
         if(ea - sa > 3.14159265358979 * 2)
         {
            ea = ea - 3.14159265358979 * 2;
         }
         var innerRadius:Number = _innerRadius < _radius?_innerRadius:Number(_radius);
         var radius:Number = _radius > _innerRadius?_radius:Number(_innerRadius);
         var isSegment:* = Boolean(sa != 0 || ea != 0);
         if(isSegment == false)
         {
            isSegment = isEqual;
         }
         if(innerRadius == 0 && !isSegment)
         {
            buildSimpleNGon(radius,_numSides,vertices,indices,_uvMatrix,_color);
         }
         else if(innerRadius != 0 && !isSegment)
         {
            buildHoop(innerRadius,radius,_numSides,vertices,indices,_uvMatrix,_color,_textureAlongPath);
         }
         else if(innerRadius == 0)
         {
            buildFan(radius,sa,ea,_numSides,vertices,indices,_uvMatrix,_color);
         }
         else
         {
            buildArc(innerRadius,radius,sa,ea,_numSides,vertices,indices,_uvMatrix,_color,_textureAlongPath);
         }
      }
      
      override protected function shapeHitTestLocalInternal(localX:Number, localY:Number) : Boolean
      {
         var i:int = 0;
         var i0:int = 0;
         var i1:int = 0;
         var i2:int = 0;
         var v0x:Number = NaN;
         var v0y:Number = NaN;
         var v1x:Number = NaN;
         var v1y:Number = NaN;
         var v2x:Number = NaN;
         var v2y:Number = NaN;
         var numIndices:int = indices.length;
         if(numIndices < 2)
         {
            validateNow();
            numIndices = indices.length;
            if(numIndices < 2)
            {
               return false;
            }
         }
         if(_innerRadius == 0 && _radius > 0 && _startAngle == 0 && _endAngle == 360 && _numSides > 20)
         {
            if(Math.sqrt(localX * localX + localY * localY) < _radius)
            {
               return true;
            }
            return false;
         }
         i = 2;
         while(i < numIndices)
         {
            i0 = indices[i - 2];
            i1 = indices[i - 1];
            i2 = indices[i - 0];
            v0x = vertices[9 * i0 + 0];
            v0y = vertices[9 * i0 + 1];
            v1x = vertices[9 * i1 + 0];
            v1y = vertices[9 * i1 + 1];
            v2x = vertices[9 * i2 + 0];
            v2y = vertices[9 * i2 + 1];
            if(TriangleUtil.isPointInTriangle(v0x,v0y,v1x,v1y,v2x,v2y,localX,localY))
            {
               return true;
            }
            i = i + 3;
         }
         return false;
      }
   }
}
