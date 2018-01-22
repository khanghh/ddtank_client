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
      
      public function Polygon(param1:Array = null)
      {
         super();
         mCoords = new Vector.<Number>(0);
         addVertices.apply(this,param1);
      }
      
      public static function createEllipse(param1:Number, param2:Number, param3:Number, param4:Number) : Polygon
      {
         return new Ellipse(param1,param2,param3,param4);
      }
      
      public static function createCircle(param1:Number, param2:Number, param3:Number) : Polygon
      {
         return new Ellipse(param1,param2,param3,param3);
      }
      
      public static function createRectangle(param1:Number, param2:Number, param3:Number, param4:Number) : Polygon
      {
         return new Rectangle(param1,param2,param3,param4);
      }
      
      [Inline]
      private static function isConvexTriangle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean
      {
         return (param2 - param4) * (param5 - param3) + (param3 - param1) * (param6 - param4) >= 0;
      }
      
      private static function isPointInTriangle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Boolean
      {
         var _loc17_:Number = param7 - param3;
         var _loc18_:Number = param8 - param4;
         var _loc22_:Number = param5 - param3;
         var _loc19_:Number = param6 - param4;
         var _loc20_:Number = param1 - param3;
         var _loc21_:Number = param2 - param4;
         var _loc14_:Number = _loc17_ * _loc17_ + _loc18_ * _loc18_;
         var _loc10_:Number = _loc17_ * _loc22_ + _loc18_ * _loc19_;
         var _loc12_:Number = _loc17_ * _loc20_ + _loc18_ * _loc21_;
         var _loc11_:Number = _loc22_ * _loc22_ + _loc19_ * _loc19_;
         var _loc13_:Number = _loc22_ * _loc20_ + _loc19_ * _loc21_;
         var _loc9_:Number = 1 / (_loc14_ * _loc11_ - _loc10_ * _loc10_);
         var _loc16_:Number = (_loc11_ * _loc12_ - _loc10_ * _loc13_) * _loc9_;
         var _loc15_:Number = (_loc14_ * _loc13_ - _loc10_ * _loc12_) * _loc9_;
         return _loc16_ >= 0 && _loc15_ >= 0 && _loc16_ + _loc15_ < 1;
      }
      
      private static function areVectorsIntersecting(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Boolean
      {
         if(param1 == param3 && param2 == param4 || param5 == param7 && param6 == param8)
         {
            return false;
         }
         var _loc13_:Number = param3 - param1;
         var _loc15_:Number = param4 - param2;
         var _loc10_:Number = param7 - param5;
         var _loc9_:Number = param8 - param6;
         var _loc14_:Number = _loc9_ * _loc13_ - _loc10_ * _loc15_;
         if(_loc14_ == 0)
         {
            return false;
         }
         var _loc11_:Number = (_loc15_ * (param5 - param1) - _loc13_ * (param6 - param2)) / _loc14_;
         if(_loc11_ < 0 || _loc11_ > 1)
         {
            return false;
         }
         var _loc12_:Number = !!_loc15_?(param6 - param2 + _loc11_ * _loc9_) / _loc15_:Number((param5 - param1 + _loc11_ * _loc10_) / _loc13_);
         return _loc12_ >= 0 && _loc12_ <= 1;
      }
      
      public function clone() : Polygon
      {
         var _loc3_:int = 0;
         var _loc1_:Polygon = new Polygon();
         var _loc2_:int = mCoords.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.mCoords[_loc3_] = mCoords[_loc3_];
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function reverse() : void
      {
         var _loc1_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:int = mCoords.length;
         var _loc3_:int = _loc2_ / 2;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = mCoords[_loc4_];
            mCoords[_loc4_] = mCoords[_loc2_ - _loc4_ - 2];
            mCoords[_loc2_ - _loc4_ - 2] = _loc1_;
            _loc1_ = mCoords[_loc4_ + 1];
            mCoords[_loc4_ + 1] = mCoords[_loc2_ - _loc4_ - 1];
            mCoords[_loc2_ - _loc4_ - 1] = _loc1_;
            _loc4_ = _loc4_ + 2;
         }
      }
      
      public function addVertices(... rest) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = rest.length;
         var _loc2_:int = mCoords.length;
         if(_loc3_ > 0)
         {
            if(rest[0] is Point)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  mCoords[_loc2_ + _loc4_ * 2] = (rest[_loc4_] as Point).x;
                  mCoords[_loc2_ + _loc4_ * 2 + 1] = (rest[_loc4_] as Point).y;
                  _loc4_++;
               }
            }
            else if(rest[0] is Number)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  mCoords[_loc2_ + _loc4_] = rest[_loc4_];
                  _loc4_++;
               }
            }
            else
            {
               throw new ArgumentError("Invalid type: " + getQualifiedClassName(rest[0]));
            }
         }
      }
      
      public function setVertex(param1:int, param2:Number, param3:Number) : void
      {
         if(param1 >= 0 && param1 <= numVertices)
         {
            mCoords[param1 * 2] = param2;
            mCoords[param1 * 2 + 1] = param3;
            return;
         }
         throw new RangeError("Invalid index: " + param1);
      }
      
      public function getVertex(param1:int, param2:Point = null) : Point
      {
         if(param1 >= 0 && param1 < numVertices)
         {
            if(!param2)
            {
               param2 = new Point();
            }
            param2.setTo(mCoords[param1 * 2],mCoords[param1 * 2 + 1]);
            return param2;
         }
         throw new RangeError("Invalid index: " + param1);
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         var _loc9_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:* = int(numVertices - 1);
         var _loc7_:uint = 0;
         _loc9_ = 0;
         while(_loc9_ < numVertices)
         {
            _loc5_ = mCoords[_loc9_ * 2];
            _loc6_ = mCoords[_loc9_ * 2 + 1];
            _loc3_ = mCoords[_loc8_ * 2];
            _loc4_ = mCoords[_loc8_ * 2 + 1];
            if((_loc6_ < param2 && _loc4_ >= param2 || _loc4_ < param2 && _loc6_ >= param2) && (_loc5_ <= param1 || _loc3_ <= param1))
            {
               _loc7_ = _loc7_ ^ uint(_loc5_ + (param2 - _loc6_) / (_loc4_ - _loc6_) * (_loc3_ - _loc5_) < param1);
            }
            _loc8_ = _loc9_;
            _loc9_++;
         }
         return _loc7_ != 0;
      }
      
      public function containsPoint(param1:Point) : Boolean
      {
         return contains(param1.x,param1.y);
      }
      
      public function triangulate(param1:Vector.<uint> = null) : Vector.<uint>
      {
         var _loc12_:int = 0;
         var _loc4_:* = 0;
         var _loc2_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = 0;
         var _loc17_:* = 0;
         var _loc16_:* = 0;
         var _loc9_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc15_:* = 0;
         if(param1 == null)
         {
            param1 = new Vector.<uint>(0);
         }
         var _loc10_:int = this.numVertices;
         if(_loc10_ < 3)
         {
            return param1;
         }
         sRestIndices.length = _loc10_;
         _loc13_ = 0;
         while(_loc13_ < _loc10_)
         {
            sRestIndices[_loc13_] = _loc13_;
            _loc13_++;
         }
         _loc12_ = 0;
         _loc2_ = param1.length;
         _loc4_ = _loc10_;
         while(_loc4_ > 3)
         {
            _loc14_ = uint(sRestIndices[_loc12_ % _loc4_]);
            _loc17_ = uint(sRestIndices[(_loc12_ + 1) % _loc4_]);
            _loc16_ = uint(sRestIndices[(_loc12_ + 2) % _loc4_]);
            _loc9_ = mCoords[2 * _loc14_];
            _loc3_ = mCoords[2 * _loc14_ + 1];
            _loc8_ = mCoords[2 * _loc17_];
            _loc7_ = mCoords[2 * _loc17_ + 1];
            _loc6_ = mCoords[2 * _loc16_];
            _loc5_ = mCoords[2 * _loc16_ + 1];
            _loc11_ = false;
            if(isConvexTriangle(_loc9_,_loc3_,_loc8_,_loc7_,_loc6_,_loc5_))
            {
               _loc11_ = true;
               _loc13_ = 3;
               while(_loc13_ < _loc4_)
               {
                  _loc15_ = uint(sRestIndices[(_loc12_ + _loc13_) % _loc4_]);
                  if(isPointInTriangle(mCoords[2 * _loc15_],mCoords[2 * _loc15_ + 1],_loc9_,_loc3_,_loc8_,_loc7_,_loc6_,_loc5_))
                  {
                     _loc11_ = false;
                     break;
                  }
                  _loc13_++;
               }
            }
            if(_loc11_)
            {
               _loc2_++;
               param1[_loc2_] = _loc14_;
               _loc2_++;
               param1[_loc2_] = _loc17_;
               _loc2_++;
               param1[_loc2_] = _loc16_;
               VectorUtil.removeUnsignedIntAt(sRestIndices,(_loc12_ + 1) % _loc4_);
               _loc4_--;
               _loc12_ = 0;
               continue;
            }
            _loc12_++;
            if(_loc12_ != _loc4_)
            {
               continue;
            }
            break;
         }
         _loc2_++;
         param1[_loc2_] = sRestIndices[0];
         _loc2_++;
         param1[_loc2_] = sRestIndices[1];
         param1[_loc2_] = sRestIndices[2];
         return param1;
      }
      
      public function copyToVertexData(param1:VertexData, param2:int = 0) : void
      {
         var _loc3_:int = param2 + numVertices;
         if(param1.numVertices < _loc3_)
         {
            param1.numVertices = _loc3_;
         }
         copyToVector(param1.rawData,param2 * 8,8 - 2);
      }
      
      public function copyToVector(param1:Vector.<Number>, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = this.numVertices;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            param2++;
            param1[param2] = mCoords[_loc5_ * 2];
            param2++;
            param1[param2] = mCoords[_loc5_ * 2 + 1];
            param2 = param2 + param3;
            _loc5_++;
         }
      }
      
      public function toString() : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "[Polygon \n";
         var _loc1_:int = this.numVertices;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = _loc2_ + ("  [Vertex " + _loc3_ + ": " + "x=" + mCoords[_loc3_ * 2].toFixed(1) + ", " + "y=" + mCoords[_loc3_ * 2 + 1].toFixed(1) + "]" + (_loc3_ == _loc1_ - 1?"\n":",\n"));
            _loc3_++;
         }
         return _loc2_ + "]";
      }
      
      public function get isSimple() : Boolean
      {
         var _loc12_:int = 0;
         var _loc10_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc9_:int = 0;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc11_:int = mCoords.length;
         if(_loc11_ <= 6)
         {
            return true;
         }
         _loc12_ = 0;
         while(_loc12_ < _loc11_)
         {
            _loc10_ = mCoords[_loc12_];
            _loc1_ = mCoords[_loc12_ + 1];
            _loc8_ = mCoords[(_loc12_ + 2) % _loc11_];
            _loc7_ = mCoords[(_loc12_ + 3) % _loc11_];
            _loc4_ = _loc12_ + _loc11_ - 2;
            _loc9_ = _loc12_ + 4;
            while(_loc9_ < _loc4_)
            {
               _loc6_ = mCoords[_loc9_ % _loc11_];
               _loc5_ = mCoords[(_loc9_ + 1) % _loc11_];
               _loc2_ = mCoords[(_loc9_ + 2) % _loc11_];
               _loc3_ = mCoords[(_loc9_ + 3) % _loc11_];
               if(areVectorsIntersecting(_loc10_,_loc1_,_loc8_,_loc7_,_loc6_,_loc5_,_loc2_,_loc3_))
               {
                  return false;
               }
               _loc9_ = _loc9_ + 2;
            }
            _loc12_ = _loc12_ + 2;
         }
         return true;
      }
      
      public function get isConvex() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = mCoords.length;
         if(_loc1_ < 6)
         {
            return true;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(!isConvexTriangle(mCoords[_loc2_],mCoords[_loc2_ + 1],mCoords[(_loc2_ + 2) % _loc1_],mCoords[(_loc2_ + 3) % _loc1_],mCoords[(_loc2_ + 4) % _loc1_],mCoords[(_loc2_ + 5) % _loc1_]))
            {
               return false;
            }
            _loc2_ = _loc2_ + 2;
         }
         return true;
      }
      
      public function get area() : Number
      {
         var _loc3_:int = 0;
         var _loc1_:* = 0;
         var _loc2_:int = mCoords.length;
         if(_loc2_ >= 6)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = Number(_loc1_ + mCoords[_loc3_] * mCoords[(_loc3_ + 3) % _loc2_]);
               _loc1_ = Number(_loc1_ - mCoords[_loc3_ + 1] * mCoords[(_loc3_ + 2) % _loc2_]);
               _loc3_ = _loc3_ + 2;
            }
         }
         return _loc1_ / 2;
      }
      
      public function get numVertices() : int
      {
         return mCoords.length / 2;
      }
      
      public function set numVertices(param1:int) : void
      {
         var _loc3_:* = 0;
         var _loc2_:int = numVertices;
         mCoords.length = param1 * 2;
         if(_loc2_ < param1)
         {
            _loc3_ = _loc2_;
            while(_loc3_ < param1)
            {
               var _loc4_:int = 0;
               mCoords[_loc3_ * 2 + 1] = _loc4_;
               mCoords[_loc3_ * 2] = _loc4_;
               _loc3_++;
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
   
   function ImmutablePolygon(param1:Array)
   {
      super(param1);
      mFrozen = true;
   }
   
   override public function addVertices(... rest) : void
   {
      if(mFrozen)
      {
         throw getImmutableError();
      }
      super.addVertices.apply(this,rest);
   }
   
   override public function setVertex(param1:int, param2:Number, param3:Number) : void
   {
      if(mFrozen)
      {
         throw getImmutableError();
      }
      super.setVertex(param1,param2,param3);
   }
   
   override public function reverse() : void
   {
      if(mFrozen)
      {
         throw getImmutableError();
      }
      super.reverse();
   }
   
   override public function set numVertices(param1:int) : void
   {
      if(mFrozen)
      {
         throw getImmutableError();
      }
      super.reverse();
   }
   
   private function getImmutableError() : Error
   {
      var _loc1_:String = getQualifiedClassName(this).split("::").pop();
      var _loc2_:String = _loc1_ + " cannot be modified. Call \'clone\' to create a mutable copy.";
      return new IllegalOperationError(_loc2_);
   }
}

class Ellipse extends ImmutablePolygon
{
    
   
   private var mX:Number;
   
   private var mY:Number;
   
   private var mRadiusX:Number;
   
   private var mRadiusY:Number;
   
   function Ellipse(param1:Number, param2:Number, param3:Number, param4:Number, param5:int = -1)
   {
      mX = param1;
      mY = param2;
      mRadiusX = param3;
      mRadiusY = param4;
      super(getVertices(param5));
   }
   
   private function getVertices(param1:int) : Array
   {
      var _loc5_:int = 0;
      if(param1 < 0)
      {
         param1 = 3.14159265358979 * (mRadiusX + mRadiusY) / 4;
      }
      if(param1 < 6)
      {
         param1 = 6;
      }
      var _loc3_:Array = [];
      var _loc2_:Number = 2 * 3.14159265358979 / param1;
      var _loc4_:* = 0;
      _loc5_ = 0;
      while(_loc5_ < param1)
      {
         _loc3_[_loc5_ * 2] = Math.cos(_loc4_) * mRadiusX + mX;
         _loc3_[_loc5_ * 2 + 1] = Math.sin(_loc4_) * mRadiusY + mY;
         _loc4_ = Number(_loc4_ + _loc2_);
         _loc5_++;
      }
      return _loc3_;
   }
   
   override public function triangulate(param1:Vector.<uint> = null) : Vector.<uint>
   {
      var _loc4_:int = 0;
      if(param1 == null)
      {
         param1 = new Vector.<uint>(0);
      }
      var _loc3_:uint = 1;
      var _loc2_:uint = numVertices - 1;
      var _loc5_:uint = param1.length;
      _loc4_ = _loc3_;
      while(_loc4_ < _loc2_)
      {
         param1[_loc5_++] = 0;
         param1[_loc5_++] = _loc4_;
         param1[_loc5_++] = _loc4_ + 1;
         _loc4_++;
      }
      return param1;
   }
   
   override public function contains(param1:Number, param2:Number) : Boolean
   {
      var _loc4_:Number = param1 - mX;
      var _loc3_:Number = param2 - mY;
      var _loc6_:Number = _loc4_ / mRadiusX;
      var _loc5_:Number = _loc3_ / mRadiusY;
      return _loc6_ * _loc6_ + _loc5_ * _loc5_ <= 1;
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
   
   function Rectangle(param1:Number, param2:Number, param3:Number, param4:Number)
   {
      mX = param1;
      mY = param2;
      mWidth = param3;
      mHeight = param4;
      super([param1,param2,param1 + param3,param2,param1 + param3,param2 + param4,param1,param2 + param4]);
   }
   
   override public function triangulate(param1:Vector.<uint> = null) : Vector.<uint>
   {
      if(param1 == null)
      {
         param1 = new Vector.<uint>(0);
      }
      param1.push(0,1,3,1,2,3);
      return param1;
   }
   
   override public function contains(param1:Number, param2:Number) : Boolean
   {
      return param1 >= mX && param1 <= mX + mWidth && param2 >= mY && param2 <= mY + mHeight;
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
