package starling.geom
{
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   import starling.utils.VectorUtil;
   import starling.utils.VertexData;
   
   public class Polygon
   {
      
      private static var sRestIndices:Vector.<uint> = new Vector.<uint>(0);
       
      
      private var mCoords:Vector.<Number>;
      
      public function Polygon(vertices:Array = null)
      {
         super();
         mCoords = new Vector.<Number>(0);
         addVertices.apply(this,vertices);
      }
      
      public static function createEllipse(x:Number, y:Number, radiusX:Number, radiusY:Number) : Polygon
      {
         return new Ellipse(x,y,radiusX,radiusY);
      }
      
      public static function createCircle(x:Number, y:Number, radius:Number) : Polygon
      {
         return new Ellipse(x,y,radius,radius);
      }
      
      public static function createRectangle(x:Number, y:Number, width:Number, height:Number) : Polygon
      {
         return new Rectangle(x,y,width,height);
      }
      
      [Inline]
      private static function isConvexTriangle(ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number) : Boolean
      {
         return (ay - by) * (cx - bx) + (bx - ax) * (cy - by) >= 0;
      }
      
      private static function isPointInTriangle(px:Number, py:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number) : Boolean
      {
         var v0x:Number = cx - ax;
         var v0y:Number = cy - ay;
         var v1x:Number = bx - ax;
         var v1y:Number = by - ay;
         var v2x:Number = px - ax;
         var v2y:Number = py - ay;
         var dot00:Number = v0x * v0x + v0y * v0y;
         var dot01:Number = v0x * v1x + v0y * v1y;
         var dot02:Number = v0x * v2x + v0y * v2y;
         var dot11:Number = v1x * v1x + v1y * v1y;
         var dot12:Number = v1x * v2x + v1y * v2y;
         var invDen:Number = 1 / (dot00 * dot11 - dot01 * dot01);
         var u:Number = (dot11 * dot02 - dot01 * dot12) * invDen;
         var v:Number = (dot00 * dot12 - dot01 * dot02) * invDen;
         return u >= 0 && v >= 0 && u + v < 1;
      }
      
      private static function areVectorsIntersecting(ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number, dx:Number, dy:Number) : Boolean
      {
         if(ax == bx && ay == by || cx == dx && cy == dy)
         {
            return false;
         }
         var abx:Number = bx - ax;
         var aby:Number = by - ay;
         var cdx:Number = dx - cx;
         var cdy:Number = dy - cy;
         var tDen:Number = cdy * abx - cdx * aby;
         if(tDen == 0)
         {
            return false;
         }
         var t:Number = (aby * (cx - ax) - abx * (cy - ay)) / tDen;
         if(t < 0 || t > 1)
         {
            return false;
         }
         var s:Number = !!aby?(cy - ay + t * cdy) / aby:Number((cx - ax + t * cdx) / abx);
         return s >= 0 && s <= 1;
      }
      
      public function clone() : Polygon
      {
         var i:int = 0;
         var clone:Polygon = new Polygon();
         var numCoords:int = mCoords.length;
         for(i = 0; i < numCoords; )
         {
            clone.mCoords[i] = mCoords[i];
            i++;
         }
         return clone;
      }
      
      public function reverse() : void
      {
         var tmp:Number = NaN;
         var i:int = 0;
         var numCoords:int = mCoords.length;
         var numVertices:int = numCoords / 2;
         for(i = 0; i < numVertices; )
         {
            tmp = mCoords[i];
            mCoords[i] = mCoords[numCoords - i - 2];
            mCoords[numCoords - i - 2] = tmp;
            tmp = mCoords[i + 1];
            mCoords[i + 1] = mCoords[numCoords - i - 1];
            mCoords[numCoords - i - 1] = tmp;
            i = i + 2;
         }
      }
      
      public function addVertices(... args) : void
      {
         var i:int = 0;
         var numArgs:int = args.length;
         var numCoords:int = mCoords.length;
         if(numArgs > 0)
         {
            if(args[0] is Point)
            {
               for(i = 0; i < numArgs; )
               {
                  mCoords[numCoords + i * 2] = (args[i] as Point).x;
                  mCoords[numCoords + i * 2 + 1] = (args[i] as Point).y;
                  i++;
               }
            }
            else if(args[0] is Number)
            {
               for(i = 0; i < numArgs; )
               {
                  mCoords[numCoords + i] = args[i];
                  i++;
               }
            }
            else
            {
               throw new ArgumentError("Invalid type: " + getQualifiedClassName(args[0]));
            }
         }
      }
      
      public function setVertex(index:int, x:Number, y:Number) : void
      {
         if(index >= 0 && index <= numVertices)
         {
            mCoords[index * 2] = x;
            mCoords[index * 2 + 1] = y;
            return;
         }
         throw new RangeError("Invalid index: " + index);
      }
      
      public function getVertex(index:int, result:Point = null) : Point
      {
         if(index >= 0 && index < numVertices)
         {
            if(!result)
            {
               result = new Point();
            }
            result.setTo(mCoords[index * 2],mCoords[index * 2 + 1]);
            return result;
         }
         throw new RangeError("Invalid index: " + index);
      }
      
      public function contains(x:Number, y:Number) : Boolean
      {
         var i:int = 0;
         var ix:Number = NaN;
         var iy:Number = NaN;
         var jx:Number = NaN;
         var jy:Number = NaN;
         var j:* = int(numVertices - 1);
         var oddNodes:uint = 0;
         for(i = 0; i < numVertices; )
         {
            ix = mCoords[i * 2];
            iy = mCoords[i * 2 + 1];
            jx = mCoords[j * 2];
            jy = mCoords[j * 2 + 1];
            if((iy < y && jy >= y || jy < y && iy >= y) && (ix <= x || jx <= x))
            {
               oddNodes = oddNodes ^ uint(ix + (y - iy) / (jy - iy) * (jx - ix) < x);
            }
            j = i;
            i++;
         }
         return oddNodes != 0;
      }
      
      public function containsPoint(point:Point) : Boolean
      {
         return contains(point.x,point.y);
      }
      
      public function triangulate(result:Vector.<uint> = null) : Vector.<uint>
      {
         var restIndexPos:int = 0;
         var numRestIndices:* = 0;
         var resultPos:int = 0;
         var i:int = 0;
         var i0:* = 0;
         var i1:* = 0;
         var i2:* = 0;
         var ax:Number = NaN;
         var ay:Number = NaN;
         var bx:Number = NaN;
         var by:Number = NaN;
         var cx:Number = NaN;
         var cy:Number = NaN;
         var earFound:Boolean = false;
         var otherIndex:* = 0;
         if(result == null)
         {
            result = new Vector.<uint>(0);
         }
         var numVertices:int = this.numVertices;
         if(numVertices < 3)
         {
            return result;
         }
         sRestIndices.length = numVertices;
         for(i = 0; i < numVertices; sRestIndices[i] = i,i++)
         {
         }
         restIndexPos = 0;
         resultPos = result.length;
         numRestIndices = numVertices;
         while(numRestIndices > 3)
         {
            i0 = uint(sRestIndices[restIndexPos % numRestIndices]);
            i1 = uint(sRestIndices[(restIndexPos + 1) % numRestIndices]);
            i2 = uint(sRestIndices[(restIndexPos + 2) % numRestIndices]);
            ax = mCoords[2 * i0];
            ay = mCoords[2 * i0 + 1];
            bx = mCoords[2 * i1];
            by = mCoords[2 * i1 + 1];
            cx = mCoords[2 * i2];
            cy = mCoords[2 * i2 + 1];
            earFound = false;
            if(isConvexTriangle(ax,ay,bx,by,cx,cy))
            {
               earFound = true;
               for(i = 3; i < numRestIndices; )
               {
                  otherIndex = uint(sRestIndices[(restIndexPos + i) % numRestIndices]);
                  if(isPointInTriangle(mCoords[2 * otherIndex],mCoords[2 * otherIndex + 1],ax,ay,bx,by,cx,cy))
                  {
                     earFound = false;
                     break;
                  }
                  i++;
               }
            }
            if(earFound)
            {
               resultPos++;
               result[resultPos] = i0;
               resultPos++;
               result[resultPos] = i1;
               resultPos++;
               result[resultPos] = i2;
               VectorUtil.removeUnsignedIntAt(sRestIndices,(restIndexPos + 1) % numRestIndices);
               numRestIndices--;
               restIndexPos = 0;
               continue;
            }
            restIndexPos++;
            if(restIndexPos != numRestIndices)
            {
               continue;
            }
            break;
         }
         resultPos++;
         result[resultPos] = sRestIndices[0];
         resultPos++;
         result[resultPos] = sRestIndices[1];
         result[resultPos] = sRestIndices[2];
         return result;
      }
      
      public function copyToVertexData(target:VertexData, targetIndex:int = 0) : void
      {
         var requiredTargetLength:int = targetIndex + numVertices;
         if(target.numVertices < requiredTargetLength)
         {
            target.numVertices = requiredTargetLength;
         }
         copyToVector(target.rawData,targetIndex * 8,8 - 2);
      }
      
      public function copyToVector(target:Vector.<Number>, targetIndex:int = 0, stride:int = 0) : void
      {
         var i:int = 0;
         var numVertices:int = this.numVertices;
         for(i = 0; i < numVertices; )
         {
            targetIndex++;
            target[targetIndex] = mCoords[i * 2];
            targetIndex++;
            target[targetIndex] = mCoords[i * 2 + 1];
            targetIndex = targetIndex + stride;
            i++;
         }
      }
      
      public function toString() : String
      {
         var i:int = 0;
         var result:String = "[Polygon \n";
         var numPoints:int = this.numVertices;
         for(i = 0; i < numPoints; )
         {
            result = result + ("  [Vertex " + i + ": " + "x=" + mCoords[i * 2].toFixed(1) + ", " + "y=" + mCoords[i * 2 + 1].toFixed(1) + "]" + (i == numPoints - 1?"\n":",\n"));
            i++;
         }
         return result + "]";
      }
      
      public function get isSimple() : Boolean
      {
         var i:int = 0;
         var ax:Number = NaN;
         var ay:Number = NaN;
         var bx:Number = NaN;
         var by:Number = NaN;
         var endJ:Number = NaN;
         var j:int = 0;
         var cx:Number = NaN;
         var cy:Number = NaN;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var numCoords:int = mCoords.length;
         if(numCoords <= 6)
         {
            return true;
         }
         i = 0;
         while(i < numCoords)
         {
            ax = mCoords[i];
            ay = mCoords[i + 1];
            bx = mCoords[(i + 2) % numCoords];
            by = mCoords[(i + 3) % numCoords];
            endJ = i + numCoords - 2;
            for(j = i + 4; j < endJ; )
            {
               cx = mCoords[j % numCoords];
               cy = mCoords[(j + 1) % numCoords];
               dx = mCoords[(j + 2) % numCoords];
               dy = mCoords[(j + 3) % numCoords];
               if(areVectorsIntersecting(ax,ay,bx,by,cx,cy,dx,dy))
               {
                  return false;
               }
               j = j + 2;
            }
            i = i + 2;
         }
         return true;
      }
      
      public function get isConvex() : Boolean
      {
         var i:int = 0;
         var numCoords:int = mCoords.length;
         if(numCoords < 6)
         {
            return true;
         }
         i = 0;
         while(i < numCoords)
         {
            if(!isConvexTriangle(mCoords[i],mCoords[i + 1],mCoords[(i + 2) % numCoords],mCoords[(i + 3) % numCoords],mCoords[(i + 4) % numCoords],mCoords[(i + 5) % numCoords]))
            {
               return false;
            }
            i = i + 2;
         }
         return true;
      }
      
      public function get area() : Number
      {
         var i:int = 0;
         var area:* = 0;
         var numCoords:int = mCoords.length;
         if(numCoords >= 6)
         {
            for(i = 0; i < numCoords; )
            {
               area = Number(area + mCoords[i] * mCoords[(i + 3) % numCoords]);
               area = Number(area - mCoords[i + 1] * mCoords[(i + 2) % numCoords]);
               i = i + 2;
            }
         }
         return area / 2;
      }
      
      public function get numVertices() : int
      {
         return mCoords.length / 2;
      }
      
      public function set numVertices(value:int) : void
      {
         var i:* = 0;
         var oldLength:int = numVertices;
         mCoords.length = value * 2;
         if(oldLength < value)
         {
            for(i = oldLength; i < value; )
            {
               var _loc4_:int = 0;
               mCoords[i * 2 + 1] = _loc4_;
               mCoords[i * 2] = _loc4_;
               i++;
            }
         }
      }
   }
}

import flash.errors.IllegalOperationError;
import flash.utils.getQualifiedClassName;
import starling.geom.Polygon;

class ImmutablePolygon extends Polygon
{
    
   
   private var mFrozen:Boolean;
   
   function ImmutablePolygon(vertices:Array)
   {
      super(vertices);
      mFrozen = true;
   }
   
   override public function addVertices(... args) : void
   {
      if(mFrozen)
      {
         throw getImmutableError();
      }
      super.addVertices.apply(this,args);
   }
   
   override public function setVertex(index:int, x:Number, y:Number) : void
   {
      if(mFrozen)
      {
         throw getImmutableError();
      }
      super.setVertex(index,x,y);
   }
   
   override public function reverse() : void
   {
      if(mFrozen)
      {
         throw getImmutableError();
      }
      super.reverse();
   }
   
   override public function set numVertices(value:int) : void
   {
      if(mFrozen)
      {
         throw getImmutableError();
      }
      super.reverse();
   }
   
   private function getImmutableError() : Error
   {
      var className:String = getQualifiedClassName(this).split("::").pop();
      var msg:String = className + " cannot be modified. Call \'clone\' to create a mutable copy.";
      return new IllegalOperationError(msg);
   }
}

class Ellipse extends ImmutablePolygon
{
    
   
   private var mX:Number;
   
   private var mY:Number;
   
   private var mRadiusX:Number;
   
   private var mRadiusY:Number;
   
   function Ellipse(x:Number, y:Number, radiusX:Number, radiusY:Number, numSides:int = -1)
   {
      mX = x;
      mY = y;
      mRadiusX = radiusX;
      mRadiusY = radiusY;
      super(getVertices(numSides));
   }
   
   private function getVertices(numSides:int) : Array
   {
      var i:int = 0;
      if(numSides < 0)
      {
         numSides = 3.14159265358979 * (mRadiusX + mRadiusY) / 4;
      }
      if(numSides < 6)
      {
         numSides = 6;
      }
      var vertices:Array = [];
      var angleDelta:Number = 2 * 3.14159265358979 / numSides;
      var angle:* = 0;
      for(i = 0; i < numSides; )
      {
         vertices[i * 2] = Math.cos(angle) * mRadiusX + mX;
         vertices[i * 2 + 1] = Math.sin(angle) * mRadiusY + mY;
         angle = Number(angle + angleDelta);
         i++;
      }
      return vertices;
   }
   
   override public function triangulate(result:Vector.<uint> = null) : Vector.<uint>
   {
      var i:int = 0;
      if(result == null)
      {
         result = new Vector.<uint>(0);
      }
      var from:uint = 1;
      var to:uint = numVertices - 1;
      var pos:uint = result.length;
      for(i = from; i < to; )
      {
         result[pos++] = 0;
         result[pos++] = i;
         result[pos++] = i + 1;
         i++;
      }
      return result;
   }
   
   override public function contains(x:Number, y:Number) : Boolean
   {
      var vx:Number = x - mX;
      var vy:Number = y - mY;
      var a:Number = vx / mRadiusX;
      var b:Number = vy / mRadiusY;
      return a * a + b * b <= 1;
   }
   
   override public function get area() : Number
   {
      return 3.14159265358979 * mRadiusX * mRadiusY;
   }
   
   override public function get isSimple() : Boolean
   {
      return true;
   }
   
   override public function get isConvex() : Boolean
   {
      return true;
   }
}

class Rectangle extends ImmutablePolygon
{
    
   
   private var mX:Number;
   
   private var mY:Number;
   
   private var mWidth:Number;
   
   private var mHeight:Number;
   
   function Rectangle(x:Number, y:Number, width:Number, height:Number)
   {
      mX = x;
      mY = y;
      mWidth = width;
      mHeight = height;
      super([x,y,x + width,y,x + width,y + height,x,y + height]);
   }
   
   override public function triangulate(result:Vector.<uint> = null) : Vector.<uint>
   {
      if(result == null)
      {
         result = new Vector.<uint>(0);
      }
      result.push(0,1,3,1,2,3);
      return result;
   }
   
   override public function contains(x:Number, y:Number) : Boolean
   {
      return x >= mX && x <= mX + mWidth && y >= mY && y <= mY + mHeight;
   }
   
   override public function get area() : Number
   {
      return mWidth * mHeight;
   }
   
   override public function get isSimple() : Boolean
   {
      return true;
   }
   
   override public function get isConvex() : Boolean
   {
      return true;
   }
}
