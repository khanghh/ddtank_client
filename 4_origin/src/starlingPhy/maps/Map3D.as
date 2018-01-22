package starlingPhy.maps
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import road7th.data.DictionaryData;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import starlingPhy.object.PhysicalObj3D;
   import starlingPhy.object.Physics3D;
   
   public class Map3D extends Sprite
   {
      
      private static var FRAME_TIME_OVER_TAG:int;
      
      private static var FRAME_OVER_COUNT_TAG:int;
       
      
      public var wind:Number = 3;
      
      public var windRate:Number = 1;
      
      public var gravity:Number = 9.8;
      
      public var airResistance:Number = 2;
      
      private var _objects:DictionaryData;
      
      private var _phyicals:DictionaryData;
      
      private var _bound:Rectangle;
      
      protected var _bg:Sprite;
      
      protected var _sky:DisplayObject;
      
      protected var _stone:Ground3D;
      
      protected var _ground:Ground3D;
      
      protected var _real:Ground3D;
      
      protected var _sceneEffectLayer:Sprite;
      
      protected var _livingLayer:Sprite;
      
      protected var _phyLayer:Sprite;
      
      protected var _mapThing:Sprite;
      
      private var _lastCheckTime:int = 0;
      
      private var _frameTimeOverCount:int = 0;
      
      protected var _mapChanged:Boolean = false;
      
      private var _isLackOfFPS:Boolean = false;
      
      private var _drawPointContainer:Sprite;
      
      public function Map3D(param1:DisplayObject, param2:Ground3D = null, param3:Ground3D = null, param4:Ground3D = null)
      {
         super();
         _phyicals = new DictionaryData();
         _objects = new DictionaryData();
         _sky = param1;
         addChild(_sky);
         _bg = new Sprite();
         _bg.visible = false;
         _bg.graphics.beginFill(0,1);
         _bg.graphics.drawRect(0,0,param1.width * 2,param1.height * 2);
         _bg.graphics.endFill();
         addChild(_bg);
         _sceneEffectLayer = new Sprite();
         addChild(_sceneEffectLayer);
         _stone = param3;
         if(_stone)
         {
            addChild(_stone);
         }
         _ground = param2;
         if(_ground)
         {
            addChild(_ground);
         }
         _real = param4;
         _livingLayer = new Sprite();
         addChild(_livingLayer);
         _phyLayer = new Sprite();
         addChild(_phyLayer);
         _mapThing = new Sprite();
         addChild(_mapThing);
         if(_ground)
         {
            _bound = new Rectangle(0,0,_ground.width,_ground.height);
         }
         else if(_real)
         {
            _bound = new Rectangle(0,0,_real.width,_real.height);
         }
         else if(_stone)
         {
            _bound = new Rectangle(0,0,_stone.width,_stone.height);
         }
         else
         {
            _bound = new Rectangle(0,0,_sky.width,_sky.height);
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
      
      public function get mapThingLayer() : Sprite
      {
         return _mapThing;
      }
      
      public function get ground() : Ground3D
      {
         return _ground;
      }
      
      public function get stone() : Ground3D
      {
         return _stone;
      }
      
      public function get real() : Ground3D
      {
         return _real;
      }
      
      public function get bg() : Sprite
      {
         return _bg;
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
         return (_ground == null || _ground.IsEmpty(param1,param2)) && (_stone == null || _stone.IsEmpty(param1,param2)) && (_real == null || _real.IsEmpty(param1,param2));
      }
      
      public function IsRectangleEmpty(param1:Rectangle) : Boolean
      {
         return (_ground == null || _ground.IsRectangeEmptyQuick(param1)) && (_stone == null || _stone.IsRectangeEmptyQuick(param1)) && (_real == null || _real.IsRectangeEmptyQuick(param1));
      }
      
      public function IsCircleEmpty(param1:Rectangle, param2:Number = 30) : Boolean
      {
         return (_ground == null || _ground.IsCircleEmptyQuick(param1,param2)) && (_stone == null || _stone.IsCircleEmptyQuick(param1,param2)) && (_real == null || _real.IsCircleEmptyQuick(param1,param2));
      }
      
      public function IsBitmapDataEmpty(param1:BitmapData, param2:Point = null) : Boolean
      {
         return (_ground == null || _ground.IsBitmapDataEmpty(param1,param2)) && (_stone == null || _stone.IsBitmapDataEmpty(param1,param2)) && (_real == null || _real.IsBitmapDataEmpty(param1,param2));
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
      
      public function findNextWalkBombPoint(param1:int, param2:int, param3:int, param4:int, param5:int) : Point
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
         return _loc7_;
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
      
      public function addPhysical(param1:Physics3D) : void
      {
         if(_phyicals && param1 is PhysicalObj3D)
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
         else if(_objects)
         {
            _objects[param1] = param1;
            addChild(param1);
         }
         else
         {
            StarlingObjectUtils.disposeObject(param1);
            return;
         }
         param1.setMap(this);
      }
      
      public function addToPhyLayer(param1:DisplayObject) : void
      {
         _phyLayer.addChild(param1);
      }
      
      public function get livngLayer() : Sprite
      {
         return _livingLayer;
      }
      
      public function addMapThing(param1:Physics3D) : void
      {
         _mapThing.addChild(param1);
         param1.setMap(this);
         if(param1 is PhysicalObj3D)
         {
            _phyicals[param1] = param1;
         }
         else
         {
            _objects[param1] = param1;
         }
      }
      
      public function removeMapThing(param1:Physics3D) : void
      {
         if(param1 is PhysicalObj3D)
         {
            delete _phyicals[param1];
         }
         else
         {
            delete _objects[param1];
         }
         param1.setMap(null);
         StarlingObjectUtils.removeObject(param1);
      }
      
      public function setTopPhysical(param1:Physics3D) : void
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
      
      public function removePhysical(param1:Physics3D) : void
      {
         StarlingObjectUtils.removeObject(param1);
         if(param1 is PhysicalObj3D)
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
         param1.setMap(null);
      }
      
      public function hidePhysical(param1:PhysicalObj3D) : void
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
      
      public function getPhysicalById(param1:int) : PhysicalObj3D
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
      
      public function getPhysicalObjects(param1:Rectangle, param2:PhysicalObj3D) : Array
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
      
      public function getSceneEffectPhysicalObject(param1:Rectangle, param2:PhysicalObj3D, param3:Point = null) : PhysicalObj3D
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
      
      public function getSceneEffectPhysicalObjectCircle(param1:Rectangle, param2:PhysicalObj3D) : PhysicalObj3D
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
      
      public function getSceneEffectPhysicalById(param1:int) : PhysicalObj3D
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
      
      public function getPhysicalObjectByPoint(param1:Point, param2:Number, param3:PhysicalObj3D = null) : Array
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
               _loc1_ = _sceneEffectLayer.getChildAt(_loc2_) as PhysicalObj3D;
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
               _loc1_ = _sceneEffectLayer.getChildAt(_loc2_) as PhysicalObj3D;
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
      
      public function getCollidedPhysicalObjects(param1:Rectangle, param2:PhysicalObj3D) : Array
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
      
      override public function dispose() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         StarlingObjectUtils.disposeObject(_bg);
         _bg = null;
         StarlingObjectUtils.disposeObject(_sky);
         _sky = null;
         StarlingObjectUtils.disposeAllChildren(_ground);
         StarlingObjectUtils.disposeObject(_ground);
         _ground = null;
         StarlingObjectUtils.disposeAllChildren(_stone);
         StarlingObjectUtils.disposeObject(_stone);
         _stone = null;
         StarlingObjectUtils.disposeAllChildren(_real);
         StarlingObjectUtils.disposeObject(_real);
         _real = null;
         StarlingObjectUtils.disposeAllChildren(_sceneEffectLayer);
         StarlingObjectUtils.disposeObject(_sceneEffectLayer);
         _sceneEffectLayer = null;
         StarlingObjectUtils.disposeAllChildren(_mapThing);
         StarlingObjectUtils.disposeObject(_mapThing);
         _mapThing = null;
         StarlingObjectUtils.disposeAllChildren(_livingLayer);
         StarlingObjectUtils.disposeObject(_livingLayer);
         _livingLayer = null;
         StarlingObjectUtils.disposeAllChildren(_phyLayer);
         StarlingObjectUtils.disposeObject(_phyLayer);
         _phyLayer = null;
         StarlingObjectUtils.disposeAllChildren(this,true);
         _bound = null;
         _phyicals.clear();
         _objects.clear();
         _phyicals = null;
         _objects = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
