package starlingPhy.maps{   import com.pickgliss.utils.StarlingObjectUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.getTimer;   import road7th.data.DictionaryData;   import starling.display.DisplayObject;   import starling.display.Sprite;   import starling.events.Event;   import starlingPhy.object.PhysicalObj3D;   import starlingPhy.object.Physics3D;      public class Map3D extends Sprite   {            private static var FRAME_TIME_OVER_TAG:int;            private static var FRAME_OVER_COUNT_TAG:int;                   public var wind:Number = 3;            public var windRate:Number = 1;            public var gravity:Number = 9.8;            public var airResistance:Number = 2;            private var _objects:DictionaryData;            private var _phyicals:DictionaryData;            private var _bound:Rectangle;            protected var _bg:Sprite;            protected var _sky:DisplayObject;            protected var _stone:Ground3D;            protected var _ground:Ground3D;            protected var _real:Ground3D;            protected var _sceneEffectLayer:Sprite;            protected var _livingLayer:Sprite;            protected var _phyLayer:Sprite;            protected var _mapThing:Sprite;            private var _lastCheckTime:int = 0;            private var _frameTimeOverCount:int = 0;            protected var _mapChanged:Boolean = false;            private var _isLackOfFPS:Boolean = false;            private var _drawPointContainer:Sprite;            public function Map3D(sky:DisplayObject, ground:Ground3D = null, stone:Ground3D = null, real:Ground3D = null) { super(); }
            public function get bound() : Rectangle { return null; }
            public function get sky() : DisplayObject { return null; }
            public function get mapThingLayer() : Sprite { return null; }
            public function get ground() : Ground3D { return null; }
            public function get stone() : Ground3D { return null; }
            public function get real() : Ground3D { return null; }
            public function get bg() : Sprite { return null; }
            public function Dig(center:Point, surface:Bitmap, border:Bitmap = null) : void { }
            public function get mapChanged() : Boolean { return false; }
            public function resetMapChanged() : void { }
            public function IsEmpty(x:int, y:int) : Boolean { return false; }
            public function IsRectangleEmpty(rect:Rectangle) : Boolean { return false; }
            public function IsCircleEmpty(rect:Rectangle, rAngle:Number = 30) : Boolean { return false; }
            public function IsBitmapDataEmpty(bitmapData:BitmapData, bitmapPoint:Point = null) : Boolean { return false; }
            public function findYLineNotEmptyPointDown(x:int, y:int, h:int) : Point { return null; }
            public function findYLineNotEmptyPointUp(x:int, y:int, h:int) : Point { return null; }
            public function findNextWalkPoint(posX:int, posY:int, direction:int, stepX:int, stepY:int) : Point { return null; }
            public function findNextWalkBombPoint(posX:int, posY:int, direction:int, stepX:int, stepY:int) : Point { return null; }
            public function canMove(x:int, y:int) : Boolean { return false; }
            public function IsOutMap(x:int, y:int) : Boolean { return false; }
            public function addPhysical(phyobj:Physics3D) : void { }
            public function addToPhyLayer(b:DisplayObject) : void { }
            public function get livngLayer() : Sprite { return null; }
            public function addMapThing(phyS:Physics3D) : void { }
            public function removeMapThing(phyS:Physics3D) : void { }
            public function setTopPhysical($phy:Physics3D) : void { }
            public function hasSomethingMoving() : Boolean { return false; }
            public function removePhysical(phyO:Physics3D) : void { }
            public function hidePhysical(except:PhysicalObj3D) : void { }
            public function showPhysical() : void { }
            public function getPhysicalById(id:int) : PhysicalObj3D { return null; }
            public function getPhysicalObjects(rect:Rectangle, except:PhysicalObj3D) : Array { return null; }
            public function getSceneEffectPhysicalObject(rect:Rectangle, except:PhysicalObj3D, prePos:Point = null) : PhysicalObj3D { return null; }
            public function getSceneEffectPhysicalObjectCircle(rect:Rectangle, except:PhysicalObj3D) : PhysicalObj3D { return null; }
            public function getSceneEffectPhysicalById(id:int) : PhysicalObj3D { return null; }
            public function getPhysicalObjectByPoint(point:Point, radius:Number, except:PhysicalObj3D = null) : Array { return null; }
            public function dieSceneEffectLayer() : void { }
            public function clearSceneEffectLayer() : void { }
            public function getBoxesByRect(rect:Rectangle) : Array { return null; }
            private function __enterFrame(event:Event) : void { }
            protected function update() : void { }
            private function checkOverFrameRate() : void { }
            public function getCollidedPhysicalObjects(rect:Rectangle, except:PhysicalObj3D) : Array { return null; }
            public function get isLackOfFPS() : Boolean { return false; }
            public function get mapMaxHeight() : Number { return 0; }
            public function drawPoint(data:Array, clear:Boolean, radius:Number = 2, color:uint = 16711680) : void { }
            override public function dispose() : void { }
   }}