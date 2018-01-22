package starlingPhy.object
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import phy.object.SmallObject;
   import road7th.utils.MathUtils;
   import starling.display.Sprite;
   
   public class PhysicalObj3D extends Physics3D
   {
       
      
      protected var _id:int;
      
      protected var _testRect:Rectangle;
      
      protected var _canCollided:Boolean;
      
      protected var _isLiving:Boolean;
      
      protected var _layerType:int;
      
      protected var _smallBox:SmallObject;
      
      private var _drawPointContainer:Sprite;
      
      public function PhysicalObj3D(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1)
      {
         super(param3,param4,param5,param6);
         _id = param1;
         _layerType = param2;
         _canCollided = false;
         _testRect = new Rectangle(-5,-5,10,10);
         _isLiving = true;
      }
      
      public function get Id() : int
      {
         return _id;
      }
      
      public function get layerType() : int
      {
         return _layerType;
      }
      
      public function setCollideRect(param1:int, param2:int, param3:int, param4:int) : void
      {
         _testRect.top = param2;
         _testRect.left = param1;
         _testRect.right = param3;
         _testRect.bottom = param4;
      }
      
      public function getCollideRect() : Rectangle
      {
         return _testRect.clone();
      }
      
      public function get canCollided() : Boolean
      {
         return _canCollided;
      }
      
      public function set canCollided(param1:Boolean) : void
      {
         _canCollided = param1;
      }
      
      public function get smallView() : SmallObject
      {
         return _smallBox;
      }
      
      public function get isLiving() : Boolean
      {
         return _isLiving;
      }
      
      override public function moveTo(param1:Point) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:int = 0;
         var _loc2_:Number = NaN;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc10_:* = null;
         var _loc9_:* = null;
         if(Point.distance(param1,pos) >= 3)
         {
            _loc6_ = Math.abs(int(param1.x) - int(x));
            _loc7_ = Math.abs(int(param1.y) - int(y));
            _loc5_ = _loc6_ > _loc7_?_loc6_:Number(_loc7_);
            _loc2_ = 1 / _loc5_;
            _loc8_ = pos;
            _loc3_ = Math.abs(_loc5_);
            while(_loc3_ > 0)
            {
               _loc4_ = Point.interpolate(_loc8_,param1,_loc2_ * _loc3_);
               _loc10_ = getCollideRect();
               _loc10_.offset(_loc4_.x,_loc4_.y);
               _loc9_ = _map.getPhysicalObjects(_loc10_,this);
               if(_loc9_.length > 0)
               {
                  pos = _loc4_;
                  collideObject(_loc9_);
               }
               else if(!_map.IsRectangleEmpty(_loc10_))
               {
                  pos = _loc4_;
                  collideGround();
               }
               else if(_map.IsOutMap(_loc4_.x,_loc4_.y))
               {
                  pos = _loc4_;
                  flyOutMap();
               }
               if(!_isMoving)
               {
                  return;
               }
               _loc3_ = _loc3_ - 3;
            }
            pos = param1;
         }
      }
      
      public function calcObjectAngle(param1:Number = 16) : Number
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = NaN;
         var _loc8_:* = NaN;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:* = NaN;
         var _loc5_:* = NaN;
         if(_map)
         {
            _loc2_ = [];
            _loc3_ = [];
            _loc4_ = new Point();
            _loc6_ = new Point();
            _loc10_ = param1;
            _loc8_ = 1;
            while(_loc8_ <= _loc10_)
            {
               _loc11_ = -10;
               while(_loc11_ <= 10)
               {
                  if(_map.IsEmpty(x + _loc8_,y - _loc11_))
                  {
                     if(_loc11_ != -10)
                     {
                        _loc2_.push(new Point(x + _loc8_,y - _loc11_));
                        break;
                     }
                     break;
                  }
                  _loc11_++;
               }
               _loc9_ = -10;
               while(_loc9_ <= 10)
               {
                  if(_map.IsEmpty(x - _loc8_,y - _loc9_))
                  {
                     if(_loc9_ != -10)
                     {
                        _loc3_.push(new Point(x - _loc8_,y - _loc9_));
                        break;
                     }
                     break;
                  }
                  _loc9_++;
               }
               _loc8_ = Number(_loc8_ + 2);
            }
            _loc4_ = new Point(x,y);
            _loc6_ = new Point(x,y);
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               _loc4_ = _loc4_.add(_loc2_[_loc7_]);
               _loc7_++;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc6_ = _loc6_.add(_loc3_[_loc5_]);
               _loc5_++;
            }
            _loc4_.x = _loc4_.x / (_loc2_.length + 1);
            _loc4_.y = _loc4_.y / (_loc2_.length + 1);
            _loc6_.x = _loc6_.x / (_loc3_.length + 1);
            _loc6_.y = _loc6_.y / (_loc3_.length + 1);
            return MathUtils.GetAngleTwoPoint(_loc4_,_loc6_);
         }
         return 0;
      }
      
      public function calcObjectAngle2(param1:Number = 16, param2:int = 10) : Number
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc11_:* = NaN;
         var _loc9_:* = NaN;
         var _loc12_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:* = NaN;
         var _loc6_:* = NaN;
         if(_map)
         {
            _loc3_ = [];
            _loc4_ = [];
            _loc5_ = new Point();
            _loc7_ = new Point();
            _loc11_ = param1;
            _loc9_ = 1;
            while(_loc9_ <= _loc11_)
            {
               _loc12_ = -param2;
               while(_loc12_ <= param2)
               {
                  if(_map.IsEmpty(x + _loc9_,y - _loc12_))
                  {
                     if(_loc12_ != -param2)
                     {
                        _loc3_.push(new Point(x + _loc9_,y - _loc12_));
                        break;
                     }
                     break;
                  }
                  _loc12_++;
               }
               _loc10_ = -param2;
               while(_loc10_ <= param2)
               {
                  if(_map.IsEmpty(x - _loc9_,y - _loc10_))
                  {
                     if(_loc10_ != -param2)
                     {
                        _loc4_.push(new Point(x - _loc9_,y - _loc10_));
                        break;
                     }
                     break;
                  }
                  _loc10_++;
               }
               _loc9_ = Number(_loc9_ + 2);
            }
            _loc5_ = new Point(x,y);
            _loc7_ = new Point(x,y);
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc5_ = _loc5_.add(_loc3_[_loc8_]);
               _loc8_++;
            }
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc7_ = _loc7_.add(_loc4_[_loc6_]);
               _loc6_++;
            }
            _loc5_.x = _loc5_.x / (_loc3_.length + 1);
            _loc5_.y = _loc5_.y / (_loc3_.length + 1);
            _loc7_.x = _loc7_.x / (_loc4_.length + 1);
            _loc7_.y = _loc7_.y / (_loc4_.length + 1);
            return MathUtils.GetAngleTwoPoint(_loc5_,_loc7_);
         }
         return 0;
      }
      
      public function calcObjectAngleDebug(param1:Number = 16) : Number
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = NaN;
         var _loc8_:* = NaN;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:* = NaN;
         var _loc5_:* = NaN;
         if(_map)
         {
            _loc2_ = [];
            _loc3_ = [];
            _loc4_ = new Point();
            _loc6_ = new Point();
            _loc10_ = param1;
            _loc8_ = 1;
            while(_loc8_ <= _loc10_)
            {
               _loc11_ = -10;
               while(_loc11_ <= 10)
               {
                  if(_map.IsEmpty(x + _loc8_,y - _loc11_))
                  {
                     if(_loc11_ != -10)
                     {
                        _loc2_.push(new Point(x + _loc8_,y - _loc11_));
                        break;
                     }
                     break;
                  }
                  _loc11_++;
               }
               _loc9_ = -10;
               while(_loc9_ <= 10)
               {
                  if(_map.IsEmpty(x - _loc8_,y - _loc9_))
                  {
                     if(_loc9_ != -10)
                     {
                        _loc3_.push(new Point(x - _loc8_,y - _loc9_));
                        break;
                     }
                     break;
                  }
                  _loc9_++;
               }
               _loc8_ = Number(_loc8_ + 2);
            }
            _loc4_ = new Point(x,y);
            _loc6_ = new Point(x,y);
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               _loc4_ = _loc4_.add(_loc2_[_loc7_]);
               _loc7_++;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc6_ = _loc6_.add(_loc3_[_loc5_]);
               _loc5_++;
            }
            _loc4_.x = _loc4_.x / (_loc2_.length + 1);
            _loc4_.y = _loc4_.y / (_loc2_.length + 1);
            _loc6_.x = _loc6_.x / (_loc3_.length + 1);
            _loc6_.y = _loc6_.y / (_loc3_.length + 1);
            return MathUtils.GetAngleTwoPoint(_loc4_,_loc6_);
         }
         return 0;
      }
      
      public function calcObjectAngleDebug2(param1:Number = 16, param2:int = 10) : Number
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc11_:* = NaN;
         var _loc9_:* = NaN;
         var _loc12_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:* = NaN;
         var _loc6_:* = NaN;
         if(_map)
         {
            _loc3_ = [];
            _loc4_ = [];
            _loc5_ = new Point();
            _loc7_ = new Point();
            _loc11_ = param1;
            _loc9_ = 1;
            while(_loc9_ <= _loc11_)
            {
               _loc12_ = -param2;
               while(_loc12_ <= param2)
               {
                  if(_map.IsEmpty(x + _loc9_,y - _loc12_))
                  {
                     if(_loc12_ != -param2)
                     {
                        _loc3_.push(new Point(x + _loc9_,y - _loc12_));
                        break;
                     }
                     break;
                  }
                  _loc12_++;
               }
               _loc10_ = -param2;
               while(_loc10_ <= param2)
               {
                  if(_map.IsEmpty(x - _loc9_,y - _loc10_))
                  {
                     if(_loc10_ != -param2)
                     {
                        _loc4_.push(new Point(x - _loc9_,y - _loc10_));
                        break;
                     }
                     break;
                  }
                  _loc10_++;
               }
               _loc9_ = Number(_loc9_ + 2);
            }
            _loc5_ = new Point(x,y);
            _loc7_ = new Point(x,y);
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc5_ = _loc5_.add(_loc3_[_loc8_]);
               _loc8_++;
            }
            drawPoint(_loc3_,true);
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc7_ = _loc7_.add(_loc4_[_loc6_]);
               _loc6_++;
            }
            drawPoint(_loc4_,false);
            _loc5_.x = _loc5_.x / (_loc3_.length + 1);
            _loc5_.y = _loc5_.y / (_loc3_.length + 1);
            _loc7_.x = _loc7_.x / (_loc4_.length + 1);
            _loc7_.y = _loc7_.y / (_loc4_.length + 1);
            return MathUtils.GetAngleTwoPoint(_loc5_,_loc7_);
         }
         return 0;
      }
      
      private function drawPoint(param1:Array, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(_drawPointContainer == null)
         {
            _drawPointContainer = new Sprite();
         }
         if(param2)
         {
            _drawPointContainer.graphics.clear();
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _drawPointContainer.graphics.beginFill(16711680);
            _drawPointContainer.graphics.drawCircle(param1[_loc3_].x,param1[_loc3_].y,2);
            _drawPointContainer.graphics.endFill();
            _loc3_++;
         }
         _map.addChild(_drawPointContainer);
      }
      
      protected function flyOutMap() : void
      {
         if(_isLiving)
         {
            die();
         }
      }
      
      protected function collideObject(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc2_.collidedByObject(this);
         }
      }
      
      protected function collideGround() : void
      {
         if(_isMoving)
         {
            stopMoving();
         }
      }
      
      public function collidedByObject(param1:PhysicalObj3D) : void
      {
      }
      
      public function setActionMapping(param1:String, param2:String) : void
      {
      }
      
      public function die() : void
      {
         _isLiving = false;
         if(_isMoving)
         {
            stopMoving();
         }
      }
      
      public function getTestRect() : Rectangle
      {
         return _testRect.clone();
      }
      
      public function isBox() : Boolean
      {
         return false;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_smallBox);
         _smallBox = null;
         _testRect = null;
         super.dispose();
      }
   }
}
