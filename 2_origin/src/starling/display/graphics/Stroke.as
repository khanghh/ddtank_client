package starling.display.graphics
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.graphics.util.TriangleUtil;
   import starling.display.util.StrokeVertexUtil;
   import starling.textures.Texture;
   import starling.utils.MatrixUtil;
   
   public class Stroke extends Graphic
   {
      
      protected static const c_degenerateUseNext:uint = 1;
      
      protected static const c_degenerateUseLast:uint = 2;
      
      protected static var sCollissionHelper:StrokeCollisionHelper = null;
       
      
      protected var _line:Vector.<StrokeVertex>;
      
      protected var _numVertices:int;
      
      protected var _numAllocedVertices:int;
      
      protected var _indexOfLastRenderedVertex:int = -1;
      
      protected var _hasDegenerates:Boolean = false;
      
      protected var _cullDistanceSquared:Number = 0.0;
      
      protected var _lastScale:Number = 1.0;
      
      protected var _isReusingLine:Boolean = false;
      
      public function Stroke()
      {
         super();
         clear();
      }
      
      [inline]
      protected static function createPolyLinePreAlloc(_line:Vector.<StrokeVertex>, vertices:Vector.<Number>, indices:Vector.<uint>, _hasDegenerates:Boolean, indexOfLastRenderedVertex:int) : void
      {
         var _loc53_:* = NaN;
         _loc53_ = 3.14159265358979;
         var treatAsFirst:* = false;
         var treatAsLast:* = false;
         var i:* = 0;
         var treatAsRegular:Boolean = false;
         var idx0:* = 0;
         var idx2:* = 0;
         var v0:* = null;
         var v1:* = null;
         var v2:* = null;
         var vThickness:Number = NaN;
         var v0x:Number = NaN;
         var v0y:Number = NaN;
         var v1x:Number = NaN;
         var v1y:Number = NaN;
         var v2x:Number = NaN;
         var v2y:Number = NaN;
         var d0x:Number = NaN;
         var d0y:Number = NaN;
         var d1x:Number = NaN;
         var d1y:Number = NaN;
         var d0:* = NaN;
         var d1:* = NaN;
         var elbowThickness:Number = NaN;
         var dot:Number = NaN;
         var arcCosDot:Number = NaN;
         var n0x:Number = NaN;
         var n0y:Number = NaN;
         var n1x:Number = NaN;
         var n1y:Number = NaN;
         var cnx:Number = NaN;
         var cny:Number = NaN;
         var c:Number = NaN;
         var v1xPos:Number = NaN;
         var v1yPos:Number = NaN;
         var v1xNeg:Number = NaN;
         var v1yNeg:Number = NaN;
         var i2:* = 0;
         var _loc24_:int = _line.length;
         var lastD0:* = 0;
         var lastD1:* = 0;
         var degenerate:uint = 0;
         var idx:uint = 0;
         var startIndex:int = indexOfLastRenderedVertex <= 0?0:Number(indexOfLastRenderedVertex - 1);
         var vertCounter:int = startIndex * 18;
         var indiciesCounter:int = startIndex * 6;
         var prevV1xPos:* = 0;
         var prevV1xNeg:* = 0;
         var prevV1yPos:* = 0;
         var prevV1yNeg:* = 0;
         var usePreviousVertPositionsOnNextLoop:Boolean = false;
         var usePreviousVertPositions:Boolean = false;
         for(i = startIndex; i < _loc24_; )
         {
            idx = i;
            if(_hasDegenerates)
            {
               degenerate = _line[i].degenerate;
               if(degenerate != 0)
               {
                  idx = degenerate == 2?i - 1:Number(i + 1);
               }
               treatAsFirst = Boolean(idx == 0 || _line[idx - 1].degenerate > 0);
               treatAsLast = Boolean(idx == _loc24_ - 1 || _line[idx + 1].degenerate > 0);
            }
            else
            {
               treatAsFirst = idx == 0;
               treatAsLast = idx == _loc24_ - 1;
            }
            if(usePreviousVertPositionsOnNextLoop)
            {
               usePreviousVertPositionsOnNextLoop = false;
               usePreviousVertPositions = true;
            }
            else
            {
               usePreviousVertPositions = false;
            }
            treatAsRegular = treatAsFirst == false && treatAsLast == false;
            idx0 = uint(!!treatAsFirst?idx:idx - 1);
            idx2 = uint(!!treatAsLast?idx:idx + 1);
            v0 = _line[idx0];
            v1 = _line[idx];
            v2 = _line[idx2];
            vThickness = v1.thickness;
            v0x = v0.x;
            v0y = v0.y;
            v1x = v1.x;
            v1y = v1.y;
            v2x = v2.x;
            v2y = v2.y;
            d0x = v1x - v0x;
            d0y = v1y - v0y;
            d1x = v2x - v1x;
            d1y = v2y - v1y;
            if(treatAsRegular == false)
            {
               if(treatAsLast)
               {
                  v2x = v2x + d0x;
                  v2y = v2y + d0y;
                  d1x = v2x - v1x;
                  d1y = v2y - v1y;
               }
               if(treatAsFirst)
               {
                  v0x = v0x - d1x;
                  v0y = v0y - d1y;
                  d0x = v1x - v0x;
                  d0y = v1y - v0y;
               }
            }
            d0 = Number(Math.sqrt(d0x * d0x + d0y * d0y));
            d1 = Number(Math.sqrt(d1x * d1x + d1y * d1y));
            elbowThickness = vThickness * 0.5;
            if(treatAsRegular)
            {
               if(d0 == 0)
               {
                  d0 = lastD0;
               }
               else
               {
                  lastD0 = d0;
               }
               if(d1 == 0)
               {
                  d1 = lastD1;
               }
               else
               {
                  lastD1 = d1;
               }
               dot = (d0x * d1x + d0y * d1y) / (d0 * d1);
               arcCosDot = Math.acos(dot);
               elbowThickness = elbowThickness / Math.sin((3.14159265358979 - arcCosDot) * 0.5);
               if(elbowThickness != elbowThickness)
               {
                  elbowThickness = vThickness * 0.5;
               }
               else if(elbowThickness > vThickness * 4)
               {
                  elbowThickness = vThickness * 4;
               }
               if(dot <= 0 && d1 < vThickness * 0.5)
               {
                  usePreviousVertPositionsOnNextLoop = true;
               }
            }
            else
            {
               lastD0 = d0;
               lastD1 = d1;
            }
            n0x = -d0y / d0;
            n0y = d0x / d0;
            n1x = -d1y / d1;
            n1y = d1x / d1;
            cnx = n0x + n1x;
            cny = n0y + n1y;
            c = 1 / Math.sqrt(cnx * cnx + cny * cny) * elbowThickness;
            cnx = cnx * c;
            cny = cny * c;
            v1xPos = v1x + cnx;
            v1yPos = v1y + cny;
            v1xNeg = !!degenerate?v1xPos:Number(v1x - cnx);
            v1yNeg = !!degenerate?v1yPos:Number(v1y - cny);
            vertCounter++;
            vertices[vertCounter] = usePreviousVertPositions == false?v1xPos:Number(prevV1xPos);
            vertCounter++;
            vertices[vertCounter] = usePreviousVertPositions == false?v1yPos:Number(prevV1yPos);
            vertCounter++;
            vertices[vertCounter] = 0;
            vertCounter++;
            vertices[vertCounter] = v1.r2;
            vertCounter++;
            vertices[vertCounter] = v1.g2;
            vertCounter++;
            vertices[vertCounter] = v1.b2;
            vertCounter++;
            vertices[vertCounter] = v1.a2;
            vertCounter++;
            vertices[vertCounter] = v1.u;
            vertCounter++;
            vertices[vertCounter] = 1;
            vertCounter++;
            vertices[vertCounter] = v1xNeg;
            vertCounter++;
            vertices[vertCounter] = v1yNeg;
            vertCounter++;
            vertices[vertCounter] = 0;
            vertCounter++;
            vertices[vertCounter] = v1.r1;
            vertCounter++;
            vertices[vertCounter] = v1.g1;
            vertCounter++;
            vertices[vertCounter] = v1.b1;
            vertCounter++;
            vertices[vertCounter] = v1.a1;
            vertCounter++;
            vertices[vertCounter] = v1.u;
            vertCounter++;
            vertices[vertCounter] = 0;
            prevV1xPos = v1xPos;
            prevV1xNeg = v1xNeg;
            prevV1yPos = v1yPos;
            prevV1yNeg = v1yNeg;
            if(i < _loc24_ - 1)
            {
               i2 = i << 1;
               indiciesCounter++;
               indices[indiciesCounter] = i2;
               indiciesCounter++;
               indices[indiciesCounter] = i2 + 1;
               indiciesCounter++;
               indices[indiciesCounter] = i2 + 2;
               indiciesCounter++;
               indices[indiciesCounter] = i2 + 3;
               indiciesCounter++;
               indices[indiciesCounter] = i2 + 2;
               indiciesCounter++;
               indices[indiciesCounter] = i2 + 1;
            }
            i++;
         }
      }
      
      protected static function fixUpPolyLine(vertices:Vector.<StrokeVertex>) : int
      {
         if(vertices.length > 0 && vertices[0].degenerate > 0)
         {
            throw new Error("Degenerate on first line vertex");
         }
         var idx:int = vertices.length - 1;
         while(idx > 0 && vertices[idx].degenerate > 0)
         {
            vertices.pop();
            idx--;
         }
         return vertices.length;
      }
      
      protected static function cullPolyLineByDistance(line:Vector.<StrokeVertex>, cullDistanceSquared:Number, indexOfLastRenderedVertex:int) : int
      {
         var i:* = 0;
         var xDist:Number = NaN;
         var yDist:Number = NaN;
         var distanceFromLast:Number = NaN;
         if(line == null)
         {
            return 0;
         }
         if(line.length < 2)
         {
            return line.length;
         }
         var num:int = line.length;
         var startIndex:int = indexOfLastRenderedVertex < 2?1:Number(indexOfLastRenderedVertex - 1);
         var prevIndex:* = int(startIndex - 1);
         for(i = startIndex; i < num; )
         {
            xDist = line[prevIndex].x - line[i].x;
            yDist = line[prevIndex].y - line[i].y;
            distanceFromLast = xDist * xDist + yDist * yDist;
            if(distanceFromLast < cullDistanceSquared)
            {
               StrokeVertexUtil.removeStrokeVertexAt(line,i);
               num--;
               if(i > num)
               {
                  return num;
               }
               i--;
            }
            else
            {
               prevIndex = i;
            }
            i++;
         }
         return line.length;
      }
      
      public static function strokeCollideTest(s1:Stroke, s2:Stroke, intersectPoint:Point, staticLenIntersectPoints:Vector.<Point> = null) : Boolean
      {
         var i:int = 0;
         var s1v0:* = null;
         var s1v1:* = null;
         var j:int = 0;
         var s2v0:* = null;
         var s2v1:* = null;
         if(s1 == null || s2 == null || s1._line == null || s1._line == null)
         {
            return false;
         }
         if(sCollissionHelper == null)
         {
            sCollissionHelper = new StrokeCollisionHelper();
         }
         sCollissionHelper.testIntersectPoint.x = 0;
         sCollissionHelper.testIntersectPoint.y = 0;
         intersectPoint.x = 0;
         intersectPoint.y = 0;
         var hasSameParent:Boolean = false;
         if(s1.parent == s2.parent)
         {
            hasSameParent = true;
         }
         s1.getBounds(!!hasSameParent?s1.parent:s1.stage,sCollissionHelper.bounds1);
         s2.getBounds(!!hasSameParent?s2.parent:s2.stage,sCollissionHelper.bounds2);
         if(sCollissionHelper.bounds1.intersects(sCollissionHelper.bounds2) == false)
         {
            return false;
         }
         if(intersectPoint == null)
         {
            intersectPoint = new Point();
         }
         var numLinesS1:int = s1._line.length;
         var numLinesS2:int = s2._line.length;
         var hasHit:Boolean = false;
         if(sCollissionHelper.s2v0Vector == null || sCollissionHelper.s2v0Vector.length < numLinesS2)
         {
            sCollissionHelper.s2v0Vector = new Vector.<Point>(numLinesS2,true);
            sCollissionHelper.s2v1Vector = new Vector.<Point>(numLinesS2,true);
         }
         var pointCounter:int = 0;
         var maxPointCounter:int = 0;
         if(staticLenIntersectPoints != null)
         {
            maxPointCounter = staticLenIntersectPoints.length;
         }
         i = 1;
         while(i < numLinesS1)
         {
            s1v0 = s1._line[i - 1];
            s1v1 = s1._line[i];
            sCollissionHelper.localPT1.setTo(s1v0.x,s1v0.y);
            sCollissionHelper.localPT2.setTo(s1v1.x,s1v1.y);
            if(hasSameParent)
            {
               s1.localToParent(sCollissionHelper.localPT1,sCollissionHelper.globalPT1);
               s1.localToParent(sCollissionHelper.localPT2,sCollissionHelper.globalPT2);
            }
            else
            {
               s1.localToGlobal(sCollissionHelper.localPT1,sCollissionHelper.globalPT1);
               s1.localToGlobal(sCollissionHelper.localPT2,sCollissionHelper.globalPT2);
            }
            for(j = 1; j < numLinesS2; )
            {
               s2v0 = s2._line[j - 1];
               s2v1 = s2._line[j];
               if(i == 1)
               {
                  sCollissionHelper.localPT3.setTo(s2v0.x,s2v0.y);
                  sCollissionHelper.localPT4.setTo(s2v1.x,s2v1.y);
                  if(hasSameParent)
                  {
                     s2.localToParent(sCollissionHelper.localPT3,sCollissionHelper.globalPT3);
                     s2.localToParent(sCollissionHelper.localPT4,sCollissionHelper.globalPT4);
                  }
                  else
                  {
                     s2.localToGlobal(sCollissionHelper.localPT3,sCollissionHelper.globalPT3);
                     s2.localToGlobal(sCollissionHelper.localPT4,sCollissionHelper.globalPT4);
                  }
                  if(sCollissionHelper.s2v0Vector[j] == null)
                  {
                     sCollissionHelper.s2v0Vector[j] = new Point(sCollissionHelper.globalPT3.x,sCollissionHelper.globalPT3.y);
                     sCollissionHelper.s2v1Vector[j] = new Point(sCollissionHelper.globalPT4.x,sCollissionHelper.globalPT4.y);
                  }
                  else
                  {
                     sCollissionHelper.s2v0Vector[j].x = sCollissionHelper.globalPT3.x;
                     sCollissionHelper.s2v0Vector[j].y = sCollissionHelper.globalPT3.y;
                     sCollissionHelper.s2v1Vector[j].x = sCollissionHelper.globalPT4.x;
                     sCollissionHelper.s2v1Vector[j].y = sCollissionHelper.globalPT4.y;
                  }
               }
               else
               {
                  sCollissionHelper.globalPT3.x = sCollissionHelper.s2v0Vector[j].x;
                  sCollissionHelper.globalPT3.y = sCollissionHelper.s2v0Vector[j].y;
                  sCollissionHelper.globalPT4.x = sCollissionHelper.s2v1Vector[j].x;
                  sCollissionHelper.globalPT4.y = sCollissionHelper.s2v1Vector[j].y;
               }
               if(TriangleUtil.lineIntersectLine(sCollissionHelper.globalPT1.x,sCollissionHelper.globalPT1.y,sCollissionHelper.globalPT2.x,sCollissionHelper.globalPT2.y,sCollissionHelper.globalPT3.x,sCollissionHelper.globalPT3.y,sCollissionHelper.globalPT4.x,sCollissionHelper.globalPT4.y,sCollissionHelper.testIntersectPoint))
               {
                  if(staticLenIntersectPoints != null && pointCounter < maxPointCounter - 1)
                  {
                     if(hasSameParent)
                     {
                        s1.parent.localToGlobal(sCollissionHelper.testIntersectPoint,staticLenIntersectPoints[pointCounter]);
                     }
                     else
                     {
                        staticLenIntersectPoints[pointCounter].x = sCollissionHelper.testIntersectPoint.x;
                        staticLenIntersectPoints[pointCounter].y = sCollissionHelper.testIntersectPoint.y;
                     }
                     pointCounter++;
                     staticLenIntersectPoints[pointCounter].x = NaN;
                     staticLenIntersectPoints[pointCounter].y = NaN;
                  }
                  if(sCollissionHelper.testIntersectPoint.length > intersectPoint.length)
                  {
                     if(hasSameParent)
                     {
                        s1.parent.localToGlobal(sCollissionHelper.testIntersectPoint,intersectPoint);
                     }
                     else
                     {
                        intersectPoint.x = sCollissionHelper.testIntersectPoint.x;
                        intersectPoint.y = sCollissionHelper.testIntersectPoint.y;
                     }
                  }
                  hasHit = true;
               }
               j++;
            }
            i++;
         }
         return hasHit;
      }
      
      protected static function adjustThicknessOfGeometry(vertices:Vector.<Number>, oldScale:Number, newScale:Number) : void
      {
         var i:int = 0;
         var posX:Number = NaN;
         var posY:Number = NaN;
         var negX:Number = NaN;
         var negY:Number = NaN;
         var helpPointA_x:* = NaN;
         var helpPointA_y:* = NaN;
         var helpPointB_x:* = NaN;
         var helpPointB_y:* = NaN;
         var distance_x:Number = NaN;
         var distance_y:Number = NaN;
         var halfDistance_x:Number = NaN;
         var halfDistance_y:Number = NaN;
         var midPoint_x:Number = NaN;
         var midPoint_y:Number = NaN;
         var numVerts:int = vertices.length;
         var scaleFactor:Number = oldScale / newScale;
         for(i = 0; i < numVerts; )
         {
            posX = vertices[i];
            posY = vertices[i + 1];
            negX = vertices[i + 9];
            negY = vertices[i + 10];
            helpPointA_x = posX;
            helpPointA_y = posY;
            helpPointB_x = negX;
            helpPointB_y = negY;
            distance_x = helpPointB_x - helpPointA_x;
            distance_y = helpPointB_y - helpPointA_y;
            halfDistance_x = distance_x * 0.5;
            halfDistance_y = distance_y * 0.5;
            midPoint_x = helpPointA_x + halfDistance_x;
            midPoint_y = helpPointA_y + halfDistance_y;
            halfDistance_x = halfDistance_x * scaleFactor;
            halfDistance_y = halfDistance_y * scaleFactor;
            posX = midPoint_x + halfDistance_x;
            posY = midPoint_y + halfDistance_y;
            negX = midPoint_x - halfDistance_x;
            negY = midPoint_y - halfDistance_y;
            vertices[i] = posX;
            vertices[i + 1] = posY;
            vertices[i + 9] = negX;
            vertices[i + 10] = negY;
            i = i + 18;
         }
      }
      
      public function get numVertices() : int
      {
         return _numVertices;
      }
      
      override public function dispose() : void
      {
         clear();
         super.dispose();
      }
      
      public function setPointCullDistance(cullDistance:Number = 0.0) : void
      {
         _cullDistanceSquared = cullDistance * cullDistance;
      }
      
      public function clearForReuse() : void
      {
         if(_line == null || _line.length == 0)
         {
            clear();
            return;
         }
         if(minBounds)
         {
            var _loc1_:* = Infinity;
            minBounds.y = _loc1_;
            minBounds.x = _loc1_;
            _loc1_ = -Infinity;
            maxBounds.y = _loc1_;
            maxBounds.x = _loc1_;
         }
         _numVertices = 0;
         setGeometryInvalid(false);
         _hasDegenerates = false;
         _indexOfLastRenderedVertex = -1;
         _isReusingLine = true;
      }
      
      public function clear() : void
      {
         if(minBounds)
         {
            var _loc1_:* = Infinity;
            minBounds.y = _loc1_;
            minBounds.x = _loc1_;
            _loc1_ = -Infinity;
            maxBounds.y = _loc1_;
            maxBounds.x = _loc1_;
         }
         if(_line)
         {
            StrokeVertex.returnInstances(_line);
            _line.length = 0;
         }
         else
         {
            _line = new Vector.<StrokeVertex>();
         }
         _numVertices = 0;
         _numAllocedVertices = 0;
         setGeometryInvalid();
         _hasDegenerates = false;
         _indexOfLastRenderedVertex = -1;
         _isReusingLine = false;
      }
      
      public function addDegenerates(destX:Number, destY:Number) : void
      {
         if(_numVertices < 1)
         {
            return;
         }
         var lastVertex:StrokeVertex = _line[_numVertices - 1];
         addVertexInternal(lastVertex.x,lastVertex.y,0);
         setLastVertexAsDegenerate(2);
         addVertexInternal(destX,destY,0);
         setLastVertexAsDegenerate(1);
         _hasDegenerates = true;
      }
      
      protected function setLastVertexAsDegenerate(type:uint) : void
      {
         _line[_numVertices - 1].degenerate = type;
         _line[_numVertices - 1].u = 0;
      }
      
      public function lineTo(x:Number, y:Number, thickness:Number = 1, color:uint = 16777215, alpha:Number = 1) : void
      {
         addVertexInternal(x,y,thickness,color,alpha,color,alpha);
      }
      
      public function moveTo(x:Number, y:Number, thickness:Number = 1, color:uint = 16777215, alpha:Number = 1.0) : void
      {
         addDegenerates(x,y);
      }
      
      public function modifyVertexPosition(index:int, x:Number, y:Number) : void
      {
         var v:StrokeVertex = _line[index];
         v.x = x;
         v.y = y;
         if(buffersInvalid == false)
         {
            setGeometryInvalid();
         }
      }
      
      public function fromBounds(boundingBox:Rectangle, thickness:int = 1) : void
      {
         clear();
         addVertex(boundingBox.x,boundingBox.y,thickness);
         addVertex(boundingBox.x + boundingBox.width,boundingBox.y,thickness);
         addVertex(boundingBox.x + boundingBox.width,boundingBox.y + boundingBox.height,thickness);
         addVertex(boundingBox.x,boundingBox.y + boundingBox.height,thickness);
         addVertex(boundingBox.x,boundingBox.y,thickness);
      }
      
      public function addVertex(x:Number, y:Number, thickness:Number = 1, color0:uint = 16777215, alpha0:Number = 1, color1:uint = 16777215, alpha1:Number = 1) : void
      {
         addVertexInternal(x,y,thickness,color0,alpha0,color1,alpha1);
      }
      
      protected function addVertexInternal(x:Number, y:Number, thickness:Number = 1, color0:uint = 16777215, alpha0:Number = 1, color1:uint = 16777215, alpha1:Number = 1) : void
      {
         var prevVertex:* = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var d:Number = NaN;
         var cullDX:Number = NaN;
         var cullDY:Number = NaN;
         var v:* = null;
         var u:* = 0;
         var textures:Vector.<Texture> = _material.textures;
         if(textures.length > 0 && _numVertices > 0)
         {
            prevVertex = _line[_numVertices - 1];
            dx = x - prevVertex.x;
            dy = y - prevVertex.y;
            d = Math.sqrt(dx * dx + dy * dy);
            u = Number(prevVertex.u + d / textures[0].width);
         }
         var r0:Number = (color0 >> 16) / 255;
         var g0:Number = ((color0 & 65280) >> 8) / 255;
         var b0:Number = (color0 & 255) / 255;
         var r1:Number = (color1 >> 16) / 255;
         var g1:Number = ((color1 & 65280) >> 8) / 255;
         var b1:Number = (color1 & 255) / 255;
         if(_cullDistanceSquared > 0 && _numVertices > 0)
         {
            cullDX = (x - _line[_numVertices - 1].x) * (x - _line[_numVertices - 1].x);
            cullDY = (y - _line[_numVertices - 1].y) * (y - _line[_numVertices - 1].y);
            if(cullDY + cullDX < _cullDistanceSquared)
            {
               return;
            }
         }
         if(_isReusingLine)
         {
            v = _line[_numVertices];
         }
         else
         {
            v = StrokeVertex.getInstance();
            _line[_numVertices] = v;
         }
         v.x = x;
         v.y = y;
         v.r1 = r0;
         v.g1 = g0;
         v.b1 = b0;
         v.a1 = alpha0;
         v.r2 = r1;
         v.g2 = g1;
         v.b2 = b1;
         v.a2 = alpha1;
         v.u = u;
         v.v = 0;
         v.thickness = thickness;
         v.degenerate = 0;
         if(_numAllocedVertices == _numVertices)
         {
            _numAllocedVertices = Number(_numAllocedVertices) + 1;
         }
         _numVertices = Number(_numVertices) + 1;
         var halfThickness:Number = 0.5 * thickness;
         if(x - halfThickness < minBounds.x)
         {
            minBounds.x = x - halfThickness;
         }
         else if(x + halfThickness > maxBounds.x)
         {
            maxBounds.x = x + halfThickness;
         }
         if(y - halfThickness < minBounds.y)
         {
            minBounds.y = y - halfThickness;
         }
         else if(y + halfThickness > maxBounds.y)
         {
            maxBounds.y = y + halfThickness;
         }
         if(maxBounds.x == -Infinity)
         {
            maxBounds.x = x;
         }
         if(maxBounds.y == -Infinity)
         {
            maxBounds.y = y;
         }
         if(_isReusingLine == false && buffersInvalid == false)
         {
            setGeometryInvalid();
         }
      }
      
      public function getVertexPosition(index:int, prealloc:Point = null) : Point
      {
         var point:* = prealloc;
         if(point == null)
         {
            point = new Point();
         }
         point.x = _line[index].x;
         point.y = _line[index].y;
         return point;
      }
      
      override protected function buildGeometry() : void
      {
         buildGeometryPreAllocatedVectors();
      }
      
      protected function buildGeometryPreAllocatedVectors() : void
      {
         var _loc5_:* = NaN;
         _loc5_ = 0.111111111111111;
         if(_line == null || _line.length <= 1)
         {
            return;
         }
         if(_numAllocedVertices != _numVertices)
         {
            throw new Error("Stroke: Only use clearForReuse() when adding exactly the right number of vertices");
         }
         var indexOffset:int = 0;
         _numVertices = fixUpPolyLine(_line);
         if(_cullDistanceSquared > 0.1)
         {
            _numVertices = cullPolyLineByDistance(_line,_cullDistanceSquared,_indexOfLastRenderedVertex);
            _numAllocedVertices = _numVertices;
         }
         var numVerts:int = _line.length * 18;
         var numIndices:int = (_line.length - 1) * 6;
         if(_indexOfLastRenderedVertex == -1)
         {
            if(vertices == null || numVerts != vertices.length)
            {
               vertices = new Vector.<Number>(numVerts,true);
            }
            if(indices == null || numIndices != indices.length)
            {
               indices = new Vector.<uint>(numIndices,true);
            }
         }
         else
         {
            if(vertices.fixed)
            {
               vertices = vertices.slice();
            }
            if(indices.fixed)
            {
               indices = indices.slice();
            }
         }
         createPolyLinePreAlloc(_line,vertices,indices,_hasDegenerates,_indexOfLastRenderedVertex);
         var oldVerticesLength:int = 0;
         indexOffset = indexOffset + (vertices.length - oldVerticesLength) * 0.111111111111111;
         _indexOfLastRenderedVertex = _line.length - 1;
      }
      
      override protected function shapeHitTestLocalInternal(localX:Number, localY:Number) : Boolean
      {
         var i:int = 0;
         var v0:* = null;
         var v1:* = null;
         var lineLengthSquared:Number = NaN;
         var interpolation:Number = NaN;
         var intersectionX:Number = NaN;
         var intersectionY:Number = NaN;
         var distanceSquared:Number = NaN;
         var intersectThickness:Number = NaN;
         if(_line == null)
         {
            return false;
         }
         if(_line.length < 2)
         {
            return false;
         }
         var numLines:int = _line.length;
         for(i = 1; i < numLines; )
         {
            v0 = _line[i - 1];
            v1 = _line[i];
            lineLengthSquared = (v1.x - v0.x) * (v1.x - v0.x) + (v1.y - v0.y) * (v1.y - v0.y);
            interpolation = ((localX - v0.x) * (v1.x - v0.x) + (localY - v0.y) * (v1.y - v0.y)) / lineLengthSquared;
            if(!(interpolation < 0 || interpolation > 1))
            {
               intersectionX = v0.x + interpolation * (v1.x - v0.x);
               intersectionY = v0.y + interpolation * (v1.y - v0.y);
               distanceSquared = (localX - intersectionX) * (localX - intersectionX) + (localY - intersectionY) * (localY - intersectionY);
               intersectThickness = v0.thickness * (1 - interpolation) + v1.thickness * interpolation;
               intersectThickness = intersectThickness + _precisionHitTestDistance;
               if(distanceSquared <= intersectThickness * intersectThickness)
               {
                  return true;
               }
            }
            i++;
         }
         return false;
      }
      
      public function localToParent(localPoint:Point, resultPoint:Point = null) : Point
      {
         return MatrixUtil.transformCoords(transformationMatrix,localPoint.x,localPoint.y,resultPoint);
      }
      
      public function scaleGeometry(newScale:Number) : void
      {
         if(newScale == _lastScale || newScale <= 0)
         {
            return;
         }
         adjustThicknessOfGeometry(vertices,_lastScale,newScale);
         isGeometryScaled = true;
         _lastScale = newScale;
      }
   }
}

import flash.geom.Point;
import flash.geom.Rectangle;

class StrokeCollisionHelper
{
    
   
   public var localPT1:Point;
   
   public var localPT2:Point;
   
   public var localPT3:Point;
   
   public var localPT4:Point;
   
   public var globalPT1:Point;
   
   public var globalPT2:Point;
   
   public var globalPT3:Point;
   
   public var globalPT4:Point;
   
   public var bounds1:Rectangle;
   
   public var bounds2:Rectangle;
   
   public var testIntersectPoint:Point;
   
   public var s1v0Vector:Vector.<Point> = null;
   
   public var s1v1Vector:Vector.<Point> = null;
   
   public var s2v0Vector:Vector.<Point> = null;
   
   public var s2v1Vector:Vector.<Point> = null;
   
   function StrokeCollisionHelper()
   {
      localPT1 = new Point();
      localPT2 = new Point();
      localPT3 = new Point();
      localPT4 = new Point();
      globalPT1 = new Point();
      globalPT2 = new Point();
      globalPT3 = new Point();
      globalPT4 = new Point();
      bounds1 = new Rectangle();
      bounds2 = new Rectangle();
      testIntersectPoint = new Point();
      super();
   }
}
