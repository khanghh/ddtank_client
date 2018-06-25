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
      
      public function Map3D(sky:DisplayObject, ground:Ground3D = null, stone:Ground3D = null, real:Ground3D = null)
      {
         super();
         _phyicals = new DictionaryData();
         _objects = new DictionaryData();
         _sky = sky;
         addChild(_sky);
         _bg = new Sprite();
         _bg.visible = false;
         _bg.graphics.beginFill(0,1);
         _bg.graphics.drawRect(0,0,sky.width * 2,sky.height * 2);
         _bg.graphics.endFill();
         addChild(_bg);
         _sceneEffectLayer = new Sprite();
         addChild(_sceneEffectLayer);
         _stone = stone;
         if(_stone)
         {
            addChild(_stone);
         }
         _ground = ground;
         if(_ground)
         {
            addChild(_ground);
         }
         _real = real;
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
      
      public function Dig(center:Point, surface:Bitmap, border:Bitmap = null) : void
      {
         _mapChanged = true;
         if(_ground)
         {
            _ground.Dig(center,surface,border);
         }
         if(_stone)
         {
            _stone.Dig(center,surface,border);
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
      
      public function IsEmpty(x:int, y:int) : Boolean
      {
         return (_ground == null || _ground.IsEmpty(x,y)) && (_stone == null || _stone.IsEmpty(x,y)) && (_real == null || _real.IsEmpty(x,y));
      }
      
      public function IsRectangleEmpty(rect:Rectangle) : Boolean
      {
         return (_ground == null || _ground.IsRectangeEmptyQuick(rect)) && (_stone == null || _stone.IsRectangeEmptyQuick(rect)) && (_real == null || _real.IsRectangeEmptyQuick(rect));
      }
      
      public function IsCircleEmpty(rect:Rectangle, rAngle:Number = 30) : Boolean
      {
         return (_ground == null || _ground.IsCircleEmptyQuick(rect,rAngle)) && (_stone == null || _stone.IsCircleEmptyQuick(rect,rAngle)) && (_real == null || _real.IsCircleEmptyQuick(rect,rAngle));
      }
      
      public function IsBitmapDataEmpty(bitmapData:BitmapData, bitmapPoint:Point = null) : Boolean
      {
         return (_ground == null || _ground.IsBitmapDataEmpty(bitmapData,bitmapPoint)) && (_stone == null || _stone.IsBitmapDataEmpty(bitmapData,bitmapPoint)) && (_real == null || _real.IsBitmapDataEmpty(bitmapData,bitmapPoint));
      }
      
      public function findYLineNotEmptyPointDown(x:int, y:int, h:int) : Point
      {
         var i:int = 0;
         x = x < 0?0:x >= _bound.width?_bound.width - 1:x;
         y = y < 0?0:y;
         h = y + h >= _bound.height?_bound.height - y - 1:h;
         for(i = 0; i < h; )
         {
            if(!IsEmpty(x - 1,y) || !IsEmpty(x + 1,y))
            {
               return new Point(x,y);
            }
            y++;
            i++;
         }
         return null;
      }
      
      public function findYLineNotEmptyPointUp(x:int, y:int, h:int) : Point
      {
         var i:int = 0;
         x = x < 0?0:x > _bound.width?_bound.width:x;
         y = y < 0?0:y;
         h = y + h > _bound.height?_bound.height - y:h;
         for(i = 0; i < h; )
         {
            if(!IsEmpty(x - 1,y) || !IsEmpty(x + 1,y))
            {
               return new Point(x,y);
            }
            y--;
            i++;
         }
         return null;
      }
      
      public function findNextWalkPoint(posX:int, posY:int, direction:int, stepX:int, stepY:int) : Point
      {
         if(direction != 1 && direction != -1)
         {
            return null;
         }
         var tx:int = posX + direction * stepX;
         if(tx < 0 || tx > _bound.width)
         {
            return null;
         }
         var p:Point = findYLineNotEmptyPointDown(tx,posY - stepY - 1,_bound.height);
         if(p)
         {
            if(Math.abs(p.y - posY) > stepY)
            {
               trace(" null point offset:" + Math.abs(p.y - posY));
               p = null;
            }
         }
         return p;
      }
      
      public function findNextWalkBombPoint(posX:int, posY:int, direction:int, stepX:int, stepY:int) : Point
      {
         if(direction != 1 && direction != -1)
         {
            return null;
         }
         var tx:int = posX + direction * stepX;
         if(tx < 0 || tx > _bound.width)
         {
            return null;
         }
         var p:Point = findYLineNotEmptyPointDown(tx,posY - stepY - 1,_bound.height);
         return p;
      }
      
      public function canMove(x:int, y:int) : Boolean
      {
         return IsEmpty(x,y) && !IsOutMap(x,y);
      }
      
      public function IsOutMap(x:int, y:int) : Boolean
      {
         if(x < _bound.x || x > _bound.width || y > _bound.height)
         {
            return true;
         }
         return false;
      }
      
      public function addPhysical(phyobj:Physics3D) : void
      {
         if(_phyicals && phyobj is PhysicalObj3D)
         {
            _phyicals[phyobj] = phyobj;
            if(phyobj.layer == 3)
            {
               _phyLayer.addChild(phyobj);
            }
            else if(phyobj.layer == 5)
            {
               _livingLayer.addChild(phyobj);
            }
            else if(phyobj.layer == 1)
            {
               _livingLayer.addChild(phyobj);
            }
            else if(phyobj.layer == 4 || phyobj.layer == 6)
            {
               _livingLayer.addChildAt(phyobj,0);
            }
            else if(phyobj.layer == 7)
            {
               _sceneEffectLayer.addChild(phyobj);
            }
            else
            {
               _phyLayer.addChild(phyobj);
            }
         }
         else if(_objects)
         {
            _objects[phyobj] = phyobj;
            addChild(phyobj);
         }
         else
         {
            StarlingObjectUtils.disposeObject(phyobj);
            return;
         }
         phyobj.setMap(this);
      }
      
      public function addToPhyLayer(b:DisplayObject) : void
      {
         _phyLayer.addChild(b);
      }
      
      public function get livngLayer() : Sprite
      {
         return _livingLayer;
      }
      
      public function addMapThing(phyS:Physics3D) : void
      {
         _mapThing.addChild(phyS);
         phyS.setMap(this);
         if(phyS is PhysicalObj3D)
         {
            _phyicals[phyS] = phyS;
         }
         else
         {
            _objects[phyS] = phyS;
         }
      }
      
      public function removeMapThing(phyS:Physics3D) : void
      {
         if(phyS is PhysicalObj3D)
         {
            delete _phyicals[phyS];
         }
         else
         {
            delete _objects[phyS];
         }
         phyS.setMap(null);
         StarlingObjectUtils.removeObject(phyS);
      }
      
      public function setTopPhysical($phy:Physics3D) : void
      {
         $phy.parent.setChildIndex($phy,$phy.parent.numChildren - 1);
      }
      
      public function hasSomethingMoving() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = _phyicals;
         for each(var p in _phyicals)
         {
            if(p.isMoving())
            {
               return true;
            }
         }
         return false;
      }
      
      public function removePhysical(phyO:Physics3D) : void
      {
         StarlingObjectUtils.removeObject(phyO);
         if(phyO is PhysicalObj3D)
         {
            if(_phyicals == null || !_phyicals[phyO])
            {
               return;
            }
            delete _phyicals[phyO];
         }
         else
         {
            if(_objects && !_objects[phyO])
            {
               return;
            }
            delete _objects[phyO];
         }
         phyO.setMap(null);
      }
      
      public function hidePhysical(except:PhysicalObj3D) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var p in _phyicals)
         {
            if(p != except)
            {
               p.visible = false;
            }
         }
      }
      
      public function showPhysical() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _phyicals;
         for each(var p in _phyicals)
         {
            p.visible = true;
         }
      }
      
      public function getPhysicalById(id:int) : PhysicalObj3D
      {
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var p in _phyicals)
         {
            if(p.Id == id)
            {
               return p;
            }
         }
         return null;
      }
      
      public function getPhysicalObjects(rect:Rectangle, except:PhysicalObj3D) : Array
      {
         var t:* = null;
         var temp:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _phyicals;
         for each(var phyO in _phyicals)
         {
            if(phyO != except && phyO.isLiving && phyO.canCollided && phyO.layer != 7)
            {
               t = phyO.getCollideRect();
               t.offset(phyO.x,phyO.y);
               if(t.intersects(rect))
               {
                  temp.push(phyO);
               }
            }
         }
         return temp;
      }
      
      public function getSceneEffectPhysicalObject(rect:Rectangle, except:PhysicalObj3D, prePos:Point = null) : PhysicalObj3D
      {
         var t:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = _phyicals;
         for each(var phy0 in _phyicals)
         {
            if(phy0 != except && phy0.canCollided && phy0.layerType == 7)
            {
               if(phy0.Id < -100 && phy0.Id >= -103)
               {
                  if(prePos)
                  {
                     if(prePos.x < except.x)
                     {
                        if(except.y >= phy0.y && (phy0.x >= prePos.x && phy0.x <= except.x))
                        {
                           return phy0;
                        }
                     }
                     else if(except.y >= phy0.y && (phy0.x >= except.x && phy0.x <= prePos.x))
                     {
                        return phy0;
                     }
                  }
               }
               else
               {
                  t = phy0.getCollideRect();
                  t.offset(phy0.x,phy0.y);
                  if(t.intersects(rect))
                  {
                     return phy0;
                  }
               }
            }
         }
         return null;
      }
      
      public function getSceneEffectPhysicalObjectCircle(rect:Rectangle, except:PhysicalObj3D) : PhysicalObj3D
      {
         var dist:Number = NaN;
         var t2:* = null;
         var r:Number = NaN;
         var _loc8_:int = 0;
         var _loc7_:* = _phyicals;
         for each(var phy1 in _phyicals)
         {
            if(phy1 != except && phy1.canCollided && phy1.layerType == 7)
            {
               dist = Point.distance(except.pos,phy1.pos);
               t2 = phy1.getCollideRect();
               r = t2.width / 2;
               if(dist < r)
               {
                  return phy1;
               }
            }
         }
         return null;
      }
      
      public function getSceneEffectPhysicalById(id:int) : PhysicalObj3D
      {
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var phy0 in _phyicals)
         {
            if(phy0.Id == id && phy0.layerType == 7)
            {
               return phy0;
            }
         }
         return null;
      }
      
      public function getPhysicalObjectByPoint(point:Point, radius:Number, except:PhysicalObj3D = null) : Array
      {
         var temp:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _phyicals;
         for each(var t in _phyicals)
         {
            if(t != except && t.isLiving && Point.distance(point,t.pos) <= radius)
            {
               temp.push(t);
            }
         }
         return temp;
      }
      
      public function dieSceneEffectLayer() : void
      {
         var i:int = 0;
         var phyO:* = null;
         if(_sceneEffectLayer.numChildren > 0)
         {
            for(i = 0; i < _sceneEffectLayer.numChildren; )
            {
               phyO = _sceneEffectLayer.getChildAt(i) as PhysicalObj3D;
               phyO.die();
               i++;
            }
         }
      }
      
      public function clearSceneEffectLayer() : void
      {
         var i:int = 0;
         var phyO:* = null;
         if(_sceneEffectLayer.numChildren > 0)
         {
            for(i = 0; i < _sceneEffectLayer.numChildren; )
            {
               phyO = _sceneEffectLayer.getChildAt(i) as PhysicalObj3D;
               phyO.dispose();
               i++;
            }
         }
      }
      
      public function getBoxesByRect(rect:Rectangle) : Array
      {
         var t:* = null;
         var temp:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = _phyicals;
         for each(var obj in _phyicals)
         {
            if(obj.isBox() && obj.isLiving)
            {
               t = obj.getTestRect();
               t.offset(obj.x,obj.y);
               if(t.intersects(rect))
               {
                  temp.push(obj);
               }
            }
         }
         return temp;
      }
      
      private function __enterFrame(event:Event) : void
      {
         update();
      }
      
      protected function update() : void
      {
         var num:Number = numChildren;
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var p in _phyicals)
         {
            p.update(0.04);
         }
      }
      
      private function checkOverFrameRate() : void
      {
         if(_isLackOfFPS)
         {
            return;
         }
         var currentTime:int = getTimer();
         if(_lastCheckTime == 0)
         {
            _lastCheckTime = currentTime - 40;
         }
         if(currentTime - _lastCheckTime > FRAME_TIME_OVER_TAG)
         {
            trace(String(currentTime - _lastCheckTime));
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
         _lastCheckTime = currentTime;
         if(_frameTimeOverCount > FRAME_OVER_COUNT_TAG)
         {
            _isLackOfFPS = true;
         }
      }
      
      public function getCollidedPhysicalObjects(rect:Rectangle, except:PhysicalObj3D) : Array
      {
         var t:* = null;
         var temp:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _phyicals;
         for each(var phyO in _phyicals)
         {
            if(phyO != except && phyO.canCollided)
            {
               t = phyO.getCollideRect();
               t.offset(phyO.x,phyO.y);
               if(t.intersects(rect))
               {
                  temp.push(phyO);
               }
            }
         }
         return temp;
      }
      
      public function get isLackOfFPS() : Boolean
      {
         return _isLackOfFPS;
      }
      
      public function get mapMaxHeight() : Number
      {
         return Math.max(!!ground?ground.height:0,!!stone?stone.height:0);
      }
      
      public function drawPoint(data:Array, clear:Boolean, radius:Number = 2, color:uint = 16711680) : void
      {
         var i:int = 0;
         if(_drawPointContainer == null)
         {
            _drawPointContainer = new Sprite();
         }
         if(clear)
         {
            _drawPointContainer.graphics.clear();
         }
         i = 0;
         while(i < data.length)
         {
            _drawPointContainer.graphics.beginFill(color);
            _drawPointContainer.graphics.drawCircle(data[i].x,data[i].y,radius);
            _drawPointContainer.graphics.endFill();
            i++;
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
