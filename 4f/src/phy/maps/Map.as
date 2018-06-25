package phy.maps{   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import flash.utils.getTimer;   import par.enginees.ParticleEnginee;   import par.renderer.DisplayObjectRenderer;   import phy.math.PhysicalObjMovePosInfo;   import phy.object.PhysicalObj;   import phy.object.Physics;   import road7th.data.DictionaryData;      public class Map extends Sprite   {            private static var FRAME_TIME_OVER_TAG:int;            private static var FRAME_OVER_COUNT_TAG:int;                   public var wind:Number = 3;            public var windRate:Number = 1;            public var gravity:Number = 9.8;            public var airResistance:Number = 2;            private var _objects:Dictionary;            private var _phyicals:Dictionary;            private var _bound:Rectangle;            private var _partical:ParticleEnginee;            protected var _sky:DisplayObject;            protected var _stone:Ground;            protected var _middle:DisplayObject;            protected var _ground:Ground;            protected var _sceneEffectLayer:Sprite;            protected var _livingLayer:Sprite;            protected var _phyLayer:Sprite;            protected var _mapThing:Sprite;            private var _lastCheckTime:int = 0;            private var _frameTimeOverCount:int = 0;            private var _canWalkPosDic:DictionaryData;            protected var _mapChanged:Boolean = false;            private var _isLackOfFPS:Boolean = false;            private var _drawPointContainer:Sprite;            public function Map(sky:DisplayObject, ground:Ground = null, stone:Ground = null, middle:DisplayObject = null) { super(); }
            public function get bound() : Rectangle { return null; }
            public function get sky() : DisplayObject { return null; }
            public function get mapThingLayer() : DisplayObjectContainer { return null; }
            public function get ground() : Ground { return null; }
            public function get stone() : Ground { return null; }
            public function get particleEnginee() : ParticleEnginee { return null; }
            public function Dig(center:Point, surface:Bitmap, border:Bitmap = null) : void { }
            public function get mapChanged() : Boolean { return false; }
            public function addWalkPos(name:String, posInfo:PhysicalObjMovePosInfo) : void { }
            public function resetMapChanged() : void { }
            public function IsEmpty(x:int, y:int) : Boolean { return false; }
            public function IsRectangleEmpty(rect:Rectangle) : Boolean { return false; }
            public function IsCircleEmpty(rect:Rectangle, rAngle:Number = 30) : Boolean { return false; }
            public function IsBitmapDataEmpty(bitmapData:BitmapData, bitmapPoint:Point = null) : Boolean { return false; }
            public function findYLineNotEmptyPointDown(x:int, y:int, h:int) : Point { return null; }
            public function findYLineNotEmptyPointUp(x:int, y:int, h:int) : Point { return null; }
            public function findNextWalkPoint(posX:int, posY:int, direction:int, stepX:int, stepY:int) : Point { return null; }
            public function findXYLineNotEmptyPoint(posX:int, posY:int, direction:int, stepX:int, stepY:int) : Point { return null; }
            public function findLineByRect(posX:int, posY:int, dir:String, stepX:int, stepY:int) : Point { return null; }
            public function canMove(x:int, y:int) : Boolean { return false; }
            public function IsOutMap(x:int, y:int) : Boolean { return false; }
            public function addPhysical(phyobj:Physics) : void { }
            public function addToPhyLayer(b:DisplayObject) : void { }
            public function get livngLayer() : DisplayObjectContainer { return null; }
            public function addMapThing(phyS:Physics) : void { }
            public function removeMapThing(phyS:Physics) : void { }
            public function setTopPhysical($phy:Physics) : void { }
            public function hasSomethingMoving() : Boolean { return false; }
            public function removePhysical(phyO:Physics) : void { }
            public function hidePhysical(except:PhysicalObj) : void { }
            public function showPhysical() : void { }
            public function getIsCollideObj() : Array { return null; }
            public function getPhysicalById(id:int) : PhysicalObj { return null; }
            public function getPhysicalObjects(rect:Rectangle, except:PhysicalObj) : Array { return null; }
            public function getSceneEffectPhysicalObject(rect:Rectangle, except:PhysicalObj, prePos:Point = null) : PhysicalObj { return null; }
            public function getSceneEffectPhysicalObjectCircle(rect:Rectangle, except:PhysicalObj) : PhysicalObj { return null; }
            public function getSceneEffectPhysicalById(id:int) : PhysicalObj { return null; }
            public function getPhysicalObjectByPoint(point:Point, radius:Number, except:PhysicalObj = null) : Array { return null; }
            public function dieSceneEffectLayer() : void { }
            public function clearSceneEffectLayer() : void { }
            public function getBoxesByRect(rect:Rectangle) : Array { return null; }
            private function __enterFrame(event:Event) : void { }
            protected function update() : void { }
            private function checkOverFrameRate() : void { }
            public function getCollidedPhysicalObjects(rect:Rectangle, except:PhysicalObj) : Array { return null; }
            public function get isLackOfFPS() : Boolean { return false; }
            public function get mapMaxHeight() : Number { return 0; }
            public function drawPoint(data:Array, clear:Boolean, radius:Number = 2, color:uint = 16711680) : void { }
            public function dispose() : void { }
   }}