package ddt.view.character{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.ItemManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.DisplayObjectContainer;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.geom.Point;   import flash.geom.Rectangle;      public class ShowCharacter extends BaseCharacter   {            public static const STAND:String = "stand";            public static const WIN:String = "win";            public static const LOST:String = "lost";            public static const BIG_WIDTH:int = 250;            public static const BIG_HEIGHT:int = 342;                   private var _showLight:Boolean;            private var _lightPos:Point;            private var _light1:MovieClip;            private var _light2:MovieClip;            private var _light01:BaseLightLayer;            private var _light02:SinpleLightLayer;            private var _loading:MovieClip;            private var _showGun:Boolean;            private var _characterWithWeapon:BitmapData;            private var _characterWithoutWeapon:BitmapData;            private var _wing:MovieClip;            private var _staticBmp:Sprite;            private var _currentAction:String;            private var _recordNimbus:int;            private var _needMultiFrame:Boolean;            private var _showWing:Boolean = true;            private var _playAnimation:Boolean = true;            private var _wpCrtBmd:BitmapData;            private var _winCrtBmd:BitmapData;            public function ShowCharacter(info:PlayerInfo, $showGun:Boolean = true, $showLight:Boolean = true, needMultiFrame:Boolean = false) { super(null,null); }
            override protected function initEvent() : void { }
            private function __propertyChangeII(evt:PlayerPropertyEvent) : void { }
            override public function set showGun(value:Boolean) : void { }
            override public function set showWing(value:Boolean) : void { }
            override protected function initLoader() : void { }
            override public function set scaleX(value:Number) : void { }
            override public function setShowLight(b:Boolean, p:Point = null) : void { }
            private function stopMovieClip(mc:MovieClip) : void { }
            private function playMovieClip(mc:MovieClip) : void { }
            private function stopWing() : void { }
            public function stopAnimation() : void { }
            public function playAnimation() : void { }
            private function stopAllMoiveClip() : void { }
            private function playAllMoiveClip() : void { }
            private function restoreAnimationState() : void { }
            private function drawBitmapWithWingAndLight() : void { }
            override public function getShowBitmapBig() : * { return null; }
            override public function resetShowBitmapBig() : void { }
            private function updateLight() : void { }
            private function callBack01($load:BaseLightLayer) : void { }
            private function callBack02($load:SinpleLightLayer) : void { }
            private function updateCharacter() : void { }
            public function get characterWithWeapon() : BitmapData { return null; }
            override protected function setContent() : void { }
            public function get charaterWithoutWeapon() : BitmapData { return null; }
            public function get winCharater() : BitmapData { return null; }
            private function updateWing() : void { }
            private function sortIndex() : void { }
            public function removeWing() : void { }
            override protected function __loadComplete(loader:ICharacterLoader) : void { }
            override public function doAction(actionType:*) : void { }
            override protected function initSizeAndPics() : void { }
            override public function show(clearLoader:Boolean = true, dir:int = 1, small:Boolean = true) : void { }
            override public function showWithSize(clearLoader:Boolean = true, dir:int = 1, width:Number = 120, height:Number = 165) : void { }
            override public function get currentAction() : * { return null; }
            override public function dispose() : void { }
   }}