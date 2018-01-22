package phy.maps
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import par.enginees.ParticleEnginee;
   import par.renderer.DisplayObjectRenderer;
   import phy.object.PhysicalObj;
   import phy.object.Physics;
   
   public class Map extends Sprite
   {
      
      private static var FRAME_TIME_OVER_TAG:int;
      
      private static var FRAME_OVER_COUNT_TAG:int;
       
      
      public var wind:Number = 3;
      
      public var windRate:Number = 1;
      
      public var gravity:Number = 9.8;
      
      public var airResistance:Number = 2;
      
      private var _objects:Dictionary;
      
      private var _phyicals:Dictionary;
      
      private var _bound:Rectangle;
      
      private var _partical:ParticleEnginee;
      
      protected var _sky:DisplayObject;
      
      protected var _stone:Ground;
      
      protected var _middle:DisplayObject;
      
      protected var _ground:Ground;
      
      protected var _sceneEffectLayer:Sprite;
      
      protected var _livingLayer:Sprite;
      
      protected var _phyLayer:Sprite;
      
      protected var _mapThing:Sprite;
      
      private var _lastCheckTime:int = 0;
      
      private var _frameTimeOverCount:int = 0;
      
      protected var _mapChanged:Boolean = false;
      
      private var _isLackOfFPS:Boolean = false;
      
      private var _drawPointContainer:Sprite;
      
      public function Map(param1:DisplayObject, param2:Ground = null, param3:Ground = null, param4:DisplayObject = null)
      {
         super();
         _phyicals = new Dictionary();
         _objects = new Dictionary();
         _sky = param1;
         addChild(_sky);
         graphics.beginFill(0,1);
         graphics.drawRect(0,0,_sky.width * 1.5,_sky.height * 1.5);
         graphics.endFill();
         _stone = param3;
         _middle = param4;
         if(_middle)
         {
            addChild(_middle);
         }
         _sceneEffectLayer = new Sprite();
         addChild(_sceneEffectLayer);
         if(_stone)
         {
            addChild(_stone);
         }
         _ground = param2;
         if(_ground)
         {
            addChild(_ground);
         }
         _livingLayer = new Sprite();
         addChild(_livingLayer);
         _phyLayer = new Sprite();
         addChild(_phyLayer);
         _mapThing = new Sprite();
         addChild(_mapThing);
         var _loc5_:DisplayObjectRenderer = new DisplayObjectRenderer();
         _phyLayer.addChild(_loc5_);
         _partical = new ParticleEnginee(_loc5_);
         if(_ground)
         {
            _bound = new Rectangle(0,0,_ground.width,_ground.height);
         }
         else
         {
            _bound = new Rectangle(0,0,_stone.width,_stone.height);
         }
         addEventListener("enterFrame",__enterFrame);
      }
      
      public function get bound() : Rectangle
      {
         return _bound;
      }
      
      public function get sky() : DisplayObject
      {
         return _sky;
      }
      
      public function get mapThingLayer() : DisplayObjectContainer
      {
         return _mapThing;
      }
      
      public function get ground() : Ground
      {
         return _ground;
      }
      
      public function get stone() : Ground
      {
         return _stone;
      }
      
      public function get particleEnginee() : ParticleEnginee
      {
         return _partical;
      }
      
      public function Dig(param1:Point, param2:Bitmap, param3:Bitmap = null) : void
      {
         _mapChanged = true;
         if(_ground)
         {
            _ground.Dig(param1,param2,param3);
         }
         if(_stone)
         {
            _stone.Dig(param1,param2,param3);
         }
      }
      
      public function get mapChanged() : Boolean
      {
         return _mapChanged;
      }
      
      public function resetMapChanged() : void
      {
         _mapChanged = false;
      }
      
      public function IsEmpty(param1:int, param2:int) : Boolean
      {
         return (_ground == null || _ground.IsEmpty(param1,param2)) && (_stone == null || _stone.IsEmpty(param1,param2));
      }
      
      public function IsRectangleEmpty(param1:Rectangle) : Boolean
      {
         return (_ground == null || _ground.IsRectangeEmptyQuick(param1)) && (_stone == null || _stone.IsRectangeEmptyQuick(param1));
      }
      
      public function IsCircleEmpty(param1:Rectangle, param2:Number = 30) : Boolean
      {
         return (_ground == null || _ground.IsCircleEmptyQuick(param1,param2)) && (_stone == null || _stone.IsCircleEmptyQuick(param1,param2));
      }
      
      public function IsBitmapDataEmpty(param1:BitmapData, param2:Point = null) : Boolean
      {
         return (_ground == null || _ground.IsBitmapDataEmpty(param1,param2)) && (_stone == null || _stone.IsBitmapDataEmpty(param1,param2));
      }
      
      public function findYLineNotEmptyPointDown(param1:int, param2:int, param3:int) : Point
      {
         var _loc4_:int = 0;
         param1 = param1 < 0?0:param1 >= _bound.width?_bound.width - 1:param1;
         param2 = param2 < 0?0:param2;
         param3 = param2 + param3 >= _bound.height?_bound.height - param2 - 1:param3;
         _loc4_ = 0;
         while(_loc4_ < param3)
         {
            if(!IsEmpty(param1 - 1,param2) || !IsEmpty(param1 + 1,param2))
            {
               return new Point(param1,param2);
            }
            param2++;
            _loc4_++;
         }
         return null;
      }
      
      public function findYLineNotEmptyPointUp(param1:int, param2:int, param3:int) : Point
      {
         var _loc4_:int = 0;
         param1 = param1 < 0?0:param1 > _bound.width?_bound.width:param1;
         param2 = param2 < 0?0:param2;
         param3 = param2 + param3 > _bound.height?_bound.height - param2:param3;
         _loc4_ = 0;
         while(_loc4_ < param3)
         {
            if(!IsEmpty(param1 - 1,param2) || !IsEmpty(param1 + 1,param2))
            {
               return new Point(param1,param2);
            }
            param2--;
            _loc4_++;
         }
         return null;
      }
      
      public function findNextWalkPoint(param1:int, param2:int, param3:int, param4:int, param5:int) : Point
      {
         if(param3 != 1 && param3 != -1)
         {
            return null;
         }
         var _loc6_:int = param1 + param3 * param4;
         if(_loc6_ < 0 || _loc6_ > _bound.width)
         {
            return null;
         }
         var _loc7_:Point = findYLineNotEmptyPointDown(_loc6_,param2 - param5 - 1,_bound.height);
         if(_loc7_)
         {
            if(Math.abs(_loc7_.y - param2) > param5)
            {
               trace(" null point offset:" + Math.abs(_loc7_.y - param2));
               _loc7_ = null;
            }
         }
         return _loc7_;
      }
      
      public function findXYLineNotEmptyPoint(param1:int, param2:int, param3:int, param4:int, param5:int) : Point
      {
         var _loc6_:* = null;
         var _loc11_:int = 0;
         if(param3 != 1 && param3 != -1)
         {
            return null;
         }
         var _loc8_:Boolean = IsEmpty(param1 - 1,param2);
         var _loc10_:Boolean = IsEmpty(param1 + 1,param2);
         var _loc12_:Boolean = IsEmpty(param1,param2 - 1);
         var _loc7_:Boolean = IsEmpty(param1,param2 + 1);
         trace((!!_loc8_?"":"!") + "left && " + (!!_loc10_?"":"!") + "right && " + (!!_loc12_?"":"!") + "top && " + (!!_loc7_?"":"!") + "bottom");
         var _loc9_:Array = [];
         if(_loc8_ && _loc10_ && _loc12_ && _loc7_)
         {
            _loc9_.push("rt");
            _loc9_.push("lt");
            _loc9_.push("rb");
            _loc9_.push("lb");
         }
         else if(!_loc8_ && !_loc10_ && !_loc12_ && !_loc7_)
         {
            _loc9_.push("rt");
            _loc9_.push("lt");
            _loc9_.push("rb");
            _loc9_.push("lb");
         }
         else if(_loc8_ && !_loc10_ && _loc12_ && !_loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("rt");
            }
            else
            {
               _loc9_.push("lb");
            }
         }
         else if(_loc8_ && !_loc10_ && _loc12_ && _loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("lt");
               _loc9_.push("rt");
            }
            else
            {
               _loc9_.push("rb");
            }
         }
         else if(!_loc8_ && !_loc10_ && _loc12_ && !_loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("rt");
            }
            else
            {
               _loc9_.push("lt");
            }
         }
         else if(_loc8_ && _loc10_ && _loc12_ && !_loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("rt");
               _loc9_.push("rb");
            }
            else
            {
               _loc9_.push("lt");
               _loc9_.push("lb");
            }
         }
         else if(!_loc8_ && _loc10_ && _loc12_ && !_loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("rb");
            }
            else
            {
               _loc9_.push("lt");
            }
         }
         else if(!_loc8_ && _loc10_ && _loc12_ && _loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("rb");
               _loc9_.push("lb");
            }
            else
            {
               _loc9_.push("lt");
            }
         }
         else if(!_loc8_ && _loc10_ && !_loc12_ && _loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("lb");
            }
            else
            {
               _loc9_.push("rt");
            }
         }
         else if(!_loc8_ && !_loc10_ && !_loc12_ && _loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("lt");
               _loc9_.push("lb");
            }
            else
            {
               _loc9_.push("rb");
            }
         }
         else if(_loc8_ && _loc10_ && !_loc12_ && _loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("lt");
               _loc9_.push("lb");
            }
            else
            {
               _loc9_.push("rt");
            }
         }
         else if(_loc8_ && !_loc10_ && !_loc12_ && _loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("lt");
            }
            else
            {
               _loc9_.push("rb");
            }
         }
         else if(_loc8_ && !_loc10_ && !_loc12_ && !_loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("rt");
               _loc9_.push("lt");
            }
            else
            {
               _loc9_.push("lb");
            }
         }
         else if(!_loc8_ && _loc10_ && !_loc12_ && !_loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("rb");
               _loc9_.push("rt");
            }
            else
            {
               _loc9_.push("rt");
            }
         }
         else if(_loc8_ && _loc10_ && _loc12_ && _loc7_)
         {
            if(param3 == 1)
            {
               _loc9_.push("rb");
            }
            else
            {
               _loc9_.push("lt");
            }
         }
         _loc11_ = 0;
         while(_loc11_ < _loc9_.length)
         {
            _loc6_ = findLineByRect(param1,param2,_loc9_[_loc11_],param4,param5);
            if(!_loc6_)
            {
               _loc11_++;
               continue;
            }
            break;
         }
         if(_loc6_)
         {
            if(_loc6_.x <= 0 || _loc6_.x >= _bound.width)
            {
               return null;
            }
            if(_loc6_.y <= 0 || _loc6_.y >= _bound.height)
            {
               return null;
            }
         }
         return _loc6_;
      }
      
      public function findLineByRect(param1:int, param2:int, param3:String, param4:int, param5:int) : Point
      {
         var _loc12_:* = null;
         var _loc9_:* = 0;
         var _loc8_:* = 0;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc6_:int = 1;
         var _loc7_:int = 1;
         if(param3 == "lt")
         {
            _loc6_ = -1;
            _loc7_ = -1;
         }
         else if(param3 == "rt")
         {
            _loc6_ = 1;
            _loc7_ = -1;
         }
         else if(param3 == "lb")
         {
            _loc6_ = -1;
            _loc7_ = 1;
         }
         else if(param3 == "rb")
         {
            _loc6_ = 1;
            _loc7_ = 1;
         }
         _loc9_ = param4;
         loop0:
         while(_loc9_ > 0)
         {
            _loc11_ = param1 + _loc9_ * _loc6_;
            _loc10_ = param2 + param5 * _loc7_;
            _loc8_ = param5;
            while(_loc8_ > 0)
            {
               _loc14_ = IsEmpty(_loc11_ - 1,_loc10_);
               _loc15_ = IsEmpty(_loc11_ + 1,_loc10_);
               _loc16_ = IsEmpty(_loc11_,_loc10_ - 1);
               _loc13_ = IsEmpty(_loc11_,_loc10_ + 1);
               if(!_loc14_ || !_loc15_ || !_loc16_ || !_loc13_)
               {
                  if(!(!_loc14_ && !_loc15_ && !_loc16_ && !_loc13_))
                  {
                     _loc12_ = new Point(_loc11_,_loc10_);
                     break loop0;
                  }
               }
               _loc10_ = _loc10_ - 1 * _loc7_;
               _loc8_--;
            }
            _loc11_ = _loc11_ - 1 * _loc6_;
            _loc9_--;
         }
         return _loc12_;
      }
      
      public function canMove(param1:int, param2:int) : Boolean
      {
         return IsEmpty(param1,param2) && !IsOutMap(param1,param2);
      }
      
      public function IsOutMap(param1:int, param2:int) : Boolean
      {
         if(param1 < _bound.x || param1 > _bound.width || param2 > _bound.height)
         {
            return true;
         }
         return false;
      }
      
      public function addPhysical(param1:Physics) : void
      {
         if(param1 is PhysicalObj)
         {
            _phyicals[param1] = param1;
            if(param1.layer == 3)
            {
               _phyLayer.addChild(param1);
            }
            else if(param1.layer == 5)
            {
               _livingLayer.addChild(param1);
            }
            else if(param1.layer == 1)
            {
               _livingLayer.addChild(param1);
            }
            else if(param1.layer == 4 || param1.layer == 6)
            {
               _livingLayer.addChildAt(param1,0);
            }
            else if(param1.layer == 7)
            {
               _sceneEffectLayer.addChild(param1);
            }
            else
            {
               _phyLayer.addChild(param1);
            }
         }
         else
         {
            _objects[param1] = param1;
            addChild(param1);
         }
         param1.setMap(this);
      }
      
      public function addToPhyLayer(param1:DisplayObject) : void
      {
         _phyLayer.addChild(param1);
      }
      
      public function get livngLayer() : DisplayObjectContainer
      {
         return _livingLayer;
      }
      
      public function addMapThing(param1:Physics) : void
      {
         _mapThing.addChild(param1);
         param1.setMap(this);
         if(param1 is PhysicalObj)
         {
            _phyicals[param1] = param1;
         }
         else
         {
            _objects[param1] = param1;
         }
      }
      
      public function removeMapThing(param1:Physics) : void
      {
         _mapThing.removeChild(param1);
         param1.setMap(null);
         if(param1 is PhysicalObj)
         {
            delete _phyicals[param1];
         }
         else
         {
            delete _objects[param1];
         }
      }
      
      public function setTopPhysical(param1:Physics) : void
      {
         param1.parent.setChildIndex(param1,param1.parent.numChildren - 1);
      }
      
      public function hasSomethingMoving() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _phyicals;
         for each(var _loc1_ in _phyicals)
         {
            if(_loc1_.isMoving())
            {
               return true;
            }
         }
         return false;
      }
      
      public function removePhysical(param1:Physics) : void
      {
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         param1.setMap(null);
         if(param1 is PhysicalObj)
         {
            if(_phyicals == null || !_phyicals[param1])
            {
               return;
            }
            delete _phyicals[param1];
         }
         else
         {
            if(_objects && !_objects[param1])
            {
               return;
            }
            delete _objects[param1];
         }
      }
      
      public function hidePhysical(param1:PhysicalObj) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var _loc2_ in _phyicals)
         {
            if(_loc2_ != param1)
            {
               _loc2_.visible = false;
            }
         }
      }
      
      public function showPhysical() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _phyicals;
         for each(var _loc1_ in _phyicals)
         {
            _loc1_.visible = true;
         }
      }
      
      public function getIsCollideObj() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var _loc2_ in _phyicals)
         {
            if(_loc2_.isLiving && _loc2_.IsCollide)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getPhysicalById(param1:int) : PhysicalObj
      {
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var _loc2_ in _phyicals)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPhysicalObjects(param1:Rectangle, param2:PhysicalObj) : Array
      {
         var _loc3_:* = null;
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _phyicals;
         for each(var _loc5_ in _phyicals)
         {
            if(_loc5_ != param2 && _loc5_.isLiving && _loc5_.canCollided && _loc5_.layer != 7)
            {
               _loc3_ = _loc5_.getCollideRect();
               _loc3_.offset(_loc5_.x,_loc5_.y);
               if(_loc3_.intersects(param1))
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         return _loc4_;
      }
      
      public function getSceneEffectPhysicalObject(param1:Rectangle, param2:PhysicalObj, param3:Point = null) : PhysicalObj
      {
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = _phyicals;
         for each(var _loc5_ in _phyicals)
         {
            if(_loc5_ != param2 && _loc5_.canCollided && _loc5_.layerType == 7)
            {
               if(_loc5_.Id < -100 && _loc5_.Id >= -103)
               {
                  if(param3)
                  {
                     if(param3.x < param2.x)
                     {
                        if(param2.y >= _loc5_.y && (_loc5_.x >= param3.x && _loc5_.x <= param2.x))
                        {
                           return _loc5_;
                        }
                     }
                     else if(param2.y >= _loc5_.y && (_loc5_.x >= param2.x && _loc5_.x <= param3.x))
                     {
                        return _loc5_;
                     }
                  }
               }
               else
               {
                  _loc4_ = _loc5_.getCollideRect();
                  _loc4_.offset(_loc5_.x,_loc5_.y);
                  if(_loc4_.intersects(param1))
                  {
                     return _loc5_;
                  }
               }
            }
         }
         return null;
      }
      
      public function getSceneEffectPhysicalObjectCircle(param1:Rectangle, param2:PhysicalObj) : PhysicalObj
      {
         var _loc6_:Number = NaN;
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         var _loc8_:int = 0;
         var _loc7_:* = _phyicals;
         for each(var _loc5_ in _phyicals)
         {
            if(_loc5_ != param2 && _loc5_.canCollided && _loc5_.layerType == 7)
            {
               _loc6_ = Point.distance(param2.pos,_loc5_.pos);
               _loc3_ = _loc5_.getCollideRect();
               _loc4_ = _loc3_.width / 2;
               if(_loc6_ < _loc4_)
               {
                  return _loc5_;
               }
            }
         }
         return null;
      }
      
      public function getSceneEffectPhysicalById(param1:int) : PhysicalObj
      {
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var _loc2_ in _phyicals)
         {
            if(_loc2_.Id == param1 && _loc2_.layerType == 7)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPhysicalObjectByPoint(param1:Point, param2:Number, param3:PhysicalObj = null) : Array
      {
         var _loc5_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _phyicals;
         for each(var _loc4_ in _phyicals)
         {
            if(_loc4_ != param3 && _loc4_.isLiving && Point.distance(param1,_loc4_.pos) <= param2)
            {
               _loc5_.push(_loc4_);
            }
         }
         return _loc5_;
      }
      
      public function dieSceneEffectLayer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(_sceneEffectLayer.numChildren > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _sceneEffectLayer.numChildren)
            {
               _loc1_ = _sceneEffectLayer.getChildAt(_loc2_) as PhysicalObj;
               _loc1_.die();
               _loc2_++;
            }
         }
      }
      
      public function clearSceneEffectLayer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(_sceneEffectLayer.numChildren > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _sceneEffectLayer.numChildren)
            {
               _loc1_ = _sceneEffectLayer.getChildAt(_loc2_) as PhysicalObj;
               _loc1_.dispose();
               _loc2_++;
            }
         }
      }
      
      public function getBoxesByRect(param1:Rectangle) : Array
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _phyicals;
         for each(var _loc4_ in _phyicals)
         {
            if(_loc4_.isBox() && _loc4_.isLiving)
            {
               _loc2_ = _loc4_.getTestRect();
               _loc2_.offset(_loc4_.x,_loc4_.y);
               if(_loc2_.intersects(param1))
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      private function __enterFrame(param1:Event) : void
      {
         update();
      }
      
      protected function update() : void
      {
         var _loc1_:Number = numChildren;
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var _loc2_ in _phyicals)
         {
            _loc2_.update(0.04);
         }
         _partical.update();
      }
      
      private function checkOverFrameRate() : void
      {
         if(_isLackOfFPS)
         {
            return;
         }
         var _loc1_:int = getTimer();
         if(_lastCheckTime == 0)
         {
            _lastCheckTime = _loc1_ - 40;
         }
         if(_loc1_ - _lastCheckTime > FRAME_TIME_OVER_TAG)
         {
            trace(String(_loc1_ - _lastCheckTime));
            _frameTimeOverCount = Number(_frameTimeOverCount) + 1;
         }
         else
         {
            if(_frameTimeOverCount > 0)
            {
               trace("delay frame count:" + _frameTimeOverCount);
            }
            _frameTimeOverCount = 0;
         }
         _lastCheckTime = _loc1_;
         if(_frameTimeOverCount > FRAME_OVER_COUNT_TAG)
         {
            _isLackOfFPS = true;
         }
      }
      
      public function getCollidedPhysicalObjects(param1:Rectangle, param2:PhysicalObj) : Array
      {
         var _loc3_:* = null;
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _phyicals;
         for each(var _loc5_ in _phyicals)
         {
            if(_loc5_ != param2 && _loc5_.canCollided)
            {
               _loc3_ = _loc5_.getCollideRect();
               _loc3_.offset(_loc5_.x,_loc5_.y);
               if(_loc3_.intersects(param1))
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         return _loc4_;
      }
      
      public function get isLackOfFPS() : Boolean
      {
         return _isLackOfFPS;
      }
      
      public function get mapMaxHeight() : Number
      {
         return Math.max(!!ground?ground.height:0,!!stone?stone.height:0);
      }
      
      public function drawPoint(param1:Array, param2:Boolean, param3:Number = 2, param4:uint = 16711680) : void
      {
         var _loc5_:int = 0;
         if(_drawPointContainer == null)
         {
            _drawPointContainer = new Sprite();
         }
         if(param2)
         {
            _drawPointContainer.graphics.clear();
         }
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _drawPointContainer.graphics.beginFill(param4);
            _drawPointContainer.graphics.drawCircle(param1[_loc5_].x,param1[_loc5_].y,param3);
            _drawPointContainer.graphics.endFill();
            _loc5_++;
         }
         this.addChild(_drawPointContainer);
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         removeEventListener("enterFrame",__enterFrame);
         var _loc1_:Number = numChildren;
         _loc3_ = _loc1_ - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = getChildAt(_loc3_);
            if(_loc2_ is Physics)
            {
               Physics(_loc2_).dispose();
            }
            _loc3_--;
         }
         _partical.dispose();
         if(_ground)
         {
            _ground.dispose();
         }
         _ground = null;
         if(_stone)
         {
            _stone.dispose();
         }
         _stone = null;
         if(_middle)
         {
            if(_middle.parent)
            {
               _middle.parent.removeChild(_middle);
            }
            _middle = null;
         }
         if(_sceneEffectLayer)
         {
            if(_sceneEffectLayer.parent)
            {
               _sceneEffectLayer.parent.removeChild(_sceneEffectLayer);
            }
            _sceneEffectLayer = null;
         }
         removeChild(_sky);
         _sky = null;
         if(_mapThing && _mapThing.parent)
         {
            _mapThing.parent.removeChild(_mapThing);
         }
         ObjectUtils.disposeAllChildren(this);
         _phyicals = null;
         _objects = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
