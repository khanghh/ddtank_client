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
      
      public function RoundedRectangle(param1:Number = 100, param2:Number = 100, param3:Number = 10, param4:Number = 10, param5:Number = 10, param6:Number = 10)
      {
         super();
         this.width = param1;
         this.height = param2;
         this.topLeftRadius = param3;
         this.topRightRadius = param4;
         this.bottomLeftRadius = param5;
         this.bottomRightRadius = param6;
      }
      
      override public function set width(param1:Number) : void
      {
         param1 = param1 < 0?0:Number(param1);
         _width = param1;
         maxBounds.x = _width;
         setGeometryInvalid();
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      override public function set height(param1:Number) : void
      {
         param1 = param1 < 0?0:Number(param1);
         _height = param1;
         maxBounds.y = _height;
         setGeometryInvalid();
      }
      
      public function get cornerRadius() : Number
      {
         return _topLeftRadius;
      }
      
      public function set cornerRadius(param1:Number) : void
      {
         param1 = param1 < 0?0:Number(param1);
         _bottomRightRadius = param1;
         _bottomLeftRadius = param1;
         _topRightRadius = param1;
         _topLeftRadius = param1;
         setGeometryInvalid();
      }
      
      public function get topLeftRadius() : Number
      {
         return _topLeftRadius;
      }
      
      public function set topLeftRadius(param1:Number) : void
      {
         param1 = param1 < 0?0:Number(param1);
         _topLeftRadius = param1;
         setGeometryInvalid();
      }
      
      public function get topRightRadius() : Number
      {
         return _topRightRadius;
      }
      
      public function set topRightRadius(param1:Number) : void
      {
         param1 = param1 < 0?0:Number(param1);
         _topRightRadius = param1;
         setGeometryInvalid();
      }
      
      public function get bottomLeftRadius() : Number
      {
         return _bottomLeftRadius;
      }
      
      public function set bottomLeftRadius(param1:Number) : void
      {
         param1 = param1 < 0?0:Number(param1);
         _bottomLeftRadius = param1;
         setGeometryInvalid();
      }
      
      public function get bottomRightRadius() : Number
      {
         return _bottomRightRadius;
      }
      
      public function set bottomRightRadius(param1:Number) : void
      {
         param1 = param1 < 0?0:Number(param1);
         _bottomRightRadius = param1;
         setGeometryInvalid();
      }
      
      public function getStrokePoints() : Vector.<Number>
      {
         validateNow();
         return strokePoints;
      }
      
      override protected function buildGeometry() : void
      {
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc13_:Number = NaN;
         strokePoints = new Vector.<Number>();
         vertices = new Vector.<Number>();
         indices = new Vector.<uint>();
         var _loc12_:Number = _width * 0.5;
         var _loc11_:Number = _height * 0.5;
         var _loc3_:Number = Math.min(_loc12_,_loc11_,_topLeftRadius);
         var _loc7_:Number = Math.min(_loc12_,_loc11_,_topRightRadius);
         var _loc8_:Number = Math.min(_loc12_,_loc11_,_bottomLeftRadius);
         var _loc4_:Number = Math.min(_loc12_,_loc11_,_bottomRightRadius);
         vertices.push(_loc3_,0,0,1,1,1,1,_loc3_ / _width,0);
         vertices.push(_loc3_,_loc3_,0,1,1,1,1,_loc3_ / _width,_loc3_ / _height);
         vertices.push(0,_loc3_,0,1,1,1,1,0,_loc3_ / _height);
         vertices.push(_width - _loc7_,0,0,1,1,1,1,(_width - _loc7_) / _width,0);
         vertices.push(_width - _loc7_,_loc7_,0,1,1,1,1,(_width - _loc7_) / _width,_loc7_ / _height);
         vertices.push(_width,_loc7_,0,1,1,1,1,1,_loc7_ / _height);
         vertices.push(_loc8_,_height,0,1,1,1,1,_loc8_ / _width,1);
         vertices.push(_loc8_,_height - _loc8_,0,1,1,1,1,_loc8_ / _width,(_height - _loc8_) / _height);
         vertices.push(0,_height - _loc8_,0,1,1,1,1,0,(_height - _loc8_) / _height);
         vertices.push(_width - _loc4_,_height,0,1,1,1,1,(_width - _loc4_) / _width,1);
         vertices.push(_width - _loc4_,_height - _loc4_,0,1,1,1,1,(_width - _loc4_) / _width,(_height - _loc4_) / _height);
         vertices.push(_width,_height - _loc4_,0,1,1,1,1,1,(_height - _loc4_) / _height);
         var _loc5_:int = 12;
         indices.push(0,3,1,1,3,4,2,1,8,8,1,7,7,1,4,7,4,10,10,4,5,10,5,11,6,7,10,6,10,9);
         strokePoints.push(0,_loc3_);
         if(_loc3_ > 0)
         {
            _loc9_ = _loc3_ * 0.25;
            _loc9_ = _loc9_ < 1?1:_loc9_;
            _loc6_ = 0;
            while(_loc6_ < _loc9_)
            {
               _loc1_ = (_loc6_ + 1) / (_loc9_ + 1) * 3.14159265358979 * 0.5;
               _loc1_ = _loc1_ + 3.14159265358979 * 1.5;
               _loc10_ = Math.sin(_loc1_);
               _loc2_ = Math.cos(_loc1_);
               _loc14_ = _loc3_ + _loc10_ * _loc3_;
               _loc13_ = _loc3_ - _loc2_ * _loc3_;
               vertices.push(_loc14_,_loc13_,0,1,1,1,1,_loc14_ / _width,_loc13_ / _height);
               strokePoints.push(_loc14_,_loc13_);
               _loc5_++;
               if(_loc6_ == 0)
               {
                  indices.push(1,2,_loc5_ - 1);
               }
               else
               {
                  indices.push(1,_loc5_ - 2,_loc5_ - 1);
               }
               if(_loc6_ == _loc9_ - 1)
               {
                  indices.push(1,_loc5_ - 1,0);
               }
               _loc6_++;
            }
         }
         strokePoints.push(_loc3_,0);
         strokePoints.push(_width - _loc7_,0);
         if(_loc7_ > 0)
         {
            _loc9_ = _loc7_ * 0.25;
            _loc9_ = _loc9_ < 1?1:_loc9_;
            _loc6_ = 0;
            while(_loc6_ < _loc9_)
            {
               _loc1_ = (_loc6_ + 1) / (_loc9_ + 1) * 3.14159265358979 * 0.5;
               _loc10_ = Math.sin(_loc1_);
               _loc2_ = Math.cos(_loc1_);
               _loc14_ = _width - _loc7_ + _loc10_ * _loc7_;
               _loc13_ = _loc7_ - _loc2_ * _loc7_;
               vertices.push(_loc14_,_loc13_,0,1,1,1,1,_loc14_ / _width,_loc13_ / _height);
               strokePoints.push(_loc14_,_loc13_);
               _loc5_++;
               if(_loc6_ == 0)
               {
                  indices.push(4,3,_loc5_ - 1);
               }
               else
               {
                  indices.push(4,_loc5_ - 2,_loc5_ - 1);
               }
               if(_loc6_ == _loc9_ - 1)
               {
                  indices.push(4,_loc5_ - 1,5);
               }
               _loc6_++;
            }
         }
         strokePoints.push(_width,_loc7_);
         strokePoints.push(_width,_height - _loc4_);
         if(_loc4_ > 0)
         {
            _loc9_ = _loc4_ * 0.25;
            _loc9_ = _loc9_ < 1?1:_loc9_;
            _loc6_ = 0;
            while(_loc6_ < _loc9_)
            {
               _loc1_ = (_loc6_ + 1) / (_loc9_ + 1) * 3.14159265358979 * 0.5;
               _loc1_ = _loc1_ + 3.14159265358979 * 0.5;
               _loc10_ = Math.sin(_loc1_);
               _loc2_ = Math.cos(_loc1_);
               _loc14_ = _width - _loc4_ + _loc10_ * _loc4_;
               _loc13_ = _height - _loc4_ - _loc2_ * _loc4_;
               vertices.push(_loc14_,_loc13_,0,1,1,1,1,_loc14_ / _width,_loc13_ / _height);
               strokePoints.push(_loc14_,_loc13_);
               _loc5_++;
               if(_loc6_ == 0)
               {
                  indices.push(10,11,_loc5_ - 1);
               }
               else
               {
                  indices.push(10,_loc5_ - 2,_loc5_ - 1);
               }
               if(_loc6_ == _loc9_ - 1)
               {
                  indices.push(10,_loc5_ - 1,9);
               }
               _loc6_++;
            }
         }
         strokePoints.push(_width - _loc4_,_height);
         strokePoints.push(_loc8_,_height);
         if(_loc8_ > 0)
         {
            _loc9_ = _loc8_ * 0.25;
            _loc9_ = _loc9_ < 1?1:_loc9_;
            _loc6_ = 0;
            while(_loc6_ < _loc9_)
            {
               _loc1_ = (_loc6_ + 1) / (_loc9_ + 1) * 3.14159265358979 * 0.5;
               _loc1_ = _loc1_ + 3.14159265358979;
               _loc10_ = Math.sin(_loc1_);
               _loc2_ = Math.cos(_loc1_);
               _loc14_ = _loc8_ + _loc10_ * _loc8_;
               _loc13_ = _height - _loc8_ - _loc2_ * _loc8_;
               vertices.push(_loc14_,_loc13_,0,1,1,1,1,_loc14_ / _width,_loc13_ / _height);
               strokePoints.push(_loc14_,_loc13_);
               _loc5_++;
               if(_loc6_ == 0)
               {
                  indices.push(7,6,_loc5_ - 1);
               }
               else
               {
                  indices.push(7,_loc5_ - 2,_loc5_ - 1);
               }
               if(_loc6_ == _loc9_ - 1)
               {
                  indices.push(7,_loc5_ - 1,8);
               }
               _loc6_++;
            }
         }
         strokePoints.push(0,_height - _loc8_);
         strokePoints.push(0,_loc3_);
      }
   }
}
