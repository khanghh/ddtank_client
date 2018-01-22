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
      protected static function createPolyLinePreAlloc(param1:Vector.<StrokeVertex>, param2:Vector.<Number>, param3:Vector.<uint>, param4:Boolean, param5:int) : void
      {
         var _loc53_:* = NaN;
         _loc53_ = 3.14159265358979;
         var _loc45_:* = false;
         var _loc19_:* = false;
         var _loc50_:* = 0;
         var _loc32_:Boolean = false;
         var _loc20_:* = 0;
         var _loc22_:* = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc28_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc52_:Number = NaN;
         var _loc54_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc56_:Number = NaN;
         var _loc57_:Number = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc41_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc49_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc30_:* = 0;
         var _loc24_:int = param1.length;
         var _loc38_:* = 0;
         var _loc37_:* = 0;
         var _loc16_:uint = 0;
         var _loc48_:uint = 0;
         var _loc47_:int = param5 <= 0?0:Number(param5 - 1);
         var _loc34_:int = _loc47_ * 18;
         var _loc55_:int = _loc47_ * 6;
         var _loc21_:* = 0;
         var _loc51_:* = 0;
         var _loc15_:* = 0;
         var _loc8_:* = 0;
         var _loc23_:Boolean = false;
         var _loc9_:Boolean = false;
         _loc50_ = _loc47_;
         while(_loc50_ < _loc24_)
         {
            _loc48_ = _loc50_;
            if(param4)
            {
               _loc16_ = param1[_loc50_].degenerate;
               if(_loc16_ != 0)
               {
                  _loc48_ = _loc16_ == 2?_loc50_ - 1:Number(_loc50_ + 1);
               }
               _loc45_ = Boolean(_loc48_ == 0 || param1[_loc48_ - 1].degenerate > 0);
               _loc19_ = Boolean(_loc48_ == _loc24_ - 1 || param1[_loc48_ + 1].degenerate > 0);
            }
            else
            {
               _loc45_ = _loc48_ == 0;
               _loc19_ = _loc48_ == _loc24_ - 1;
            }
            if(_loc23_)
            {
               _loc23_ = false;
               _loc9_ = true;
            }
            else
            {
               _loc9_ = false;
            }
            _loc32_ = _loc45_ == false && _loc19_ == false;
            _loc20_ = uint(!!_loc45_?_loc48_:_loc48_ - 1);
            _loc22_ = uint(!!_loc19_?_loc48_:_loc48_ + 1);
            _loc7_ = param1[_loc20_];
            _loc6_ = param1[_loc48_];
            _loc10_ = param1[_loc22_];
            _loc28_ = _loc6_.thickness;
            _loc25_ = _loc7_.x;
            _loc26_ = _loc7_.y;
            _loc40_ = _loc6_.x;
            _loc39_ = _loc6_.y;
            _loc52_ = _loc10_.x;
            _loc54_ = _loc10_.y;
            _loc18_ = _loc40_ - _loc25_;
            _loc17_ = _loc39_ - _loc26_;
            _loc56_ = _loc52_ - _loc40_;
            _loc57_ = _loc54_ - _loc39_;
            if(_loc32_ == false)
            {
               if(_loc19_)
               {
                  _loc52_ = _loc52_ + _loc18_;
                  _loc54_ = _loc54_ + _loc17_;
                  _loc56_ = _loc52_ - _loc40_;
                  _loc57_ = _loc54_ - _loc39_;
               }
               if(_loc45_)
               {
                  _loc25_ = _loc25_ - _loc56_;
                  _loc26_ = _loc26_ - _loc57_;
                  _loc18_ = _loc40_ - _loc25_;
                  _loc17_ = _loc39_ - _loc26_;
               }
            }
            _loc13_ = Number(Math.sqrt(_loc18_ * _loc18_ + _loc17_ * _loc17_));
            _loc14_ = Number(Math.sqrt(_loc56_ * _loc56_ + _loc57_ * _loc57_));
            _loc41_ = _loc28_ * 0.5;
            if(_loc32_)
            {
               if(_loc13_ == 0)
               {
                  _loc13_ = _loc38_;
               }
               else
               {
                  _loc38_ = _loc13_;
               }
               if(_loc14_ == 0)
               {
                  _loc14_ = _loc37_;
               }
               else
               {
                  _loc37_ = _loc14_;
               }
               _loc11_ = (_loc18_ * _loc56_ + _loc17_ * _loc57_) / (_loc13_ * _loc14_);
               _loc27_ = Math.acos(_loc11_);
               _loc41_ = _loc41_ / Math.sin((3.14159265358979 - _loc27_) * 0.5);
               if(_loc41_ != _loc41_)
               {
                  _loc41_ = _loc28_ * 0.5;
               }
               else if(_loc41_ > _loc28_ * 4)
               {
                  _loc41_ = _loc28_ * 4;
               }
               if(_loc11_ <= 0 && _loc14_ < _loc28_ * 0.5)
               {
                  _loc23_ = true;
               }
            }
            else
            {
               _loc38_ = _loc13_;
               _loc37_ = _loc14_;
            }
            _loc42_ = -_loc17_ / _loc13_;
            _loc43_ = _loc18_ / _loc13_;
            _loc29_ = -_loc57_ / _loc14_;
            _loc31_ = _loc56_ / _loc14_;
            _loc44_ = _loc42_ + _loc29_;
            _loc46_ = _loc43_ + _loc31_;
            _loc49_ = 1 / Math.sqrt(_loc44_ * _loc44_ + _loc46_ * _loc46_) * _loc41_;
            _loc44_ = _loc44_ * _loc49_;
            _loc46_ = _loc46_ * _loc49_;
            _loc36_ = _loc40_ + _loc44_;
            _loc35_ = _loc39_ + _loc46_;
            _loc12_ = !!_loc16_?_loc36_:Number(_loc40_ - _loc44_);
            _loc33_ = !!_loc16_?_loc35_:Number(_loc39_ - _loc46_);
            _loc34_++;
            param2[_loc34_] = _loc9_ == false?_loc36_:Number(_loc21_);
            _loc34_++;
            param2[_loc34_] = _loc9_ == false?_loc35_:Number(_loc15_);
            _loc34_++;
            param2[_loc34_] = 0;
            _loc34_++;
            param2[_loc34_] = _loc6_.r2;
            _loc34_++;
            param2[_loc34_] = _loc6_.g2;
            _loc34_++;
            param2[_loc34_] = _loc6_.b2;
            _loc34_++;
            param2[_loc34_] = _loc6_.a2;
            _loc34_++;
            param2[_loc34_] = _loc6_.u;
            _loc34_++;
            param2[_loc34_] = 1;
            _loc34_++;
            param2[_loc34_] = _loc12_;
            _loc34_++;
            param2[_loc34_] = _loc33_;
            _loc34_++;
            param2[_loc34_] = 0;
            _loc34_++;
            param2[_loc34_] = _loc6_.r1;
            _loc34_++;
            param2[_loc34_] = _loc6_.g1;
            _loc34_++;
            param2[_loc34_] = _loc6_.b1;
            _loc34_++;
            param2[_loc34_] = _loc6_.a1;
            _loc34_++;
            param2[_loc34_] = _loc6_.u;
            _loc34_++;
            param2[_loc34_] = 0;
            _loc21_ = _loc36_;
            _loc51_ = _loc12_;
            _loc15_ = _loc35_;
            _loc8_ = _loc33_;
            if(_loc50_ < _loc24_ - 1)
            {
               _loc30_ = _loc50_ << 1;
               _loc55_++;
               param3[_loc55_] = _loc30_;
               _loc55_++;
               param3[_loc55_] = _loc30_ + 1;
               _loc55_++;
               param3[_loc55_] = _loc30_ + 2;
               _loc55_++;
               param3[_loc55_] = _loc30_ + 3;
               _loc55_++;
               param3[_loc55_] = _loc30_ + 2;
               _loc55_++;
               param3[_loc55_] = _loc30_ + 1;
            }
            _loc50_++;
         }
      }
      
      protected static function fixUpPolyLine(param1:Vector.<StrokeVertex>) : int
      {
         if(param1.length > 0 && param1[0].degenerate > 0)
         {
            throw new Error("Degenerate on first line vertex");
         }
         var _loc2_:int = param1.length - 1;
         while(_loc2_ > 0 && param1[_loc2_].degenerate > 0)
         {
            param1.pop();
            _loc2_--;
         }
         return param1.length;
      }
      
      protected static function cullPolyLineByDistance(param1:Vector.<StrokeVertex>, param2:Number, param3:int) : int
      {
         var _loc10_:* = 0;
         var _loc7_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param1 == null)
         {
            return 0;
         }
         if(param1.length < 2)
         {
            return param1.length;
         }
         var _loc4_:int = param1.length;
         var _loc5_:int = param3 < 2?1:Number(param3 - 1);
         var _loc8_:* = int(_loc5_ - 1);
         _loc10_ = _loc5_;
         while(_loc10_ < _loc4_)
         {
            _loc7_ = param1[_loc8_].x - param1[_loc10_].x;
            _loc9_ = param1[_loc8_].y - param1[_loc10_].y;
            _loc6_ = _loc7_ * _loc7_ + _loc9_ * _loc9_;
            if(_loc6_ < param2)
            {
               StrokeVertexUtil.removeStrokeVertexAt(param1,_loc10_);
               _loc4_--;
               if(_loc10_ > _loc4_)
               {
                  return _loc4_;
               }
               _loc10_--;
            }
            else
            {
               _loc8_ = _loc10_;
            }
            _loc10_++;
         }
         return param1.length;
      }
      
      public static function strokeCollideTest(param1:Stroke, param2:Stroke, param3:Point, param4:Vector.<Point> = null) : Boolean
      {
         var _loc9_:int = 0;
         var _loc12_:* = null;
         var _loc11_:* = null;
         var _loc6_:int = 0;
         var _loc13_:* = null;
         var _loc16_:* = null;
         if(param1 == null || param2 == null || param1._line == null || param1._line == null)
         {
            return false;
         }
         if(sCollissionHelper == null)
         {
            sCollissionHelper = new StrokeCollisionHelper();
         }
         sCollissionHelper.testIntersectPoint.x = 0;
         sCollissionHelper.testIntersectPoint.y = 0;
         param3.x = 0;
         param3.y = 0;
         var _loc15_:Boolean = false;
         if(param1.parent == param2.parent)
         {
            _loc15_ = true;
         }
         param1.getBounds(!!_loc15_?param1.parent:param1.stage,sCollissionHelper.bounds1);
         param2.getBounds(!!_loc15_?param2.parent:param2.stage,sCollissionHelper.bounds2);
         if(sCollissionHelper.bounds1.intersects(sCollissionHelper.bounds2) == false)
         {
            return false;
         }
         if(param3 == null)
         {
            param3 = new Point();
         }
         var _loc8_:int = param1._line.length;
         var _loc5_:int = param2._line.length;
         var _loc14_:Boolean = false;
         if(sCollissionHelper.s2v0Vector == null || sCollissionHelper.s2v0Vector.length < _loc5_)
         {
            sCollissionHelper.s2v0Vector = new Vector.<Point>(_loc5_,true);
            sCollissionHelper.s2v1Vector = new Vector.<Point>(_loc5_,true);
         }
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         if(param4 != null)
         {
            _loc7_ = param4.length;
         }
         _loc9_ = 1;
         while(_loc9_ < _loc8_)
         {
            _loc12_ = param1._line[_loc9_ - 1];
            _loc11_ = param1._line[_loc9_];
            sCollissionHelper.localPT1.setTo(_loc12_.x,_loc12_.y);
            sCollissionHelper.localPT2.setTo(_loc11_.x,_loc11_.y);
            if(_loc15_)
            {
               param1.localToParent(sCollissionHelper.localPT1,sCollissionHelper.globalPT1);
               param1.localToParent(sCollissionHelper.localPT2,sCollissionHelper.globalPT2);
            }
            else
            {
               param1.localToGlobal(sCollissionHelper.localPT1,sCollissionHelper.globalPT1);
               param1.localToGlobal(sCollissionHelper.localPT2,sCollissionHelper.globalPT2);
            }
            _loc6_ = 1;
            while(_loc6_ < _loc5_)
            {
               _loc13_ = param2._line[_loc6_ - 1];
               _loc16_ = param2._line[_loc6_];
               if(_loc9_ == 1)
               {
                  sCollissionHelper.localPT3.setTo(_loc13_.x,_loc13_.y);
                  sCollissionHelper.localPT4.setTo(_loc16_.x,_loc16_.y);
                  if(_loc15_)
                  {
                     param2.localToParent(sCollissionHelper.localPT3,sCollissionHelper.globalPT3);
                     param2.localToParent(sCollissionHelper.localPT4,sCollissionHelper.globalPT4);
                  }
                  else
                  {
                     param2.localToGlobal(sCollissionHelper.localPT3,sCollissionHelper.globalPT3);
                     param2.localToGlobal(sCollissionHelper.localPT4,sCollissionHelper.globalPT4);
                  }
                  if(sCollissionHelper.s2v0Vector[_loc6_] == null)
                  {
                     sCollissionHelper.s2v0Vector[_loc6_] = new Point(sCollissionHelper.globalPT3.x,sCollissionHelper.globalPT3.y);
                     sCollissionHelper.s2v1Vector[_loc6_] = new Point(sCollissionHelper.globalPT4.x,sCollissionHelper.globalPT4.y);
                  }
                  else
                  {
                     sCollissionHelper.s2v0Vector[_loc6_].x = sCollissionHelper.globalPT3.x;
                     sCollissionHelper.s2v0Vector[_loc6_].y = sCollissionHelper.globalPT3.y;
                     sCollissionHelper.s2v1Vector[_loc6_].x = sCollissionHelper.globalPT4.x;
                     sCollissionHelper.s2v1Vector[_loc6_].y = sCollissionHelper.globalPT4.y;
                  }
               }
               else
               {
                  sCollissionHelper.globalPT3.x = sCollissionHelper.s2v0Vector[_loc6_].x;
                  sCollissionHelper.globalPT3.y = sCollissionHelper.s2v0Vector[_loc6_].y;
                  sCollissionHelper.globalPT4.x = sCollissionHelper.s2v1Vector[_loc6_].x;
                  sCollissionHelper.globalPT4.y = sCollissionHelper.s2v1Vector[_loc6_].y;
               }
               if(TriangleUtil.lineIntersectLine(sCollissionHelper.globalPT1.x,sCollissionHelper.globalPT1.y,sCollissionHelper.globalPT2.x,sCollissionHelper.globalPT2.y,sCollissionHelper.globalPT3.x,sCollissionHelper.globalPT3.y,sCollissionHelper.globalPT4.x,sCollissionHelper.globalPT4.y,sCollissionHelper.testIntersectPoint))
               {
                  if(param4 != null && _loc10_ < _loc7_ - 1)
                  {
                     if(_loc15_)
                     {
                        param1.parent.localToGlobal(sCollissionHelper.testIntersectPoint,param4[_loc10_]);
                     }
                     else
                     {
                        param4[_loc10_].x = sCollissionHelper.testIntersectPoint.x;
                        param4[_loc10_].y = sCollissionHelper.testIntersectPoint.y;
                     }
                     _loc10_++;
                     param4[_loc10_].x = NaN;
                     param4[_loc10_].y = NaN;
                  }
                  if(sCollissionHelper.testIntersectPoint.length > param3.length)
                  {
                     if(_loc15_)
                     {
                        param1.parent.localToGlobal(sCollissionHelper.testIntersectPoint,param3);
                     }
                     else
                     {
                        param3.x = sCollissionHelper.testIntersectPoint.x;
                        param3.y = sCollissionHelper.testIntersectPoint.y;
                     }
                  }
                  _loc14_ = true;
               }
               _loc6_++;
            }
            _loc9_++;
         }
         return _loc14_;
      }
      
      protected static function adjustThicknessOfGeometry(param1:Vector.<Number>, param2:Number, param3:Number) : void
      {
         var _loc12_:int = 0;
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc14_:* = NaN;
         var _loc13_:* = NaN;
         var _loc19_:* = NaN;
         var _loc18_:* = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:int = param1.length;
         var _loc9_:Number = param2 / param3;
         _loc12_ = 0;
         while(_loc12_ < _loc4_)
         {
            _loc8_ = param1[_loc12_];
            _loc7_ = param1[_loc12_ + 1];
            _loc16_ = param1[_loc12_ + 9];
            _loc15_ = param1[_loc12_ + 10];
            _loc14_ = _loc8_;
            _loc13_ = _loc7_;
            _loc19_ = _loc16_;
            _loc18_ = _loc15_;
            _loc10_ = _loc19_ - _loc14_;
            _loc11_ = _loc18_ - _loc13_;
            _loc17_ = _loc10_ * 0.5;
            _loc20_ = _loc11_ * 0.5;
            _loc5_ = _loc14_ + _loc17_;
            _loc6_ = _loc13_ + _loc20_;
            _loc17_ = _loc17_ * _loc9_;
            _loc20_ = _loc20_ * _loc9_;
            _loc8_ = _loc5_ + _loc17_;
            _loc7_ = _loc6_ + _loc20_;
            _loc16_ = _loc5_ - _loc17_;
            _loc15_ = _loc6_ - _loc20_;
            param1[_loc12_] = _loc8_;
            param1[_loc12_ + 1] = _loc7_;
            param1[_loc12_ + 9] = _loc16_;
            param1[_loc12_ + 10] = _loc15_;
            _loc12_ = _loc12_ + 18;
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
      
      public function setPointCullDistance(param1:Number = 0.0) : void
      {
         _cullDistanceSquared = param1 * param1;
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
      
      public function addDegenerates(param1:Number, param2:Number) : void
      {
         if(_numVertices < 1)
         {
            return;
         }
         var _loc3_:StrokeVertex = _line[_numVertices - 1];
         addVertexInternal(_loc3_.x,_loc3_.y,0);
         setLastVertexAsDegenerate(2);
         addVertexInternal(param1,param2,0);
         setLastVertexAsDegenerate(1);
         _hasDegenerates = true;
      }
      
      protected function setLastVertexAsDegenerate(param1:uint) : void
      {
         _line[_numVertices - 1].degenerate = param1;
         _line[_numVertices - 1].u = 0;
      }
      
      public function lineTo(param1:Number, param2:Number, param3:Number = 1, param4:uint = 16777215, param5:Number = 1) : void
      {
         addVertexInternal(param1,param2,param3,param4,param5,param4,param5);
      }
      
      public function moveTo(param1:Number, param2:Number, param3:Number = 1, param4:uint = 16777215, param5:Number = 1.0) : void
      {
         addDegenerates(param1,param2);
      }
      
      public function modifyVertexPosition(param1:int, param2:Number, param3:Number) : void
      {
         var _loc4_:StrokeVertex = _line[param1];
         _loc4_.x = param2;
         _loc4_.y = param3;
         if(buffersInvalid == false)
         {
            setGeometryInvalid();
         }
      }
      
      public function fromBounds(param1:Rectangle, param2:int = 1) : void
      {
         clear();
         addVertex(param1.x,param1.y,param2);
         addVertex(param1.x + param1.width,param1.y,param2);
         addVertex(param1.x + param1.width,param1.y + param1.height,param2);
         addVertex(param1.x,param1.y + param1.height,param2);
         addVertex(param1.x,param1.y,param2);
      }
      
      public function addVertex(param1:Number, param2:Number, param3:Number = 1, param4:uint = 16777215, param5:Number = 1, param6:uint = 16777215, param7:Number = 1) : void
      {
         addVertexInternal(param1,param2,param3,param4,param5,param6,param7);
      }
      
      protected function addVertexInternal(param1:Number, param2:Number, param3:Number = 1, param4:uint = 16777215, param5:Number = 1, param6:uint = 16777215, param7:Number = 1) : void
      {
         var _loc22_:* = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc13_:* = null;
         var _loc14_:* = 0;
         var _loc12_:Vector.<Texture> = _material.textures;
         if(_loc12_.length > 0 && _numVertices > 0)
         {
            _loc22_ = _line[_numVertices - 1];
            _loc10_ = param1 - _loc22_.x;
            _loc11_ = param2 - _loc22_.y;
            _loc8_ = Math.sqrt(_loc10_ * _loc10_ + _loc11_ * _loc11_);
            _loc14_ = Number(_loc22_.u + _loc8_ / _loc12_[0].width);
         }
         var _loc19_:Number = (param4 >> 16) / 255;
         var _loc18_:Number = ((param4 & 65280) >> 8) / 255;
         var _loc15_:Number = (param4 & 255) / 255;
         var _loc20_:Number = (param6 >> 16) / 255;
         var _loc17_:Number = ((param6 & 65280) >> 8) / 255;
         var _loc16_:Number = (param6 & 255) / 255;
         if(_cullDistanceSquared > 0 && _numVertices > 0)
         {
            _loc21_ = (param1 - _line[_numVertices - 1].x) * (param1 - _line[_numVertices - 1].x);
            _loc23_ = (param2 - _line[_numVertices - 1].y) * (param2 - _line[_numVertices - 1].y);
            if(_loc23_ + _loc21_ < _cullDistanceSquared)
            {
               return;
            }
         }
         if(_isReusingLine)
         {
            _loc13_ = _line[_numVertices];
         }
         else
         {
            _loc13_ = StrokeVertex.getInstance();
            _line[_numVertices] = _loc13_;
         }
         _loc13_.x = param1;
         _loc13_.y = param2;
         _loc13_.r1 = _loc19_;
         _loc13_.g1 = _loc18_;
         _loc13_.b1 = _loc15_;
         _loc13_.a1 = param5;
         _loc13_.r2 = _loc20_;
         _loc13_.g2 = _loc17_;
         _loc13_.b2 = _loc16_;
         _loc13_.a2 = param7;
         _loc13_.u = _loc14_;
         _loc13_.v = 0;
         _loc13_.thickness = param3;
         _loc13_.degenerate = 0;
         if(_numAllocedVertices == _numVertices)
         {
            _numAllocedVertices = Number(_numAllocedVertices) + 1;
         }
         _numVertices = Number(_numVertices) + 1;
         var _loc9_:Number = 0.5 * param3;
         if(param1 - _loc9_ < minBounds.x)
         {
            minBounds.x = param1 - _loc9_;
         }
         else if(param1 + _loc9_ > maxBounds.x)
         {
            maxBounds.x = param1 + _loc9_;
         }
         if(param2 - _loc9_ < minBounds.y)
         {
            minBounds.y = param2 - _loc9_;
         }
         else if(param2 + _loc9_ > maxBounds.y)
         {
            maxBounds.y = param2 + _loc9_;
         }
         if(maxBounds.x == -Infinity)
         {
            maxBounds.x = param1;
         }
         if(maxBounds.y == -Infinity)
         {
            maxBounds.y = param2;
         }
         if(_isReusingLine == false && buffersInvalid == false)
         {
            setGeometryInvalid();
         }
      }
      
      public function getVertexPosition(param1:int, param2:Point = null) : Point
      {
         var _loc3_:* = param2;
         if(_loc3_ == null)
         {
            _loc3_ = new Point();
         }
         _loc3_.x = _line[param1].x;
         _loc3_.y = _line[param1].y;
         return _loc3_;
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
         var _loc3_:int = 0;
         _numVertices = fixUpPolyLine(_line);
         if(_cullDistanceSquared > 0.1)
         {
            _numVertices = cullPolyLineByDistance(_line,_cullDistanceSquared,_indexOfLastRenderedVertex);
            _numAllocedVertices = _numVertices;
         }
         var _loc2_:int = _line.length * 18;
         var _loc1_:int = (_line.length - 1) * 6;
         if(_indexOfLastRenderedVertex == -1)
         {
            if(vertices == null || _loc2_ != vertices.length)
            {
               vertices = new Vector.<Number>(_loc2_,true);
            }
            if(indices == null || _loc1_ != indices.length)
            {
               indices = new Vector.<uint>(_loc1_,true);
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
         var _loc4_:int = 0;
         _loc3_ = _loc3_ + (vertices.length - _loc4_) * 0.111111111111111;
         _indexOfLastRenderedVertex = _line.length - 1;
      }
      
      override protected function shapeHitTestLocalInternal(param1:Number, param2:Number) : Boolean
      {
         var _loc12_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         if(_line == null)
         {
            return false;
         }
         if(_line.length < 2)
         {
            return false;
         }
         var _loc5_:int = _line.length;
         _loc12_ = 1;
         while(_loc12_ < _loc5_)
         {
            _loc4_ = _line[_loc12_ - 1];
            _loc3_ = _line[_loc12_];
            _loc6_ = (_loc3_.x - _loc4_.x) * (_loc3_.x - _loc4_.x) + (_loc3_.y - _loc4_.y) * (_loc3_.y - _loc4_.y);
            _loc10_ = ((param1 - _loc4_.x) * (_loc3_.x - _loc4_.x) + (param2 - _loc4_.y) * (_loc3_.y - _loc4_.y)) / _loc6_;
            if(!(_loc10_ < 0 || _loc10_ > 1))
            {
               _loc9_ = _loc4_.x + _loc10_ * (_loc3_.x - _loc4_.x);
               _loc7_ = _loc4_.y + _loc10_ * (_loc3_.y - _loc4_.y);
               _loc8_ = (param1 - _loc9_) * (param1 - _loc9_) + (param2 - _loc7_) * (param2 - _loc7_);
               _loc11_ = _loc4_.thickness * (1 - _loc10_) + _loc3_.thickness * _loc10_;
               _loc11_ = _loc11_ + _precisionHitTestDistance;
               if(_loc8_ <= _loc11_ * _loc11_)
               {
                  return true;
               }
            }
            _loc12_++;
         }
         return false;
      }
      
      public function localToParent(param1:Point, param2:Point = null) : Point
      {
         return MatrixUtil.transformCoords(transformationMatrix,param1.x,param1.y,param2);
      }
      
      public function scaleGeometry(param1:Number) : void
      {
         if(param1 == _lastScale || param1 <= 0)
         {
            return;
         }
         adjustThicknessOfGeometry(vertices,_lastScale,param1);
         isGeometryScaled = true;
         _lastScale = param1;
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
