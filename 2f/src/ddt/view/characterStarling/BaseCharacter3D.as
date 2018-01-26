package ddt.view.characterStarling
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.view.character.GameCharacterLoader;
   import ddt.view.character.ICharacter;
   import ddt.view.character.ICharacterLoader;
   import ddt.view.character.ICharacterLoaderFactory;
   import ddt.view.character.ShowCharacterLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public class BaseCharacter3D extends Sprite implements ICharacter, Disposeable
   {
      
      public static const BASE_WIDTH:int = 120;
      
      public static const BASE_HEIGHT:int = 165;
       
      
      protected var _info:PlayerInfo;
      
      protected var _frames:Array;
      
      protected var _loader:ICharacterLoader;
      
      protected var _characterWidth:Number;
      
      protected var _characterHeight:Number;
      
      protected var _factory:ICharacterLoaderFactory;
      
      protected var _dir:int;
      
      protected var _currentframe:int;
      
      protected var _loadCompleted:Boolean;
      
      protected var _picLines:int;
      
      protected var _picsPerLine:int;
      
      private var _autoClearLoader:Boolean;
      
      protected var _bitmapChanged:Boolean;
      
      protected var _container:Sprite;
      
      protected var _bodyImage:Image;
      
      protected var _body:Bitmap;
      
      protected var _characterBitmapdata:BitmapData;
      
      private var _lifeUpdate:Boolean;
      
      private var _disposed:Boolean;
      
      public function BaseCharacter3D(param1:PlayerInfo, param2:Boolean){super();}
      
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
      
      override public function dispose() : void{}
   }
}
