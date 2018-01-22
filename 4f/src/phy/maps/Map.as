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
      
      public function Map(param1:DisplayObject, param2:Ground = null, param3:Ground = null, param4:DisplayObject = null){super();}
      
      public function get bound() : Rectangle{return null;}
      
      public function get sky() : DisplayObject{return null;}
      
      public function get mapThingLayer() : DisplayObjectContainer{return null;}
      
      public function get ground() : Ground{return null;}
      
      public function get stone() : Ground{return null;}
      
      public function get particleEnginee() : ParticleEnginee{return null;}
      
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
      
      public function findXYLineNotEmptyPoint(param1:int, param2:int, param3:int, param4:int, param5:int) : Point{return null;}
      
      public function findLineByRect(param1:int, param2:int, param3:String, param4:int, param5:int) : Point{return null;}
      
      public function canMove(param1:int, param2:int) : Boolean{return false;}
      
      public function IsOutMap(param1:int, param2:int) : Boolean{return false;}
      
      public function addPhysical(param1:Physics) : void{}
      
      public function addToPhyLayer(param1:DisplayObject) : void{}
      
      public function get livngLayer() : DisplayObjectContainer{return null;}
      
      public function addMapThing(param1:Physics) : void{}
      
      public function removeMapThing(param1:Physics) : void{}
      
      public function setTopPhysical(param1:Physics) : void{}
      
      public function hasSomethingMoving() : Boolean{return false;}
      
      public function removePhysical(param1:Physics) : void{}
      
      public function hidePhysical(param1:PhysicalObj) : void{}
      
      public function showPhysical() : void{}
      
      public function getIsCollideObj() : Array{return null;}
      
      public function getPhysicalById(param1:int) : PhysicalObj{return null;}
      
      public function getPhysicalObjects(param1:Rectangle, param2:PhysicalObj) : Array{return null;}
      
      public function getSceneEffectPhysicalObject(param1:Rectangle, param2:PhysicalObj, param3:Point = null) : PhysicalObj{return null;}
      
      public function getSceneEffectPhysicalObjectCircle(param1:Rectangle, param2:PhysicalObj) : PhysicalObj{return null;}
      
      public function getSceneEffectPhysicalById(param1:int) : PhysicalObj{return null;}
      
      public function getPhysicalObjectByPoint(param1:Point, param2:Number, param3:PhysicalObj = null) : Array{return null;}
      
      public function dieSceneEffectLayer() : void{}
      
      public function clearSceneEffectLayer() : void{}
      
      public function getBoxesByRect(param1:Rectangle) : Array{return null;}
      
      private function __enterFrame(param1:Event) : void{}
      
      protected function update() : void{}
      
      private function checkOverFrameRate() : void{}
      
      public function getCollidedPhysicalObjects(param1:Rectangle, param2:PhysicalObj) : Array{return null;}
      
      public function get isLackOfFPS() : Boolean{return false;}
      
      public function get mapMaxHeight() : Number{return 0;}
      
      public function drawPoint(param1:Array, param2:Boolean, param3:Number = 2, param4:uint = 16711680) : void{}
      
      public function dispose() : void{}
   }
}
