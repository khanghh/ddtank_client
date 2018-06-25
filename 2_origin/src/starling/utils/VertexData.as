package starling.utils
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   
   public class VertexData
   {
      
      public static const ELEMENTS_PER_VERTEX:int = 8;
      
      public static const POSITION_OFFSET:int = 0;
      
      public static const COLOR_OFFSET:int = 2;
      
      public static const TEXCOORD_OFFSET:int = 6;
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
       
      
      private var mRawData:Vector.<Number>;
      
      private var mPremultipliedAlpha:Boolean;
      
      private var mNumVertices:int;
      
      public function VertexData(numVertices:int, premultipliedAlpha:Boolean = false)
      {
         super();
         mRawData = new Vector.<Number>(0);
         mPremultipliedAlpha = premultipliedAlpha;
         this.numVertices = numVertices;
      }
      
      public function clone(vertexID:int = 0, numVertices:int = -1) : VertexData
      {
         if(numVertices < 0 || vertexID + numVertices > mNumVertices)
         {
            numVertices = mNumVertices - vertexID;
         }
         var clone:VertexData = new VertexData(0,mPremultipliedAlpha);
         clone.mNumVertices = numVertices;
         clone.mRawData = mRawData.slice(vertexID * 8,numVertices * 8);
         clone.mRawData.fixed = true;
         return clone;
      }
      
      public function copyTo(targetData:VertexData, targetVertexID:int = 0, vertexID:int = 0, numVertices:int = -1) : void
      {
         copyTransformedTo(targetData,targetVertexID,null,vertexID,numVertices);
      }
      
      public function copyTransformedTo(targetData:VertexData, targetVertexID:int = 0, matrix:Matrix = null, vertexID:int = 0, numVertices:int = -1) : void
      {
         var y:Number = NaN;
         var x:Number = NaN;
         if(numVertices < 0 || vertexID + numVertices > mNumVertices)
         {
            numVertices = mNumVertices - vertexID;
         }
         var targetRawData:Vector.<Number> = targetData.mRawData;
         var targetIndex:int = targetVertexID * 8;
         var sourceIndex:int = vertexID * 8;
         var sourceEnd:int = (vertexID + numVertices) * 8;
         if(matrix)
         {
            while(sourceIndex < sourceEnd)
            {
               sourceIndex++;
               x = mRawData[int(sourceIndex)];
               sourceIndex++;
               y = mRawData[int(sourceIndex)];
               targetIndex++;
               targetRawData[int(targetIndex)] = matrix.a * x + matrix.c * y + matrix.tx;
               targetIndex++;
               targetRawData[int(targetIndex)] = matrix.d * y + matrix.b * x + matrix.ty;
               targetIndex++;
               sourceIndex++;
               targetRawData[int(targetIndex)] = mRawData[int(sourceIndex)];
               targetIndex++;
               sourceIndex++;
               targetRawData[int(targetIndex)] = mRawData[int(sourceIndex)];
               targetIndex++;
               sourceIndex++;
               targetRawData[int(targetIndex)] = mRawData[int(sourceIndex)];
               targetIndex++;
               sourceIndex++;
               targetRawData[int(targetIndex)] = mRawData[int(sourceIndex)];
               targetIndex++;
               sourceIndex++;
               targetRawData[int(targetIndex)] = mRawData[int(sourceIndex)];
               targetIndex++;
               sourceIndex++;
               targetRawData[int(targetIndex)] = mRawData[int(sourceIndex)];
            }
         }
         else
         {
            while(sourceIndex < sourceEnd)
            {
               targetIndex++;
               sourceIndex++;
               targetRawData[int(targetIndex)] = mRawData[int(sourceIndex)];
            }
         }
      }
      
      public function append(data:VertexData) : void
      {
         var i:int = 0;
         mRawData.fixed = false;
         var targetIndex:int = mRawData.length;
         var rawData:Vector.<Number> = data.mRawData;
         var rawDataLength:int = rawData.length;
         for(i = 0; i < rawDataLength; )
         {
            targetIndex++;
            mRawData[int(targetIndex)] = rawData[i];
            i++;
         }
         mNumVertices = mNumVertices + data.numVertices;
         mRawData.fixed = true;
      }
      
      public function setPosition(vertexID:int, x:Number, y:Number) : void
      {
         var offset:int = vertexID * 8 + 0;
         mRawData[offset] = x;
         mRawData[int(offset + 1)] = y;
      }
      
      public function getPosition(vertexID:int, position:Point) : void
      {
         var offset:int = vertexID * 8 + 0;
         position.x = mRawData[offset];
         position.y = mRawData[int(offset + 1)];
      }
      
      public function setColorAndAlpha(vertexID:int, color:uint, alpha:Number) : void
      {
         if(alpha < 0.001)
         {
            alpha = 0.001;
         }
         else if(alpha > 1)
         {
            alpha = 1;
         }
         var offset:int = vertexID * 8 + 2;
         var multiplier:Number = !!mPremultipliedAlpha?alpha:1;
         mRawData[offset] = (color >> 16 & 255) / 255 * multiplier;
         mRawData[int(offset + 1)] = (color >> 8 & 255) / 255 * multiplier;
         mRawData[int(offset + 2)] = (color & 255) / 255 * multiplier;
         mRawData[int(offset + 3)] = alpha;
      }
      
      public function setColor(vertexID:int, color:uint) : void
      {
         var offset:int = vertexID * 8 + 2;
         var multiplier:Number = !!mPremultipliedAlpha?mRawData[int(offset + 3)]:1;
         mRawData[offset] = (color >> 16 & 255) / 255 * multiplier;
         mRawData[int(offset + 1)] = (color >> 8 & 255) / 255 * multiplier;
         mRawData[int(offset + 2)] = (color & 255) / 255 * multiplier;
      }
      
      public function getColor(vertexID:int) : uint
      {
         var red:Number = NaN;
         var green:Number = NaN;
         var blue:Number = NaN;
         var offset:int = vertexID * 8 + 2;
         var divisor:Number = !!mPremultipliedAlpha?mRawData[int(offset + 3)]:1;
         if(divisor == 0)
         {
            return 0;
         }
         red = mRawData[offset] / divisor;
         green = mRawData[int(offset + 1)] / divisor;
         blue = mRawData[int(offset + 2)] / divisor;
         return int(red * 255) << 16 | int(green * 255) << 8 | int(blue * 255);
      }
      
      public function setAlpha(vertexID:int, alpha:Number) : void
      {
         if(mPremultipliedAlpha)
         {
            setColorAndAlpha(vertexID,getColor(vertexID),alpha);
         }
         else
         {
            mRawData[int(vertexID * 8 + 2 + 3)] = alpha;
         }
      }
      
      public function getAlpha(vertexID:int) : Number
      {
         var offset:int = vertexID * 8 + 2 + 3;
         return mRawData[offset];
      }
      
      public function setTexCoords(vertexID:int, u:Number, v:Number) : void
      {
         var offset:int = vertexID * 8 + 6;
         mRawData[offset] = u;
         mRawData[int(offset + 1)] = v;
      }
      
      public function getTexCoords(vertexID:int, texCoords:Point) : void
      {
         var offset:int = vertexID * 8 + 6;
         texCoords.x = mRawData[offset];
         texCoords.y = mRawData[int(offset + 1)];
      }
      
      public function translateVertex(vertexID:int, deltaX:Number, deltaY:Number) : void
      {
         var offset:int = vertexID * 8 + 0;
         var _loc5_:* = offset;
         var _loc6_:* = mRawData[_loc5_] + deltaX;
         mRawData[_loc5_] = _loc6_;
         _loc6_ = int(offset + 1);
         _loc5_ = mRawData[_loc6_] + deltaY;
         mRawData[_loc6_] = _loc5_;
      }
      
      public function transformVertex(vertexID:int, matrix:Matrix, numVertices:int = 1) : void
      {
         var y:Number = NaN;
         var x:Number = NaN;
         var i:int = 0;
         var offset:int = vertexID * 8 + 0;
         for(i = 0; i < numVertices; )
         {
            x = mRawData[offset];
            y = mRawData[int(offset + 1)];
            mRawData[offset] = matrix.a * x + matrix.c * y + matrix.tx;
            mRawData[int(offset + 1)] = matrix.d * y + matrix.b * x + matrix.ty;
            offset = offset + 8;
            i++;
         }
      }
      
      public function setUniformColor(color:uint) : void
      {
         var i:int = 0;
         for(i = 0; i < mNumVertices; )
         {
            setColor(i,color);
            i++;
         }
      }
      
      public function setUniformAlpha(alpha:Number) : void
      {
         var i:int = 0;
         for(i = 0; i < mNumVertices; )
         {
            setAlpha(i,alpha);
            i++;
         }
      }
      
      public function scaleAlpha(vertexID:int, factor:Number, numVertices:int = 1) : void
      {
         var i:int = 0;
         var offset:int = 0;
         if(factor == 1)
         {
            return;
         }
         if(numVertices < 0 || vertexID + numVertices > mNumVertices)
         {
            numVertices = mNumVertices - vertexID;
         }
         if(mPremultipliedAlpha)
         {
            for(i = 0; i < numVertices; )
            {
               setAlpha(vertexID + i,getAlpha(vertexID + i) * factor);
               i++;
            }
         }
         else
         {
            offset = vertexID * 8 + 2 + 3;
            for(i = 0; i < numVertices; )
            {
               var _loc6_:int = offset + i * 8;
               var _loc7_:* = mRawData[_loc6_] * factor;
               mRawData[_loc6_] = _loc7_;
               i++;
            }
         }
      }
      
      public function getBounds(transformationMatrix:Matrix = null, vertexID:int = 0, numVertices:int = -1, resultRect:Rectangle = null) : Rectangle
      {
         var minX:* = NaN;
         var minY:* = NaN;
         var offset:int = 0;
         var y:Number = NaN;
         var i:int = 0;
         var x:Number = NaN;
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         if(numVertices < 0 || vertexID + numVertices > mNumVertices)
         {
            numVertices = mNumVertices - vertexID;
         }
         if(numVertices == 0)
         {
            if(transformationMatrix == null)
            {
               resultRect.setEmpty();
            }
            else
            {
               MatrixUtil.transformCoords(transformationMatrix,0,0,sHelperPoint);
               resultRect.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
            }
         }
         else
         {
            minX = 1.79769313486232e308;
            var maxX:* = -1.79769313486232e308;
            minY = 1.79769313486232e308;
            var maxY:* = -1.79769313486232e308;
            offset = vertexID * 8 + 0;
            if(transformationMatrix == null)
            {
               for(i = 0; i < numVertices; )
               {
                  x = mRawData[offset];
                  y = mRawData[int(offset + 1)];
                  offset = offset + 8;
                  if(minX > x)
                  {
                     minX = x;
                  }
                  if(maxX < x)
                  {
                     maxX = x;
                  }
                  if(minY > y)
                  {
                     minY = y;
                  }
                  if(maxY < y)
                  {
                     maxY = y;
                  }
                  i++;
               }
            }
            else
            {
               i = 0;
               while(i < numVertices)
               {
                  x = mRawData[offset];
                  y = mRawData[int(offset + 1)];
                  offset = offset + 8;
                  MatrixUtil.transformCoords(transformationMatrix,x,y,sHelperPoint);
                  if(minX > sHelperPoint.x)
                  {
                     minX = Number(sHelperPoint.x);
                  }
                  if(maxX < sHelperPoint.x)
                  {
                     maxX = Number(sHelperPoint.x);
                  }
                  if(minY > sHelperPoint.y)
                  {
                     minY = Number(sHelperPoint.y);
                  }
                  if(maxY < sHelperPoint.y)
                  {
                     maxY = Number(sHelperPoint.y);
                  }
                  i++;
               }
            }
            resultRect.setTo(minX,minY,maxX - minX,maxY - minY);
         }
         return resultRect;
      }
      
      public function getBoundsProjected(transformationMatrix:Matrix3D, camPos:Vector3D, vertexID:int = 0, numVertices:int = -1, resultRect:Rectangle = null) : Rectangle
      {
         var minX:* = NaN;
         var minY:* = NaN;
         var offset:int = 0;
         var y:Number = NaN;
         var i:int = 0;
         var x:Number = NaN;
         if(camPos == null)
         {
            throw new ArgumentError("camPos must not be null");
         }
         if(resultRect == null)
         {
            resultRect = new Rectangle();
         }
         if(numVertices < 0 || vertexID + numVertices > mNumVertices)
         {
            numVertices = mNumVertices - vertexID;
         }
         if(numVertices == 0)
         {
            if(transformationMatrix)
            {
               MatrixUtil.transformCoords3D(transformationMatrix,0,0,0,sHelperPoint3D);
            }
            else
            {
               sHelperPoint3D.setTo(0,0,0);
            }
            MathUtil.intersectLineWithXYPlane(camPos,sHelperPoint3D,sHelperPoint);
            resultRect.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
         }
         else
         {
            minX = 1.79769313486232e308;
            var maxX:* = -1.79769313486232e308;
            minY = 1.79769313486232e308;
            var maxY:* = -1.79769313486232e308;
            offset = vertexID * 8 + 0;
            for(i = 0; i < numVertices; )
            {
               x = mRawData[offset];
               y = mRawData[int(offset + 1)];
               offset = offset + 8;
               if(transformationMatrix)
               {
                  MatrixUtil.transformCoords3D(transformationMatrix,x,y,0,sHelperPoint3D);
               }
               else
               {
                  sHelperPoint3D.setTo(x,y,0);
               }
               MathUtil.intersectLineWithXYPlane(camPos,sHelperPoint3D,sHelperPoint);
               if(minX > sHelperPoint.x)
               {
                  minX = Number(sHelperPoint.x);
               }
               if(maxX < sHelperPoint.x)
               {
                  maxX = Number(sHelperPoint.x);
               }
               if(minY > sHelperPoint.y)
               {
                  minY = Number(sHelperPoint.y);
               }
               if(maxY < sHelperPoint.y)
               {
                  maxY = Number(sHelperPoint.y);
               }
               i++;
            }
            resultRect.setTo(minX,minY,maxX - minX,maxY - minY);
         }
         return resultRect;
      }
      
      public function toString() : String
      {
         var i:int = 0;
         var result:String = "[VertexData \n";
         var position:Point = new Point();
         var texCoords:Point = new Point();
         for(i = 0; i < numVertices; )
         {
            getPosition(i,position);
            getTexCoords(i,texCoords);
            result = result + ("  [Vertex " + i + ": " + "x=" + position.x.toFixed(1) + ", " + "y=" + position.y.toFixed(1) + ", " + "rgb=" + getColor(i).toString(16) + ", " + "a=" + getAlpha(i).toFixed(2) + ", " + "u=" + texCoords.x.toFixed(4) + ", " + "v=" + texCoords.y.toFixed(4) + "]" + (i == numVertices - 1?"\n":",\n"));
            i++;
         }
         return result + "]";
      }
      
      public function get tinted() : Boolean
      {
         var i:int = 0;
         var j:int = 0;
         var offset:int = 2;
         for(i = 0; i < mNumVertices; )
         {
            for(j = 0; j < 4; )
            {
               if(mRawData[int(offset + j)] != 1)
               {
                  return true;
               }
               j++;
            }
            offset = offset + 8;
            i++;
         }
         return false;
      }
      
      public function setPremultipliedAlpha(value:Boolean, updateData:Boolean = true) : void
      {
         var dataLength:int = 0;
         var i:int = 0;
         var alpha:Number = NaN;
         var divisor:Number = NaN;
         var multiplier:Number = NaN;
         if(value == mPremultipliedAlpha)
         {
            return;
         }
         if(updateData)
         {
            dataLength = mNumVertices * 8;
            for(i = 2; i < dataLength; )
            {
               alpha = mRawData[int(i + 3)];
               divisor = !!mPremultipliedAlpha?alpha:1;
               multiplier = !!value?alpha:1;
               if(divisor != 0)
               {
                  mRawData[i] = mRawData[i] / divisor * multiplier;
                  mRawData[int(i + 1)] = mRawData[int(i + 1)] / divisor * multiplier;
                  mRawData[int(i + 2)] = mRawData[int(i + 2)] / divisor * multiplier;
               }
               i = i + 8;
            }
         }
         mPremultipliedAlpha = value;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return mPremultipliedAlpha;
      }
      
      public function set premultipliedAlpha(value:Boolean) : void
      {
         setPremultipliedAlpha(value);
      }
      
      public function get numVertices() : int
      {
         return mNumVertices;
      }
      
      public function set numVertices(value:int) : void
      {
         var i:* = 0;
         mRawData.fixed = false;
         mRawData.length = value * 8;
         var startIndex:int = mNumVertices * 8 + 2 + 3;
         var endIndex:int = mRawData.length;
         for(i = startIndex; i < endIndex; )
         {
            mRawData[i] = 1;
            i = int(i + 8);
         }
         mNumVertices = value;
         mRawData.fixed = true;
      }
      
      public function get rawData() : Vector.<Number>
      {
         return mRawData;
      }
   }
}
