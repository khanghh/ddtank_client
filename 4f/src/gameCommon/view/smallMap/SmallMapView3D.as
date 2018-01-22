package gameCommon.view.smallMap
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.MissionInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameStarling.animations.DragMapAnimation;
   import gameStarling.view.map.MapView3D;
   import phy.object.SmallObject;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   
   public class SmallMapView3D extends Sprite implements Disposeable
   {
      
      private static const NUMBERS_ARR:Array = ["tank.game.smallmap.ShineNumber1","tank.game.smallmap.ShineNumber2","tank.game.smallmap.ShineNumber3","tank.game.smallmap.ShineNumber4","tank.game.smallmap.ShineNumber5","tank.game.smallmap.ShineNumber6","tank.game.smallmap.ShineNumber7","tank.game.smallmap.ShineNumber8","tank.game.smallmap.ShineNumber9"];
      
      public static var MAX_WIDTH:int = 165;
      
      public static var MIN_WIDTH:int = 120;
      
      public static const HARD_LEVEL:Array = [LanguageMgr.GetTranslation("tank.game.smallmap.simple"),LanguageMgr.GetTranslation("tank.game.smallmap.normal"),LanguageMgr.GetTranslation("tank.game.smallmap.difficulty"),LanguageMgr.GetTranslation("tank.game.smallmap.hero"),LanguageMgr.GetTranslation("tank.room.difficulty.nightmare"),LanguageMgr.GetTranslation("tank.room.difficulty.epic")];
      
      public static const HARD_LEVEL1:Array = [LanguageMgr.GetTranslation("tank.game.smallmap.simple1"),LanguageMgr.GetTranslation("tank.game.smallmap.normal1"),LanguageMgr.GetTranslation("tank.game.smallmap.difficulty1")];
      
      public static const STAR_HARD_LEVEL:Array = LanguageMgr.GetTranslation("cryptBoss.setFrame.hardLevelTxt").split(",");
       
      
      private var _screen:Sprite;
      
      private var _foreMap:Sprite;
      
      private var _thingLayer:Sprite;
      
      private var _mapBorder:Sprite;
      
      private var _hardTxt:FilterFrameText;
      
      private var _line:Sprite;
      
      private var _smallMapContainerBg:Sprite;
      
      private var _mask:Shape;
      
      private var _foreMapMask:Shape;
      
      private var _changeScale:Number = 0.2;
      
      private var _locked:Boolean;
      
      private var _allowDrag:Boolean = true;
      
      private var _split:Sprite;
      
      private var _texts:Array;
      
      private var _screenMask:Sprite;
      
      private var _processer:ThingProcesser;
      
      private var _drawMatrix:Matrix;
      
      private var _lineRef:BitmapData;
      
      private var _foreground:Shape;
      
      private var _dragScreen:Sprite;
      
      private var _titleBar:SmallMapTitleBar;
      
      private var _Screen_X:int;
      
      private var _Screen_Y:int;
      
      private var _mapBmp:Bitmap;
      
      private var _mapDeadBmp:Bitmap;
      
      private var _rateX:Number;
      
      private var _map:MapView3D;
      
      private var _skew:int;
      
      private var _rateY:Number;
      
      private var _missionInfo:MissionInfo;
      
      private var _w:int;
      
      private var _h:int;
      
      private var _groundShape:Sprite;
      
      private var _beadShape:Shape;
      
      private var _startDrag:Boolean = false;
      
      private var _child:Dictionary;
      
      private var _update:Boolean;
      
      private var _allLivings:DictionaryData;
      
      private var _collideRect:Rectangle;
      
      private var _drawRoute:Sprite;
      
      public function SmallMapView3D(param1:MapView3D, param2:MissionInfo){super();}
      
      public function set locked(param1:Boolean) : void{}
      
      public function get locked() : Boolean{return false;}
      
      public function set allowDrag(param1:Boolean) : void{}
      
      public function get rateX() : Number{return 0;}
      
      public function get rateY() : Number{return 0;}
      
      public function get smallMapW() : Number{return 0;}
      
      public function get smallMapH() : Number{return 0;}
      
      public function setHardLevel(param1:int, param2:int = 0) : void{}
      
      public function setBarrier(param1:int, param2:int) : void{}
      
      private function initView() : void{}
      
      public function get __StartDrag() : Boolean{return false;}
      
      private function drawBackground() : void{}
      
      private function drawForeground() : void{}
      
      private function drawRandomForeground() : void{}
      
      public function get foreMap() : Sprite{return null;}
      
      private function initViewAsset() : void{}
      
      private function updateSpliter() : void{}
      
      public function ShineText(param1:int) : void{}
      
      private function drawMask() : void{}
      
      private function clearMask() : void{}
      
      private function large() : void{}
      
      public function restore() : void{}
      
      public function restoreText() : void{}
      
      private function shineText(param1:int) : void{}
      
      public function showSpliter() : void{}
      
      public function hideSpliter() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvents() : void{}
      
      private function __mouseDown(param1:MouseEvent) : void{}
      
      private function __mouseUp(param1:MouseEvent) : void{}
      
      public function get screen() : Sprite{return null;}
      
      public function get screenX() : int{return 0;}
      
      public function get screenY() : int{return 0;}
      
      private function __mouseMove(param1:MouseEvent) : void{}
      
      private function __onEnterFrame(param1:Event) : void{}
      
      public function update() : void{}
      
      private function drawDead(param1:Boolean = false) : void{}
      
      public function draw(param1:Boolean = false) : void{}
      
      public function setScreenPos(param1:Number, param2:Number) : void{}
      
      public function addObj(param1:SmallObject) : void{}
      
      public function removeObj(param1:SmallObject) : void{}
      
      public function updatePos(param1:SmallObject, param2:Point) : void{}
      
      public function addAnimation(param1:SmallObject) : void{}
      
      public function removeAnimation(param1:SmallObject) : void{}
      
      public function dispose() : void{}
      
      private function __largeMap(param1:MouseEvent) : void{}
      
      private function __smallMap(param1:MouseEvent) : void{}
      
      private function updateChildPos(param1:Number, param2:Number) : void{}
      
      private function __click(param1:MouseEvent) : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      public function moveToPlayer() : void{}
      
      public function get titleBar() : SmallMapTitleBar{return null;}
      
      public function set enableExit(param1:Boolean) : void{}
      
      public function drawRouteLine(param1:int) : void{}
      
      private function drawDashed(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:Number) : void{}
   }
}

import com.pickgliss.toplevel.StageReferance;
import flash.events.Event;
import flash.utils.getTimer;
import phy.object.SmallObject;

class ThingProcesser
{
    
   
   private var _objectList:Vector.<SmallObject>;
   
   private var _startuped:Boolean = false;
   
   private var _lastTime:int = 0;
   
   function ThingProcesser(){super();}
   
   public function addThing(param1:SmallObject) : void{}
   
   public function removeThing(param1:SmallObject) : void{}
   
   public function startup() : void{}
   
   private function __onFrame(param1:Event) : void{}
   
   public function shutdown() : void{}
   
   public function dispose() : void{}
}
