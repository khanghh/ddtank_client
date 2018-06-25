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
   import phy.math.PhysicalObjMovePosInfo;
   import phy.object.PhysicalObj;
   import phy.object.Physics;
   import road7th.data.DictionaryData;
   
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
      
      private var _canWalkPosDic:DictionaryData;
      
      protected var _mapChanged:Boolean = false;
      
      private var _isLackOfFPS:Boolean = false;
      
      private var _drawPointContainer:Sprite;
      
      public function Map(sky:DisplayObject, ground:Ground = null, stone:Ground = null, middle:DisplayObject = null)
      {
         super();
         _phyicals = new Dictionary();
         _objects = new Dictionary();
         _canWalkPosDic = new DictionaryData();
         _sky = sky;
         addChild(_sky);
         graphics.beginFill(0,1);
         graphics.drawRect(0,0,_sky.width * 1.5,_sky.height * 1.5);
         graphics.endFill();
         _stone = stone;
         _middle = middle;
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
         _ground = ground;
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
         var rd:DisplayObjectRenderer = new DisplayObjectRenderer();
         _phyLayer.addChild(rd);
         _partical = new ParticleEnginee(rd);
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
      
      public function addWalkPos(name:String, posInfo:PhysicalObjMovePosInfo) : void
      {
         _canWalkPosDic.add(name,posInfo);
      }
      
      public function resetMapChanged() : void
      {
         _mapChanged = false;
      }
      
      public function IsEmpty(x:int, y:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:* = _canWalkPosDic;
         for each(var obj in _canWalkPosDic)
         {
            if(obj.isIntersect(x,y))
            {
               return false;
            }
         }
         return (_ground == null || _ground.IsEmpty(x,y)) && (_stone == null || _stone.IsEmpty(x,y));
      }
      
      public function IsRectangleEmpty(rect:Rectangle) : Boolean
      {
         return (_ground == null || _ground.IsRectangeEmptyQuick(rect)) && (_stone == null || _stone.IsRectangeEmptyQuick(rect));
      }
      
      public function IsCircleEmpty(rect:Rectangle, rAngle:Number = 30) : Boolean
      {
         return (_ground == null || _ground.IsCircleEmptyQuick(rect,rAngle)) && (_stone == null || _stone.IsCircleEmptyQuick(rect,rAngle));
      }
      
      public function IsBitmapDataEmpty(bitmapData:BitmapData, bitmapPoint:Point = null) : Boolean
      {
         return (_ground == null || _ground.IsBitmapDataEmpty(bitmapData,bitmapPoint)) && (_stone == null || _stone.IsBitmapDataEmpty(bitmapData,bitmapPoint));
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
      
      public function findXYLineNotEmptyPoint(posX:int, posY:int, direction:int, stepX:int, stepY:int) : Point
      {
         var p:* = null;
         var i:int = 0;
         if(direction != 1 && direction != -1)
         {
            return null;
         }
         var left:Boolean = IsEmpty(posX - 1,posY);
         var right:Boolean = IsEmpty(posX + 1,posY);
         var top:Boolean = IsEmpty(posX,posY - 1);
         var bottom:Boolean = IsEmpty(posX,posY + 1);
         trace((!!left?"":"!") + "left && " + (!!right?"":"!") + "right && " + (!!top?"":"!") + "top && " + (!!bottom?"":"!") + "bottom");
         var dirs:Array = [];
         if(left && right && top && bottom)
         {
            dirs.push("rt");
            dirs.push("lt");
            dirs.push("rb");
            dirs.push("lb");
         }
         else if(!left && !right && !top && !bottom)
         {
            dirs.push("rt");
            dirs.push("lt");
            dirs.push("rb");
            dirs.push("lb");
         }
         else if(left && !right && top && !bottom)
         {
            if(direction == 1)
            {
               dirs.push("rt");
            }
            else
            {
               dirs.push("lb");
            }
         }
         else if(left && !right && top && bottom)
         {
            if(direction == 1)
            {
               dirs.push("lt");
               dirs.push("rt");
            }
            else
            {
               dirs.push("rb");
            }
         }
         else if(!left && !right && top && !bottom)
         {
            if(direction == 1)
            {
               dirs.push("rt");
            }
            else
            {
               dirs.push("lt");
            }
         }
         else if(left && right && top && !bottom)
         {
            if(direction == 1)
            {
               dirs.push("rt");
               dirs.push("rb");
            }
            else
            {
               dirs.push("lt");
               dirs.push("lb");
            }
         }
         else if(!left && right && top && !bottom)
         {
            if(direction == 1)
            {
               dirs.push("rb");
            }
            else
            {
               dirs.push("lt");
            }
         }
         else if(!left && right && top && bottom)
         {
            if(direction == 1)
            {
               dirs.push("rb");
               dirs.push("lb");
            }
            else
            {
               dirs.push("lt");
            }
         }
         else if(!left && right && !top && bottom)
         {
            if(direction == 1)
            {
               dirs.push("lb");
            }
            else
            {
               dirs.push("rt");
            }
         }
         else if(!left && !right && !top && bottom)
         {
            if(direction == 1)
            {
               dirs.push("lt");
               dirs.push("lb");
            }
            else
            {
               dirs.push("rb");
            }
         }
         else if(left && right && !top && bottom)
         {
            if(direction == 1)
            {
               dirs.push("lt");
               dirs.push("lb");
            }
            else
            {
               dirs.push("rt");
            }
         }
         else if(left && !right && !top && bottom)
         {
            if(direction == 1)
            {
               dirs.push("lt");
            }
            else
            {
               dirs.push("rb");
            }
         }
         else if(left && !right && !top && !bottom)
         {
            if(direction == 1)
            {
               dirs.push("rt");
               dirs.push("lt");
            }
            else
            {
               dirs.push("lb");
            }
         }
         else if(!left && right && !top && !bottom)
         {
            if(direction == 1)
            {
               dirs.push("rb");
               dirs.push("rt");
            }
            else
            {
               dirs.push("rt");
            }
         }
         else if(left && right && top && bottom)
         {
            if(direction == 1)
            {
               dirs.push("rb");
            }
            else
            {
               dirs.push("lt");
            }
         }
         i = 0;
         while(i < dirs.length)
         {
            p = findLineByRect(posX,posY,dirs[i],stepX,stepY);
            if(!p)
            {
               i++;
               continue;
            }
            break;
         }
         if(p)
         {
            if(p.x <= 0 || p.x >= _bound.width)
            {
               return null;
            }
            if(p.y <= 0 || p.y >= _bound.height)
            {
               return null;
            }
         }
         return p;
      }
      
      public function findLineByRect(posX:int, posY:int, dir:String, stepX:int, stepY:int) : Point
      {
         var p:* = null;
         var i:* = 0;
         var j:* = 0;
         var tx:int = 0;
         var ty:int = 0;
         var left:Boolean = false;
         var right:Boolean = false;
         var top:Boolean = false;
         var bottom:Boolean = false;
         var xDir:int = 1;
         var yDir:int = 1;
         if(dir == "lt")
         {
            xDir = -1;
            yDir = -1;
         }
         else if(dir == "rt")
         {
            xDir = 1;
            yDir = -1;
         }
         else if(dir == "lb")
         {
            xDir = -1;
            yDir = 1;
         }
         else if(dir == "rb")
         {
            xDir = 1;
            yDir = 1;
         }
         loop0:
         for(i = stepX; i > 0; )
         {
            tx = posX + i * xDir;
            ty = posY + stepY * yDir;
            for(j = stepY; j > 0; )
            {
               left = IsEmpty(tx - 1,ty);
               right = IsEmpty(tx + 1,ty);
               top = IsEmpty(tx,ty - 1);
               bottom = IsEmpty(tx,ty + 1);
               if(!left || !right || !top || !bottom)
               {
                  if(!(!left && !right && !top && !bottom))
                  {
                     p = new Point(tx,ty);
                     break loop0;
                  }
               }
               ty = ty - 1 * yDir;
               j--;
            }
            tx = tx - 1 * xDir;
            i--;
         }
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
      
      public function addPhysical(phyobj:Physics) : void
      {
         if(phyobj is PhysicalObj)
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
         else
         {
            _objects[phyobj] = phyobj;
            addChild(phyobj);
         }
         phyobj.setMap(this);
      }
      
      public function addToPhyLayer(b:DisplayObject) : void
      {
         _phyLayer.addChild(b);
      }
      
      public function get livngLayer() : DisplayObjectContainer
      {
         return _livingLayer;
      }
      
      public function addMapThing(phyS:Physics) : void
      {
         _mapThing.addChild(phyS);
         phyS.setMap(this);
         if(phyS is PhysicalObj)
         {
            _phyicals[phyS] = phyS;
         }
         else
         {
            _objects[phyS] = phyS;
         }
      }
      
      public function removeMapThing(phyS:Physics) : void
      {
         _mapThing.removeChild(phyS);
         phyS.setMap(null);
         if(phyS is PhysicalObj)
         {
            delete _phyicals[phyS];
         }
         else
         {
            delete _objects[phyS];
         }
      }
      
      public function setTopPhysical($phy:Physics) : void
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
      
      public function removePhysical(phyO:Physics) : void
      {
         if(phyO.parent)
         {
            phyO.parent.removeChild(phyO);
         }
         phyO.setMap(null);
         if(phyO is PhysicalObj)
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
      }
      
      public function hidePhysical(except:PhysicalObj) : void
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
      
      public function getIsCollideObj() : Array
      {
         var temp:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _phyicals;
         for each(var phyO in _phyicals)
         {
            if(phyO.isLiving && phyO.IsCollide)
            {
               temp.push(phyO);
            }
         }
         return temp;
      }
      
      public function getPhysicalById(id:int) : PhysicalObj
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
      
      public function getPhysicalObjects(rect:Rectangle, except:PhysicalObj) : Array
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
      
      public function getSceneEffectPhysicalObject(rect:Rectangle, except:PhysicalObj, prePos:Point = null) : PhysicalObj
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
      
      public function getSceneEffectPhysicalObjectCircle(rect:Rectangle, except:PhysicalObj) : PhysicalObj
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
      
      public function getSceneEffectPhysicalById(id:int) : PhysicalObj
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
      
      public function getPhysicalObjectByPoint(point:Point, radius:Number, except:PhysicalObj = null) : Array
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
               phyO = _sceneEffectLayer.getChildAt(i) as PhysicalObj;
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
               phyO = _sceneEffectLayer.getChildAt(i) as PhysicalObj;
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
         _partical.update();
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
      
      public function getCollidedPhysicalObjects(rect:Rectangle, except:PhysicalObj) : Array
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
      
      public function dispose() : void
      {
         var i:int = 0;
         var obj:* = null;
         removeEventListener("enterFrame",__enterFrame);
         var num:Number = numChildren;
         for(i = num - 1; i >= 0; )
         {
            obj = getChildAt(i);
            if(obj is Physics)
            {
               Physics(obj).dispose();
            }
            i--;
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
         if(_canWalkPosDic)
         {
            _canWalkPosDic.clear();
         }
         _canWalkPosDic = null;
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
