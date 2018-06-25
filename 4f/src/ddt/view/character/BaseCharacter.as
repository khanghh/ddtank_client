package ddt.view.character{   import com.pickgliss.ui.core.Disposeable;   import ddt.data.player.PlayerInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.view.characterStarling.GameCharacter3DLoader;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.IDisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.filters.GlowFilter;   import flash.geom.Point;   import flash.geom.Rectangle;      public class BaseCharacter extends Sprite implements ICharacter, IDisplayObject, Disposeable   {            public static const BASE_WIDTH:int = 120;            public static const BASE_HEIGHT:int = 165;            public static const MOUSE_ON_GLOW_FILTER:Array = [new GlowFilter(16776960,1,8,8,2,2)];                   protected var _info:PlayerInfo;            protected var _frames:Array;            protected var _loader:ICharacterLoader;            protected var _characterWidth:Number;            protected var _characterHeight:Number;            protected var _factory:ICharacterLoaderFactory;            protected var _dir:int;            protected var _container:Sprite;            protected var _body:Bitmap;            protected var _currentframe:int;            protected var _loadCompleted:Boolean;            protected var _picLines:int;            protected var _picsPerLine:int;            private var _autoClearLoader:Boolean;            protected var _characterBitmapdata:BitmapData;            protected var _bitmapChanged:Boolean;            private var _lifeUpdate:Boolean;            private var _disposed:Boolean;            public function BaseCharacter(info:PlayerInfo, lifeUpdate:Boolean) { super(); }
            public function get characterWidth() : Number { return 0; }
            public function get characterHeight() : Number { return 0; }
            protected function init() : void { }
            protected function initSizeAndPics() : void { }
            protected function initEvent() : void { }
            private function __addToStage(event:Event) : void { }
            private function __removeFromStage(event:Event) : void { }
            private function __enterFrame(event:Event) : void { }
            public function update() : void { }
            private function __propertyChange(evt:PlayerPropertyEvent) : void { }
            protected function setCharacterSize(w:Number, h:Number) : void { }
            protected function setPicNum(lines:int, perline:int) : void { }
            public function setColor(color:*) : Boolean { return false; }
            public function get info() : PlayerInfo { return null; }
            public function get currentFrame() : int { return 0; }
            public function set characterBitmapdata(value:BitmapData) : void { }
            public function get characterBitmapdata() : BitmapData { return null; }
            public function get completed() : Boolean { return false; }
            public function getCharacterLoadLog() : String { return null; }
            public function doAction(actionType:*) : void { }
            public function setDefaultAction(actionType:*) : void { }
            public function setCharacterFilter(value:Boolean) : void { }
            public function show(clearLoader:Boolean = true, dir:int = 1, small:Boolean = true) : void { }
            protected function __loadComplete(loader:ICharacterLoader) : void { }
            protected function setContent() : void { }
            public function setFactory(factory:ICharacterLoaderFactory) : void { }
            protected function initLoader() : void { }
            public function drawFrame(frame:int, type:int = 0, clearOld:Boolean = true) : void { }
            protected function createFrames() : void { }
            public function set smoothing(value:Boolean) : void { }
            public function set showGun(value:Boolean) : void { }
            public function set showWing(value:Boolean) : void { }
            public function setShowLight(b:Boolean, p:Point = null) : void { }
            public function get currentAction() : * { return null; }
            public function actionPlaying() : Boolean { return false; }
            public function showWithSize(clearLoader:Boolean = true, dir:int = 1, width:Number = 120, height:Number = 165) : void { }
            public function resetShowBitmapBig() : void { }
            public function getShowBitmapBig() : * { return null; }
            public function dispose() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}