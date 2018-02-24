package ddt.view.characterStarling
{
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.view.character.ICharacterLoader;
   import ddt.view.character.ShowCharacterLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   
   public class ShowCharacter3D extends BaseCharacter3D
   {
      
      public static const STAND:String = "stand";
      
      public static const WIN:String = "win";
      
      public static const LOST:String = "lost";
      
      public static const BIG_WIDTH:int = 250;
      
      public static const BIG_HEIGHT:int = 342;
       
      
      private var _showLight:Boolean;
      
      private var _lightPos:Point;
      
      private var _light1:BoneMovieStarling;
      
      private var _light2:BoneMovieStarling;
      
      private var _light01:BaseLightLayer3D;
      
      private var _light02:SinpleLightLayer3D;
      
      private var _loading:BoneMovieStarling;
      
      private var _wing:BoneMovieStarling;
      
      private var _staticBmp:Sprite;
      
      private var _showGun:Boolean;
      
      private var _characterWithWeapon:BitmapData;
      
      private var _characterWithoutWeapon:BitmapData;
      
      private var _currentAction:String;
      
      private var _recordNimbus:int;
      
      private var _needMultiFrame:Boolean;
      
      private var _showWing:Boolean = true;
      
      private var _playAnimation:Boolean = true;
      
      private var _wpCrtBmd:BitmapData;
      
      private var _winCrtBmd:BitmapData;
      
      public function ShowCharacter3D(param1:PlayerInfo, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false){super(null,null);}
      
      override protected function initEvent() : void{}
      
      private function __propertyChangeII(param1:PlayerPropertyEvent) : void{}
      
      override public function set showGun(param1:Boolean) : void{}
      
      override public function set showWing(param1:Boolean) : void{}
      
      override protected function initLoader() : void{}
      
      override public function set scaleX(param1:Number) : void{}
      
      override public function setShowLight(param1:Boolean, param2:Point = null) : void{}
      
      private function stopWing() : void{}
      
      public function stopAnimation() : void{}
      
      public function playAnimation() : void{}
      
      private function stopAllMoiveClip() : void{}
      
      private function playAllMoiveClip() : void{}
      
      private function restoreAnimationState() : void{}
      
      private function drawBitmapWithWingAndLight() : void{}
      
      override public function getShowBitmapBig() : *{return null;}
      
      override public function resetShowBitmapBig() : void{}
      
      private function updateLight() : void{}
      
      private function callBack01(param1:BaseLightLayer3D) : void{}
      
      private function callBack02(param1:SinpleLightLayer3D) : void{}
      
      private function updateCharacter() : void{}
      
      public function get characterWithWeapon() : BitmapData{return null;}
      
      override protected function setContent() : void{}
      
      public function get charaterWithoutWeapon() : BitmapData{return null;}
      
      public function get winCharater() : BitmapData{return null;}
      
      private function updateWing() : void{}
      
      private function sortIndex() : void{}
      
      public function removeWing() : void{}
      
      override protected function __loadComplete(param1:ICharacterLoader) : void{}
      
      override public function doAction(param1:*) : void{}
      
      override protected function initSizeAndPics() : void{}
      
      override public function show(param1:Boolean = true, param2:int = 1, param3:Boolean = true) : void{}
      
      override public function showWithSize(param1:Boolean = true, param2:int = 1, param3:Number = 120, param4:Number = 165) : void{}
      
      override public function get currentAction() : *{return null;}
      
      override public function dispose() : void{}
   }
}
