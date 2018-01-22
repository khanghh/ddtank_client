package starling.display.graphics
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import starling.display.graphics.util.TriangleUtil;
   
   public class Fill extends Graphic
   {
      
      public static const VERTEX_STRIDE:int = 9;
      
      protected static const EPSILON:Number = 1.0E-7;
       
      
      protected var fillVertices:VertexList;
      
      protected var _numVertices:int;
      
      protected var _isConvex:Boolean = true;
      
      public function Fill()
      {
         super();
         clear();
         _uvMatrix = new Matrix();
         _uvMatrix.scale(0.00390625,0.00390625);
      }
      
      protected static function triangulate(param1:VertexList, param2:int, param3:Vector.<Number>, param4:Vector.<uint>, param5:Boolean) : void
      {
         var _loc8_:* = null;
         var _loc21_:int = 0;
         var _loc15_:Boolean = false;
         var _loc20_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc11_:* = null;
         var _loc10_:* = null;
         var _loc22_:Boolean = false;
         param1 = VertexList.clone(param1);
         var _loc14_:Vector.<VertexList> = null;
         if(param5 == false)
         {
            _loc14_ = convertToSimple(param1);
         }
         else
         {
            _loc14_ = new Vector.<VertexList>();
            _loc14_.push(param1);
         }
         flatten(_loc14_,param3);
         while(_loc14_.length > 0)
         {
            _loc8_ = _loc14_.pop();
            if(isClockWise(_loc8_) == false)
            {
               VertexList.reverse(_loc8_);
            }
            _loc21_ = 0;
            _loc15_ = false;
            _loc20_ = _loc8_.head;
            while(_loc21_ <= param2 * 3)
            {
               _loc21_++;
               _loc7_ = _loc20_.prev;
               _loc6_ = _loc20_;
               _loc9_ = _loc20_.next;
               if(_loc9_.next == _loc7_)
               {
                  param4.push(_loc7_.index,_loc6_.index,_loc9_.index);
                  VertexList.releaseNode(_loc7_);
                  VertexList.releaseNode(_loc6_);
                  VertexList.releaseNode(_loc9_);
                  break;
               }
               _loc12_ = _loc7_.vertex[0];
               _loc13_ = _loc7_.vertex[1];
               _loc19_ = _loc6_.vertex[0];
               _loc17_ = _loc6_.vertex[1];
               _loc16_ = _loc9_.vertex[0];
               _loc18_ = _loc9_.vertex[1];
               if(isReflex(_loc12_,_loc13_,_loc19_,_loc17_,_loc16_,_loc18_) == false)
               {
                  _loc20_ = _loc20_.next;
               }
               else
               {
                  _loc11_ = _loc9_.next;
                  _loc10_ = _loc11_;
                  _loc22_ = false;
                  while(_loc10_ != _loc7_)
                  {
                     if(TriangleUtil.isPointInTriangle(_loc12_,_loc13_,_loc19_,_loc17_,_loc16_,_loc18_,_loc10_.vertex[0],_loc10_.vertex[1]))
                     {
                        _loc22_ = true;
                        break;
                     }
                     _loc10_ = _loc10_.next;
                  }
                  if(_loc22_)
                  {
                     _loc20_ = _loc20_.next;
                  }
                  else
                  {
                     param4.push(_loc7_.index,_loc6_.index,_loc9_.index);
                     if(_loc6_ == _loc6_.head)
                     {
                        _loc6_.vertex = _loc9_.vertex;
                        _loc6_.next = _loc9_.next;
                        _loc6_.index = _loc9_.index;
                        _loc6_.next.prev = _loc6_;
                        VertexList.releaseNode(_loc9_);
                     }
                     else
                     {
                        _loc7_.next = _loc9_;
                        _loc9_.prev = _loc7_;
                        VertexList.releaseNode(_loc6_);
                     }
                     _loc20_ = _loc7_;
                  }
               }
            }
            VertexList.dispose(_loc8_);
         }
      }
      
      protected static function convertToSimple(param1:VertexList) : Vector.<VertexList>
      {
         var _loc3_:* = null;
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc13_:Boolean = false;
         var _loc4_:* = null;
         var _loc5_:* = undefined;
         var _loc9_:* = null;
         var _loc14_:* = null;
         var _loc8_:* = null;
         var _loc10_:* = null;
         var _loc12_:Vector.<VertexList> = new Vector.<VertexList>();
         var _loc2_:int = 0;
         var _loc6_:Vector.<VertexList> = new Vector.<VertexList>();
         _loc6_.push(param1);
         while(_loc6_.length > 0)
         {
            _loc3_ = _loc6_.pop();
            _loc11_ = _loc3_.head;
            _loc7_ = _loc11_;
            _loc13_ = true;
            if(_loc7_.next == _loc7_ || _loc7_.next.next == _loc7_ || _loc7_.next.next.next == _loc7_)
            {
               _loc2_++;
               _loc12_[_loc2_] = _loc11_;
            }
            else
            {
               do
               {
                  _loc4_ = _loc7_.next.next;
                  do
                  {
                     _loc5_ = intersection(_loc7_,_loc7_.next,_loc4_,_loc4_.next);
                     if(_loc5_ != null)
                     {
                        _loc13_ = false;
                        _loc9_ = _loc7_.next;
                        _loc14_ = VertexList.getNode();
                        _loc14_.vertex = _loc5_;
                        _loc14_.prev = _loc7_;
                        _loc14_.next = _loc4_.next;
                        _loc14_.next.prev = _loc14_;
                        _loc14_.head = _loc11_;
                        _loc7_.next = _loc14_;
                        _loc8_ = _loc4_;
                        _loc10_ = VertexList.getNode();
                        _loc10_.vertex = _loc5_;
                        _loc10_.prev = _loc4_;
                        _loc10_.next = _loc9_;
                        _loc10_.next.prev = _loc10_;
                        _loc10_.head = _loc8_;
                        _loc4_.next = _loc10_;
                        do
                        {
                           _loc4_.head = _loc8_;
                           _loc4_ = _loc4_.next;
                        }
                        while(_loc4_ != _loc8_);
                        
                        _loc6_.push(_loc11_,_loc8_);
                        break;
                     }
                     _loc4_ = _loc4_.next;
                  }
                  while(_loc4_ != _loc7_.prev && _loc13_);
                  
                  _loc7_ = _loc7_.next;
               }
               while(_loc7_ != _loc11_ && _loc13_);
               
               if(_loc13_)
               {
                  _loc2_++;
                  _loc12_[_loc2_] = _loc11_;
               }
            }
         }
         return _loc12_;
      }
      
      protected static function flatten(param1:Vector.<VertexList>, param2:Vector.<Number>) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = param1.length;
         var _loc4_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = param1[_loc7_];
            _loc3_ = _loc6_.head;
            do
            {
               _loc4_++;
               _loc3_.index = _loc4_;
               param2.push(_loc3_.vertex[0],_loc3_.vertex[1],_loc3_.vertex[2],_loc3_.vertex[3],_loc3_.vertex[4],_loc3_.vertex[5],_loc3_.vertex[6],_loc3_.vertex[7],_loc3_.vertex[8]);
               _loc3_ = _loc3_.next;
            }
            while(_loc3_ != _loc3_.head);
            
            _loc7_++;
         }
      }
      
      protected static function windingNumberAroundPoint(param1:VertexList, param2:Number, param3:Number) : int
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:* = false;
         var _loc9_:int = 0;
         var _loc5_:VertexList = param1.head;
         do
         {
            _loc6_ = _loc5_.vertex[1];
            _loc7_ = _loc5_.next.vertex[1];
            if(param3 > _loc6_ && param3 < _loc7_ || param3 > _loc7_ && param3 < _loc6_)
            {
               _loc4_ = _loc5_.vertex[0];
               _loc8_ = _loc5_.next.vertex[0];
               _loc10_ = _loc7_ < param3;
               if(_loc10_)
               {
                  _loc9_ = _loc9_ + ((_loc8_ - _loc4_) * (param3 - _loc6_) - (_loc7_ - _loc6_) * (param2 - _loc4_) < 0?1:0);
               }
               else
               {
                  _loc9_ = _loc9_ + ((_loc8_ - _loc4_) * (param3 - _loc6_) - (_loc7_ - _loc6_) * (param2 - _loc4_) < 0?0:-1);
               }
            }
            _loc5_ = _loc5_.next;
         }
         while(_loc5_ != param1.head);
         
         return _loc9_;
      }
      
      public static function isClockWise(param1:VertexList) : Boolean
      {
         var _loc3_:* = 0;
         var _loc2_:VertexList = param1.head;
         do
         {
            _loc3_ = Number(_loc3_ + (_loc2_.next.vertex[0] - _loc2_.vertex[0]) * (_loc2_.next.vertex[1] + _loc2_.vertex[1]));
            _loc2_ = _loc2_.next;
         }
         while(_loc2_ != param1.head);
         
         return _loc3_ <= 0;
      }
      
      protected static function windingNumber(param1:VertexList) : int
      {
         var _loc3_:int = 0;
         var _loc2_:VertexList = param1.head;
         do
         {
            _loc3_ = _loc3_ + ((_loc2_.next.vertex[0] - _loc2_.vertex[0]) * (_loc2_.next.next.vertex[1] - _loc2_.vertex[1]) - (_loc2_.next.next.vertex[0] - _loc2_.vertex[0]) * (_loc2_.next.vertex[1] - _loc2_.vertex[1]) < 0?-1:1);
            _loc2_ = _loc2_.next;
         }
         while(_loc2_ != param1.head);
         
         return _loc3_;
      }
      
      protected static function isReflex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean
      {
         if(TriangleUtil.isLeft(param1,param2,param3,param4,param5,param6))
         {
            return false;
         }
         if(TriangleUtil.isLeft(param3,param4,param5,param6,param1,param2))
         {
            return false;
         }
         return true;
      }
      
      protected static function intersection(param1:VertexList, param2:VertexList, param3:VertexList, param4:VertexList) : Vector.<Number>
      {
         var _loc15_:Number = param2.vertex[0] - param1.vertex[0];
         var _loc12_:Number = param2.vertex[1] - param1.vertex[1];
         var _loc13_:Number = param4.vertex[0] - param3.vertex[0];
         var _loc10_:Number = param4.vertex[1] - param3.vertex[1];
         var _loc11_:Number = param1.vertex[0] - param3.vertex[0];
         var _loc9_:Number = param1.vertex[1] - param3.vertex[1];
         var _loc6_:Number = _loc15_ * _loc10_ - _loc12_ * _loc13_;
         if((_loc6_ < 0?-_loc6_:Number(_loc6_)) < 1.0e-7)
         {
            return null;
         }
         var _loc14_:Number = (_loc13_ * _loc9_ - _loc10_ * _loc11_) / _loc6_;
         if(_loc14_ < 0 || _loc14_ > 1)
         {
            return null;
         }
         var _loc7_:Number = (_loc15_ * _loc9_ - _loc12_ * _loc11_) / _loc6_;
         if(_loc7_ < 0 || _loc7_ > 1)
         {
            return null;
         }
         var _loc5_:Vector.<Number> = param1.vertex;
         var _loc8_:Vector.<Number> = param2.vertex;
         return Vector.<Number>([_loc5_[0] + _loc14_ * (_loc8_[0] - _loc5_[0]),_loc5_[1] + _loc14_ * (_loc8_[1] - _loc5_[1]),0,_loc5_[3] + _loc14_ * (_loc8_[3] - _loc5_[3]),_loc5_[4] + _loc14_ * (_loc8_[4] - _loc5_[4]),_loc5_[5] + _loc14_ * (_loc8_[5] - _loc5_[5]),_loc5_[6] + _loc14_ * (_loc8_[6] - _loc5_[6]),_loc5_[7] + _loc14_ * (_loc8_[7] - _loc5_[7]),_loc5_[8] + _loc14_ * (_loc8_[8] - _loc5_[8])]);
      }
      
      public function get numVertices() : int
      {
         return _numVertices;
      }
      
      public function clear() : void
      {
         indices = new Vector.<uint>();
         vertices = new Vector.<Number>();
         if(minBounds)
         {
            var _loc1_:int = 0;
            minBounds.y = _loc1_;
            minBounds.x = _loc1_;
            _loc1_ = 0;
            maxBounds.y = _loc1_;
            maxBounds.x = _loc1_;
         }
         _numVertices = 0;
         VertexList.dispose(fillVertices);
         fillVertices = null;
         setGeometryInvalid();
         _isConvex = true;
      }
      
      override public function dispose() : void
      {
         clear();
         fillVertices = null;
         super.dispose();
      }
      
      public function addDegenerates(param1:Number, param2:Number, param3:uint = 16777215, param4:Number = 1) : void
      {
         var _loc5_:* = 0;
         if(_numVertices < 1)
         {
            return;
         }
         var _loc9_:Vector.<Number> = fillVertices.prev.vertex;
         _loc5_ = uint(uint(_loc9_[3] * 255) << 16);
         _loc5_ = uint(_loc5_ | uint(_loc9_[4] * 255) << 8);
         _loc5_ = uint(_loc5_ | uint(_loc9_[5] * 255));
         var _loc8_:Number = (param3 >> 16) / 255;
         var _loc6_:Number = ((param3 & 65280) >> 8) / 255;
         var _loc7_:Number = (param3 & 255) / 255;
         addVertex(_loc9_[0],_loc9_[1],_loc5_,_loc9_[6]);
         addVertex(param1,param2,param3,param4);
      }
      
      public function addVertexInConvexShape(param1:Number, param2:Number, param3:uint = 16777215, param4:Number = 1) : void
      {
         addVertexInternal(param1,param2,param3,param4);
      }
      
      public function addVertex(param1:Number, param2:Number, param3:uint = 16777215, param4:Number = 1) : void
      {
         _isConvex = false;
         addVertexInternal(param1,param2,param3,param4);
      }
      
      protected function addVertexInternal(param1:Number, param2:Number, param3:uint = 16777215, param4:Number = 1) : void
      {
         var _loc8_:Number = (param3 >> 16) / 255;
         var _loc5_:Number = ((param3 & 65280) >> 8) / 255;
         var _loc7_:Number = (param3 & 255) / 255;
         var _loc9_:Vector.<Number> = Vector.<Number>([param1,param2,0,_loc8_,_loc5_,_loc7_,param4,param1,param2]);
         var _loc6_:VertexList = VertexList.getNode();
         if(_numVertices == 0)
         {
            fillVertices = _loc6_;
            _loc6_.head = _loc6_;
            _loc6_.prev = _loc6_;
         }
         _loc6_.next = fillVertices.head;
         _loc6_.prev = fillVertices.head.prev;
         _loc6_.prev.next = _loc6_;
         _loc6_.next.prev = _loc6_;
         _loc6_.index = _numVertices;
         _loc6_.vertex = _loc9_;
         if(param1 < minBounds.x)
         {
            minBounds.x = param1;
         }
         else if(param1 > maxBounds.x)
         {
            maxBounds.x = param1;
         }
         if(param2 < minBounds.y)
         {
            minBounds.y = param2;
         }
         else if(param2 > maxBounds.y)
         {
            maxBounds.y = param2;
         }
         _numVertices = Number(_numVertices) + 1;
         setGeometryInvalid();
      }
      
      override protected function buildGeometry() : void
      {
         if(_numVertices < 3)
         {
            return;
         }
         vertices = new Vector.<Number>();
         indices = new Vector.<uint>();
         triangulate(fillVertices,_numVertices,vertices,indices,_isConvex);
      }
      
      override public function shapeHitTest(param1:Number, param2:Number) : Boolean
      {
         if(vertices == null)
         {
            return false;
         }
         if(numVertices < 3)
         {
            return false;
         }
         var _loc4_:Point = globalToLocal(new Point(param1,param2));
         var _loc3_:int = windingNumberAroundPoint(fillVertices,_loc4_.x,_loc4_.y);
         if(isClockWise(fillVertices))
         {
            return _loc3_ != 0;
         }
         return _loc3_ == 0;
      }
      
      override protected function shapeHitTestLocalInternal(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:int = windingNumberAroundPoint(fillVertices,param1,param2);
         if(isClockWise(fillVertices))
         {
            return _loc3_ != 0;
         }
         return _loc3_ == 0;
      }
   }
}
