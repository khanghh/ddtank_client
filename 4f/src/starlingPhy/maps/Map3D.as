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
      
      public function Map3D(param1:DisplayObject, param2:Ground3D = null, param3:Ground3D = null, param4:Ground3D = null){super();}
      
      public function get bound() : Rectangle{return null;}
      
      public function get sky() : DisplayObject{return null;}
      
      public function get mapThingLayer() : Sprite{return null;}
      
      public function get ground() : Ground3D{return null;}
      
      public function get stone() : Ground3D{return null;}
      
      public function get real() : Ground3D{return null;}
      
      public function get bg() : Sprite{return null;}
      
      public function Dig(param1:Point, param2:Bitmap, param3:Bitmap = null) : void{}
      
      public function get mapChanged() : Boolean{return false;}
      
      public function resetMapChanged() : void{}
      
      public function IsEmpty(param1:int, param2:int) : Boolean{return false;}
      
      public function IsRectangleEmpty(param1:Rectangle) : Boolean{return false;}
      
      public function IsCircleEmpty(param1:Rectangle, param2:Number = 30) : Boolean{return false;}
      
      public function IsBitmapDataEmpty(param1:BitmapData, param2:Point = null) : Boolean{return false;}
      
      public function findYLineNotEmptyPointDown(param1:int, param2:int, param3:int) : Point{return null;}
      
      public function findYLineNotEmptyPointUp(param1:int, param2:int, param3:int) : Point{return null;}
      
      public function findNextWalkPoint(param1:int, param2:int, param3:int, param4:int, param5:int) : Point{return null;}
      
      public function findNextWalkBombPoint(param1:int, param2:int, param3:int, param4:int, param5:int) : Point{return null;}
      
      public function canMove(param1:int, param2:int) : Boolean{return false;}
      
      public function IsOutMap(param1:int, param2:int) : Boolean{return false;}
      
      public function addPhysical(param1:Physics3D) : void{}
      
      public function addToPhyLayer(param1:DisplayObject) : void{}
      
      public function get livngLayer() : Sprite{return null;}
      
      public function addMapThing(param1:Physics3D) : void{}
      
      public function removeMapThing(param1:Physics3D) : void{}
      
      public function setTopPhysical(param1:Physics3D) : void{}
      
      public function hasSomethingMoving() : Boolean{return false;}
      
      public function removePhysical(param1:Physics3D) : void{}
      
      public function hidePhysical(param1:PhysicalObj3D) : void{}
      
      public function showPhysical() : void{}
      
      public function getPhysicalById(param1:int) : PhysicalObj3D{return null;}
      
      public function getPhysicalObjects(param1:Rectangle, param2:PhysicalObj3D) : Array{return null;}
      
      public function getSceneEffectPhysicalObject(param1:Rectangle, param2:PhysicalObj3D, param3:Point = null) : PhysicalObj3D{return null;}
      
      public function getSceneEffectPhysicalObjectCircle(param1:Rectangle, param2:PhysicalObj3D) : PhysicalObj3D{return null;}
      
      public function getSceneEffectPhysicalById(param1:int) : PhysicalObj3D{return null;}
      
      public function getPhysicalObjectByPoint(param1:Point, param2:Number, param3:PhysicalObj3D = null) : Array{return null;}
      
      public function dieSceneEffectLayer() : void{}
      
      public function clearSceneEffectLayer() : void{}
      
      public function getBoxesByRect(param1:Rectangle) : Array{return null;}
      
      private function __enterFrame(param1:Event) : void{}
      
      protected function update() : void{}
      
      private function checkOverFrameRate() : void{}
      
      public function getCollidedPhysicalObjects(param1:Rectangle, param2:PhysicalObj3D) : Array{return null;}
      
      public function get isLackOfFPS() : Boolean{return false;}
      
      public function get mapMaxHeight() : Number{return 0;}
      
      public function drawPoint(param1:Array, param2:Boolean, param3:Number = 2, param4:uint = 16711680) : void{}
      
      override public function dispose() : void{}
   }
}
