package gameStarling.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.data.BallInfo;
   import ddt.manager.BallManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import game.GameManager;
   import game.objects.BombAsset;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.model.SceneEffectObj;
   import gameCommon.view.smallMap.SmallBomb;
   import gameStarling.animations.PhysicalObjFocusAnimation;
   import gameStarling.animations.ShockMapAnimation;
   import gameStarling.view.map.MapView3D;
   import particleSystem.EmitterInfo;
   import particleSystem.ParticleManager;
   import particleSystem.ParticleRender;
   import particleSystem.ParticleRenderInfo;
   import phy.object.SmallObject;
   import road7th.utils.BoneMovieWrapper;
   import starlingPhy.bombs.BaseBomb3D;
   import starlingPhy.maps.Map3D;
   import starlingPhy.object.PhysicalObj3D;
   import starlingPhy.object.Physics3D;
   
   public class SimpleBomb3D extends BaseBomb3D
   {
       
      
      protected var _info:Bomb;
      
      protected var _lifeTime:int;
      
      protected var _owner:Living;
      
      protected var _particleRenderInfo:ParticleRenderInfo;
      
      protected var _spinV:Number;
      
      protected var _bulletEffects:Array;
      
      protected var _blastOutEffects:Array;
      
      protected var _isReplaceBullet:Boolean;
      
      protected var _sceneEffectCollideId:int;
      
      protected var _bullet:BoneMovieStarling;
      
      protected var _blastOut:BoneMovieStarling;
      
      protected var _crater:Bitmap;
      
      protected var _craterBrink:Bitmap;
      
      protected var _dir:int = 1;
      
      protected var _smallBall:SmallObject;
      
      protected var _game:GameInfo;
      
      protected var _bitmapNum:int;
      
      protected var _refineryLevel:int;
      
      protected var _isPhantom:Boolean;
      
      protected var fastModel:Boolean;
      
      private var _playBlastOutEffectTimer:Timer;
      
      private var _playBlastOutEffectCount:int;
      
      public function SimpleBomb3D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false){super(null,null,null,null,null);}
      
      public function get map() : MapView3D{return null;}
      
      public function get info() : Bomb{return null;}
      
      public function get owner() : Living{return null;}
      
      private function createBallAsset() : void{}
      
      protected function initMovie() : void{}
      
      override public function setMap(param1:Map3D) : void{}
      
      override public function startMoving() : void{}
      
      override public function get smallView() : SmallObject{return null;}
      
      override public function moveTo(param1:Point) : void{}
      
      public function needFocus() : void{}
      
      public function get movie() : BoneMovieStarling{return null;}
      
      protected function isPillarCollide() : Boolean{return false;}
      
      override protected function computeFallNextXY(param1:Number) : Point{return null;}
      
      public function get isFall() : Boolean{return false;}
      
      public function clearWG() : void{}
      
      override public function bomb() : void{}
      
      override public function bombAtOnce() : void{}
      
      protected function checkCreateBombSceneEffect() : void{}
      
      protected function removeBulletSceneEffect() : void{}
      
      private function playBlastOutEffects(param1:Number) : void{}
      
      private function _playBlastOutEffectTimerHandler(param1:TimerEvent) : void{}
      
      private function playBlastOutEffect(param1:Function) : void{}
      
      protected function removeBlastOutSceneEffect() : void{}
      
      override public function die() : void{}
      
      override protected function updatePosition(param1:Number) : void{}
      
      public function get sceneEffectCollideId() : int{return 0;}
      
      public function set sceneEffectCollideId(param1:int) : void{}
      
      public function get target() : Point{return null;}
      
      override public function dispose() : void{}
   }
}
