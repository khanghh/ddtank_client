package ddt.view.character
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.view.characterStarling.GameCharacter3DLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.IDisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BaseCharacter extends Sprite implements ICharacter, IDisplayObject, Disposeable
   {
      
      public static const BASE_WIDTH:int = 120;
      
      public static const BASE_HEIGHT:int = 165;
      
      public static const MOUSE_ON_GLOW_FILTER:Array = [new GlowFilter(16776960,1,8,8,2,2)];
       
      
      protected var _info:PlayerInfo;
      
      protected var _frames:Array;
      
      protected var _loader:ICharacterLoader;
      
      protected var _characterWidth:Number;
      
      protected var _characterHeight:Number;
      
      protected var _factory:ICharacterLoaderFactory;
      
      protected var _dir:int;
      
      protected var _container:Sprite;
      
      protected var _body:Bitmap;
      
      protected var _currentframe:int;
      
      protected var _loadCompleted:Boolean;
      
      protected var _picLines:int;
      
      protected var _picsPerLine:int;
      
      private var _autoClearLoader:Boolean;
      
      protected var _characterBitmapdata:BitmapData;
      
      protected var _bitmapChanged:Boolean;
      
      private var _lifeUpdate:Boolean;
      
      private var _disposed:Boolean;
      
      public function BaseCharacter(param1:PlayerInfo, param2:Boolean){super();}
      
      public function get characterWidth() : Number{return 0;}
      
      public function get characterHeight() : Number{return 0;}
      
      protected function init() : void{}
      
      protected function initSizeAndPics() : void{}
      
      protected function initEvent() : void{}
      
      private function __addToStage(param1:Event) : void{}
      
      private function __removeFromStage(param1:Event) : void{}
      
      private function __enterFrame(param1:Event) : void{}
      
      public function update() : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      protected function setCharacterSize(param1:Number, param2:Number) : void{}
      
      protected function setPicNum(param1:int, param2:int) : void{}
      
      public function setColor(param1:*) : Boolean{return false;}
      
      public function get info() : PlayerInfo{return null;}
      
      public function get currentFrame() : int{return 0;}
      
      public function set characterBitmapdata(param1:BitmapData) : void{}
      
      public function get characterBitmapdata() : BitmapData{return null;}
      
      public function get completed() : Boolean{return false;}
      
      public function getCharacterLoadLog() : String{return null;}
      
      public function doAction(param1:*) : void{}
      
      public function setDefaultAction(param1:*) : void{}
      
      public function setCharacterFilter(param1:Boolean) : void{}
      
      public function show(param1:Boolean = true, param2:int = 1, param3:Boolean = true) : void{}
      
      protected function __loadComplete(param1:ICharacterLoader) : void{}
      
      protected function setContent() : void{}
      
      public function setFactory(param1:ICharacterLoaderFactory) : void{}
      
      protected function initLoader() : void{}
      
      public function drawFrame(param1:int, param2:int = 0, param3:Boolean = true) : void{}
      
      protected function createFrames() : void{}
      
      public function set smoothing(param1:Boolean) : void{}
      
      public function set showGun(param1:Boolean) : void{}
      
      public function set showWing(param1:Boolean) : void{}
      
      public function setShowLight(param1:Boolean, param2:Point = null) : void{}
      
      public function get currentAction() : *{return null;}
      
      public function actionPlaying() : Boolean{return false;}
      
      public function showWithSize(param1:Boolean = true, param2:int = 1, param3:Number = 120, param4:Number = 165) : void{}
      
      public function resetShowBitmapBig() : void{}
      
      public function getShowBitmapBig() : *{return null;}
      
      public function dispose() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
