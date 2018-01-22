package game.objects
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.BallManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import game.GameManager;
   import game.animations.PhysicalObjFocusAnimation;
   import game.animations.ShockMapAnimation;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.model.SceneEffectObj;
   import gameCommon.view.smallMap.SmallBomb;
   import par.ParticleManager;
   import par.emitters.Emitter;
   import phy.bombs.BaseBomb;
   import phy.maps.Map;
   import phy.object.PhysicalObj;
   import phy.object.Physics;
   import phy.object.SmallObject;
   import road7th.utils.MovieClipWrapper;
   
   public class SimpleBomb extends BaseBomb
   {
       
      
      protected var _info:Bomb;
      
      protected var _lifeTime:int;
      
      protected var _owner:Living;
      
      protected var _emitters:Array;
      
      protected var _spinV:Number;
      
      protected var _blastMC:MovieClipWrapper;
      
      protected var _bulletEffects:Array;
      
      protected var _blastOutEffects:Array;
      
      protected var _isReplaceBullet:Boolean;
      
      protected var _sceneEffectCollideId:int;
      
      protected var _dir:int = 1;
      
      protected var _smallBall:SmallObject;
      
      protected var _game:GameInfo;
      
      protected var _bitmapNum:int;
      
      protected var _refineryLevel:int;
      
      protected var _isPhantom:Boolean;
      
      protected var _bullet:MovieClip;
      
      protected var _blastOut:MovieClip;
      
      protected var _crater:Bitmap;
      
      protected var _craterBrink:Bitmap;
      
      protected var fastModel:Boolean;
      
      private var _playBlastOutEffectTimer:Timer;
      
      private var _playBlastOutEffectCount:int;
      
      public function SimpleBomb(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false){super(null,null,null,null,null);}
      
      public function get map() : MapView{return null;}
      
      public function get info() : Bomb{return null;}
      
      public function get owner() : Living{return null;}
      
      private function createBallAsset() : void{}
      
      protected function initMovie() : void{}
      
      override public function setMap(param1:Map) : void{}
      
      override public function startMoving() : void{}
      
      override public function get smallView() : SmallObject{return null;}
      
      override public function moveTo(param1:Point) : void{}
      
      public function needFocus() : void{}
      
      public function get movie() : Sprite{return null;}
      
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
      
      override public function stopMoving() : void{}
      
      override protected function updatePosition(param1:Number) : void{}
      
      public function get sceneEffectCollideId() : int{return 0;}
      
      public function set sceneEffectCollideId(param1:int) : void{}
      
      public function get target() : Point{return null;}
      
      override public function dispose() : void{}
   }
}
