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
      
      public function SimpleBomb3D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
      {
         _bulletEffects = [];
         _blastOutEffects = [];
         _info = param1;
         _lifeTime = 0;
         _owner = param2;
         _bitmapNum = 0;
         _refineryLevel = param3;
         _isPhantom = param4;
         _smallBall = new SmallBomb();
         touchable = false;
         super(_info.Id,param1.Template.Mass,param1.Template.Weight,param1.Template.Wind,param1.Template.DragIndex);
         createBallAsset();
      }
      
      public function get map() : MapView3D
      {
         return _map as MapView3D;
      }
      
      public function get info() : Bomb
      {
         return _info;
      }
      
      public function get owner() : Living
      {
         return _owner;
      }
      
      private function createBallAsset() : void
      {
         var _loc1_:* = null;
         var _loc2_:BallInfo = BallManager.instance.findBall(_info.Template.ID);
         _bullet = BoneMovieFactory.instance.creatBoneMovie(_loc2_.bulletName);
         if(_loc2_.blastOutID != 0)
         {
            _blastOut = BoneMovieFactory.instance.creatBoneMovie(_loc2_.blastOutName);
         }
         if(BallManager.instance.hasBombAsset(info.Template.craterID))
         {
            _loc1_ = BallManager.instance.gameInBombAssets[info.Template.craterID];
            _crater = _loc1_.crater;
            _craterBrink = _loc1_.craterBrink;
         }
      }
      
      protected function initMovie() : void
      {
         super.setMovie(_bullet,_crater,_craterBrink);
         if(_blastOut)
         {
            _blastOut.x = 0;
            _blastOut.y = 0;
         }
         if(!_info)
         {
            return;
         }
         _testRect = new Rectangle(-3,-3,6,6);
         addSpeedXY(new Point(_info.VX,_info.VY));
         _dir = _info.VX >= 0?1:-1;
         x = _info.X;
         y = _info.Y;
         if(_info.Template.SpinV > 0)
         {
            _movie.scaleX = _dir;
         }
         else
         {
            _movie.scaleY = _dir;
         }
         angle = motionAngle * 180 / 3.14159265358979;
         if(owner && !owner.isSelf && _info.Template.ID == 3 && owner.isHidden)
         {
            this.visible = false;
            _smallBall.visible = false;
         }
         startMoving();
      }
      
      override public function setMap(param1:Map3D) : void
      {
         super.setMap(param1);
         if(param1)
         {
            _game = this.map.gameInfo;
            initMovie();
         }
      }
      
      override public function startMoving() : void
      {
         var _loc1_:* = null;
         super.startMoving();
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         if(SharedManager.Instance.showParticle && visible && !_map.isLackOfFPS)
         {
            if(_info.changedPartical != "" && _particleRenderInfo == null)
            {
               _loc1_ = ParticleManager.Instance.emitters[_info.changedPartical] as EmitterInfo;
               if(_loc1_)
               {
                  _particleRenderInfo = ParticleRender.Instance.registerParticle(this,_loc1_.id,_loc1_.particleIds);
               }
               else
               {
                  trace("[SimpleBomb]粒子emitter数据不存在：" + _info.changedPartical);
               }
            }
         }
         _spinV = _info.Template.SpinV * _dir;
      }
      
      override public function get smallView() : SmallObject
      {
         return _smallBall;
      }
      
      override public function moveTo(param1:Point) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         while(_info.Actions.length > 0)
         {
            if(_info.Actions[0].time <= _lifeTime)
            {
               _loc2_ = _info.Actions.shift();
               _info.UsedActions.push(_loc2_);
               _loc2_.execute(this,_game);
               if(!_isLiving)
               {
                  return;
               }
               continue;
            }
            break;
         }
         if(_isLiving)
         {
            if(_map.IsOutMap(param1.x,param1.y))
            {
               die();
            }
            else
            {
               map.smallMap.updatePos(_smallBall,pos);
               _loc5_ = new Point(pos.x,pos.y);
               pos = param1;
               _loc4_ = getCollideRect();
               _loc4_.offset(pos.x,pos.y);
               if(isPillarCollide())
               {
                  _loc3_ = _map.getSceneEffectPhysicalObject(_loc4_,this,_loc5_);
                  if(_loc3_ && _loc3_ is GameSceneEffect3D)
                  {
                     sceneEffectCollideId = _loc3_.Id;
                  }
                  checkCreateBombSceneEffect();
               }
               if(!_isPhantom)
               {
                  if(_owner && _owner.isSelf || !GameControl.Instance.Current.togetherShoot)
                  {
                     needFocus();
                  }
               }
            }
         }
      }
      
      public function needFocus() : void
      {
         if(!GameManager.instance.isStopFocus)
         {
            if(map)
            {
               map.animateSet.addAnimation(new PhysicalObjFocusAnimation(this,25,0));
            }
         }
      }
      
      public function get movie() : BoneMovieStarling
      {
         return _movie;
      }
      
      protected function isPillarCollide() : Boolean
      {
         if(info.Template.BombType == 0 || info.Template.BombType == 17 || info.Template.BombType == 18 || info.Template.BombType == 30)
         {
            return true;
         }
         return false;
      }
      
      override protected function computeFallNextXY(param1:Number) : Point
      {
         _vx.ComputeOneEulerStep(_mass,_arf,_wf + _ef.x,param1);
         _vy.ComputeOneEulerStep(_mass,_arf,_gf + _ef.y,param1);
         return new Point(_vx.x0,_vy.x0);
      }
      
      public function get isFall() : Boolean
      {
         return this._vy.x1 > 0;
      }
      
      public function clearWG() : void
      {
         _wf = 0;
         _gf = 0;
         _arf = 0;
      }
      
      override public function bomb() : void
      {
         var _loc2_:* = 0;
         if(_particleRenderInfo)
         {
            _particleRenderInfo.dispose();
            _particleRenderInfo = null;
         }
         if(_info.IsHole && !_isPhantom)
         {
            super.DigMap();
            map.smallMap.draw();
            map.resetMapChanged();
         }
         var _loc3_:Array = map.getPhysicalObjectByPoint(pos,100,this);
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc1_ in _loc3_)
         {
            if(_loc1_ is TombView3D)
            {
               _loc1_.startMoving();
            }
         }
         stopMoving();
         if(!fastModel)
         {
            if(_info.Template.Shake)
            {
               _loc2_ = uint(7);
               if(info.damageMod < 1)
               {
                  _loc2_ = uint(4);
               }
               if(info.damageMod > 2)
               {
                  _loc2_ = uint(14);
               }
               map.animateSet.addAnimation(new ShockMapAnimation(this,_loc2_));
            }
            else if((!GameControl.Instance.Current.togetherShoot || GameControl.Instance.Current.roomType == 21 && _owner && _owner is Player && _owner.LivingID == GameControl.Instance.Current.selfGamePlayer.LivingID) && !GameManager.instance.isStopFocus)
            {
               map.animateSet.addAnimation(new PhysicalObjFocusAnimation(this,10));
            }
         }
         if(!fastModel && !_isPhantom)
         {
            if(visible)
            {
               removeBulletSceneEffect();
               if(!_isReplaceBullet && _blastOut)
               {
                  _blastOutEffects.unshift(_blastOut);
               }
               playBlastOutEffects(300);
            }
            else
            {
               if(_isLiving)
               {
                  SoundManager.instance.play(_info.Template.BombSound);
               }
               die();
            }
         }
         else
         {
            if(_isPhantom)
            {
               if(_isLiving)
               {
                  SoundManager.instance.play(_info.Template.BombSound);
               }
            }
            die();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function bombAtOnce() : void
      {
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         fastModel = true;
         _loc5_ = 0;
         while(_loc5_ < _info.Actions.length)
         {
            if(_info.Actions[_loc5_].type == 2)
            {
               _loc1_ = _info.Actions[_loc5_];
               break;
            }
            _loc5_++;
         }
         var _loc4_:int = _info.Actions.indexOf(_loc1_);
         var _loc3_:Array = _info.Actions.splice(_loc4_,1);
         if(_loc1_)
         {
            _info.Actions.push(_loc1_);
         }
         while(_info.Actions.length > 0)
         {
            _loc2_ = _info.Actions.shift();
            _info.UsedActions.push(_loc2_);
            _loc2_.execute(this,_game);
            if(!_isLiving)
            {
               return;
            }
         }
         if(_info)
         {
            _info.Actions = [];
         }
      }
      
      protected function checkCreateBombSceneEffect() : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(_sceneEffectCollideId == 0)
         {
            return;
         }
         if(_sceneEffectCollideId == SceneEffectObj.Fire)
         {
            _isReplaceBullet = true;
         }
         else if(_sceneEffectCollideId != SceneEffectObj.Thunder)
         {
            return;
         }
         var _loc3_:Boolean = true;
         if(_bulletEffects)
         {
            _loc7_ = 0;
            while(_loc7_ < _bulletEffects.length)
            {
               _loc6_ = _bulletEffects[_loc7_];
               if(_loc6_.id == _sceneEffectCollideId)
               {
                  _loc3_ = false;
                  break;
               }
               _loc7_++;
            }
         }
         if(_loc3_)
         {
            _loc2_ = "bones.game.sceneEffectBullet" + _sceneEffectCollideId;
            if(BoneMovieFactory.instance.model.getBonesStyle(_loc2_))
            {
               if(_isReplaceBullet)
               {
                  _movie.visible = false;
               }
               _loc1_ = BoneMovieFactory.instance.creatBoneMovie(_loc2_);
               addChild(_loc1_);
            }
            _bulletEffects.push({
               "id":_sceneEffectCollideId,
               "movie":_loc1_
            });
            _loc4_ = "bones.game.sceneEffectBlastOut" + _sceneEffectCollideId;
            if(BoneMovieFactory.instance.model.getBonesStyle(_loc4_))
            {
               _loc5_ = BoneMovieFactory.instance.creatBoneMovie(_loc4_);
               _loc5_.visible = false;
               addChild(_loc5_);
               _blastOutEffects.push(_loc5_);
            }
         }
      }
      
      protected function removeBulletSceneEffect() : void
      {
         var _loc1_:* = null;
         if(_bulletEffects)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _bulletEffects;
            for each(var _loc2_ in _bulletEffects)
            {
               if(_loc2_.movie != null)
               {
                  _loc1_ = _loc2_.movie as BoneMovieStarling;
                  StarlingObjectUtils.disposeObject(_loc1_);
               }
            }
            _bulletEffects = [];
         }
      }
      
      private function playBlastOutEffects(param1:Number) : void
      {
         if(_blastOutEffects.length == 0)
         {
            die();
         }
         else if(_blastOutEffects.length == 1)
         {
            playBlastOutEffect(die);
         }
         else
         {
            _playBlastOutEffectCount = _blastOutEffects.length;
            _playBlastOutEffectTimer = new Timer(param1,_blastOutEffects.length - 1);
            _playBlastOutEffectTimer.addEventListener("timer",_playBlastOutEffectTimerHandler);
            _playBlastOutEffectTimer.start();
            _playBlastOutEffectTimerHandler(null);
         }
      }
      
      private function _playBlastOutEffectTimerHandler(param1:TimerEvent) : void
      {
         evt = param1;
         playBlastOutEffect(function():void
         {
            _playBlastOutEffectCount = Number(_playBlastOutEffectCount) - 1;
            if(_playBlastOutEffectCount <= 0)
            {
               die();
            }
         });
      }
      
      private function playBlastOutEffect(param1:Function) : void
      {
         backFun = param1;
         if(_isLiving)
         {
            SoundManager.instance.play(_info.Template.BombSound);
         }
         var blastOutEffect:BoneMovieStarling = _blastOutEffects.shift();
         blastOutEffect.x = x;
         blastOutEffect.y = y;
         _map.addToPhyLayer(blastOutEffect);
         blastOutEffect.visible = true;
         if(blastOutEffect.armature)
         {
            var wrapper:BoneMovieWrapper = new BoneMovieWrapper(blastOutEffect);
            wrapper.playAction("",function():void
            {
               wrapper.dispose();
            });
         }
      }
      
      protected function removeBlastOutSceneEffect() : void
      {
         if(_blastOutEffects)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _blastOutEffects;
            for each(var _loc1_ in _blastOutEffects)
            {
               StarlingObjectUtils.disposeObject(_loc1_);
            }
            _blastOutEffects = null;
         }
         if(_playBlastOutEffectTimer)
         {
            _playBlastOutEffectTimer.removeEventListener("timer",_playBlastOutEffectTimerHandler);
            _playBlastOutEffectTimer.stop();
            _playBlastOutEffectTimer = null;
         }
      }
      
      override public function die() : void
      {
         super.die();
         dispose();
      }
      
      override protected function updatePosition(param1:Number) : void
      {
         _lifeTime = _lifeTime + 40;
         super.updatePosition(param1);
         if(!_isLiving)
         {
            return;
         }
         if(_spinV > 1 || _spinV < -1)
         {
            _spinV = int(_spinV * _info.Template.SpinVA);
            _movie.angle = _movie.angle + _spinV;
         }
         angle = motionAngle * 180 / 3.14159265358979;
      }
      
      public function get sceneEffectCollideId() : int
      {
         return _sceneEffectCollideId;
      }
      
      public function set sceneEffectCollideId(param1:int) : void
      {
         _sceneEffectCollideId = param1;
      }
      
      public function get target() : Point
      {
         if(_info)
         {
            return _info.target;
         }
         return null;
      }
      
      override public function dispose() : void
      {
         if(_particleRenderInfo)
         {
            _particleRenderInfo.dispose();
            _particleRenderInfo = null;
         }
         removeBulletSceneEffect();
         removeBlastOutSceneEffect();
         StarlingObjectUtils.disposeObject(_blastOut);
         ObjectUtils.disposeObject(_smallBall);
         super.dispose();
         _crater = null;
         _bullet = null;
         _craterBrink = null;
         _owner = null;
         _info = null;
         _game = null;
         _blastOut = null;
         _smallBall = null;
      }
   }
}
