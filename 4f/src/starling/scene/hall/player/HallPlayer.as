package starling.scene.hall.player
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import hall.event.NewHallEvent;
   import hall.player.vo.PlayerVO;
   import newTitle.NewTitleManager;
   import newTitle.model.NewTitleModel;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import road7th.StarlingMain;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.filters.BlurFilter;
   import starling.filters.FragmentFilter;
   import starling.scene.hall.event.NewHallEventStarling;
   import starling.text.TextField;
   import starlingui.core.text.TextLabel;
   
   public class HallPlayer extends HallPlayerBase
   {
      
      private static const HIT_WIDTH:int = 90;
      
      private static const HIT_HEIGHT:int = 140;
       
      
      protected var _playerVO:PlayerVO;
      
      private var _currentWalkStartPoint:Point;
      
      protected var _nameSprite:Sprite;
      
      private var _namePos:Point;
      
      protected var _titleSprite:Sprite;
      
      private var _titlePos:Point;
      
      private var _petFollow:BoneMovieFastStarling;
      
      private var _isHideTitle:Boolean;
      
      protected var _posTimer:Timer;
      
      private var _randomPathX:int;
      
      private var _randomPathY:int;
      
      private var _randomPathMap:Object;
      
      public function HallPlayer(param1:PlayerVO){super(null);}
      
      override protected function initialize() : void{}
      
      override protected function resetPlayerAsset() : void{}
      
      public function updatePlayer() : void{}
      
      private function updatePlayerWalk() : void{}
      
      public function updatePlayerLocal(param1:Point = null) : void{}
      
      public function updatePlayerName() : void{}
      
      public function updateTitle() : void{}
      
      public function get playerVO() : PlayerVO{return null;}
      
      override protected function __onTouch(param1:TouchEvent) : void{}
      
      public function get isHideTitle() : Boolean{return false;}
      
      public function set isHideTitle(param1:Boolean) : void{}
      
      override protected function __onStyleChange(param1:PlayerPropertyEvent) : void{}
      
      protected function updatePetsFollow() : void{}
      
      private function updatePetsFollowPos() : void{}
      
      private function removePetsFollow() : void{}
      
      override protected function changeCharacterDirection() : void{}
      
      override public function playerWalk(param1:Array) : void{}
      
      private function setPlayerDirection() : SceneCharacterDirection{return null;}
      
      public function stopWalk(param1:Boolean = true) : void{}
      
      private function playerWalkPath() : void{}
      
      private function fixPlayerPath() : void{}
      
      public function startRandomWalk(param1:int, param2:int, param3:Object) : void{}
      
      protected function onControlWalk(param1:TimerEvent) : void{}
      
      protected function getRandomDelayTime() : int{return 0;}
      
      private function getEndPointIndex(param1:int) : int{return 0;}
      
      private function getPointPath(param1:int, param2:int) : Array{return null;}
      
      public function get currentWalkStartPoint() : Point{return null;}
      
      override public function dispose() : void{}
   }
}
