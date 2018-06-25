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
      
      public function SimpleBomb3D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         _bulletEffects = [];
         _blastOutEffects = [];
         _info = info;
         _lifeTime = 0;
         _owner = owner;
         _bitmapNum = 0;
         _refineryLevel = refineryLevel;
         _isPhantom = isPhantom;
         _smallBall = new SmallBomb();
         touchable = false;
         super(_info.Id,info.Template.Mass,info.Template.Weight,info.Template.Wind,info.Template.DragIndex);
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
         var bombAsset:* = null;
         var ballInfo:BallInfo = BallManager.instance.findBall(_info.Template.ID);
         _bullet = BoneMovieFactory.instance.creatBoneMovie(ballInfo.bulletName);
         if(ballInfo.blastOutID != 0)
         {
            _blastOut = BoneMovieFactory.instance.creatBoneMovie(ballInfo.blastOutName);
         }
         if(BallManager.instance.hasBombAsset(info.Template.craterID))
         {
            bombAsset = BallManager.instance.gameInBombAssets[info.Template.craterID];
            _crater = bombAsset.crater;
            _craterBrink = bombAsset.craterBrink;
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
      
      override public function setMap(map:Map3D) : void
      {
         super.setMap(map);
         if(map)
         {
            _game = this.map.gameInfo;
            initMovie();
         }
      }
      
      override public function startMoving() : void
      {
         var emitterInfo:* = null;
         super.startMoving();
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         if(SharedManager.Instance.showParticle && visible && !_map.isLackOfFPS)
         {
            if(_info.changedPartical != "" && _particleRenderInfo == null)
            {
               emitterInfo = ParticleManager.Instance.emitters[_info.changedPartical] as EmitterInfo;
               if(emitterInfo)
               {
                  _particleRenderInfo = ParticleRender.Instance.registerParticle(this,emitterInfo.id,emitterInfo.particleIds);
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
      
      override public function moveTo(p:Point) : void
      {
         var currentAction:* = null;
         var prePos:* = null;
         var rect:* = null;
         var phyObj:* = null;
         while(_info.Actions.length > 0)
         {
            if(_info.Actions[0].time <= _lifeTime)
            {
               currentAction = _info.Actions.shift();
               _info.UsedActions.push(currentAction);
               currentAction.execute(this,_game);
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
            if(_map.IsOutMap(p.x,p.y))
            {
               die();
            }
            else
            {
               map.smallMap.updatePos(_smallBall,pos);
               prePos = new Point(pos.x,pos.y);
               pos = p;
               rect = getCollideRect();
               rect.offset(pos.x,pos.y);
               if(isPillarCollide())
               {
                  phyObj = _map.getSceneEffectPhysicalObject(rect,this,prePos);
                  if(phyObj && phyObj is GameSceneEffect3D)
                  {
                     sceneEffectCollideId = phyObj.Id;
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
      
      override protected function computeFallNextXY(dt:Number) : Point
      {
         _vx.ComputeOneEulerStep(_mass,_arf,_wf + _ef.x,dt);
         _vy.ComputeOneEulerStep(_mass,_arf,_gf + _ef.y,dt);
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
         var radius:* = 0;
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
         var list:Array = map.getPhysicalObjectByPoint(pos,100,this);
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var p in list)
         {
            if(p is TombView3D)
            {
               p.startMoving();
            }
         }
         stopMoving();
         if(!fastModel)
         {
            if(_info.Template.Shake)
            {
               radius = uint(7);
               if(info.damageMod < 1)
               {
                  radius = uint(4);
               }
               if(info.damageMod > 2)
               {
                  radius = uint(14);
               }
               map.animateSet.addAnimation(new ShockMapAnimation(this,radius));
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
         var boomAction:* = null;
         var i:int = 0;
         var action:* = null;
         fastModel = true;
         for(i = 0; i < _info.Actions.length; )
         {
            if(_info.Actions[i].type == 2)
            {
               boomAction = _info.Actions[i];
               break;
            }
            i++;
         }
         var boomIndex:int = _info.Actions.indexOf(boomAction);
         var newActions:Array = _info.Actions.splice(boomIndex,1);
         if(boomAction)
         {
            _info.Actions.push(boomAction);
         }
         while(_info.Actions.length > 0)
         {
            action = _info.Actions.shift();
            _info.UsedActions.push(action);
            action.execute(this,_game);
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
         var be:int = 0;
         var bulletEffectObj:* = null;
         var bulletEffect:* = null;
         var sceneEffectBulletName:* = null;
         var sceneEffectBlastOutName:* = null;
         var sceneEffectBlastOut:* = null;
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
         var isAddBulletEffect:Boolean = true;
         if(_bulletEffects)
         {
            for(be = 0; be < _bulletEffects.length; )
            {
               bulletEffectObj = _bulletEffects[be];
               if(bulletEffectObj.id == _sceneEffectCollideId)
               {
                  isAddBulletEffect = false;
                  break;
               }
               be++;
            }
         }
         if(isAddBulletEffect)
         {
            sceneEffectBulletName = "bones.game.sceneEffectBullet" + _sceneEffectCollideId;
            if(BoneMovieFactory.instance.model.getBonesStyle(sceneEffectBulletName))
            {
               if(_isReplaceBullet)
               {
                  _movie.visible = false;
               }
               bulletEffect = BoneMovieFactory.instance.creatBoneMovie(sceneEffectBulletName);
               addChild(bulletEffect);
            }
            _bulletEffects.push({
               "id":_sceneEffectCollideId,
               "movie":bulletEffect
            });
            sceneEffectBlastOutName = "bones.game.sceneEffectBlastOut" + _sceneEffectCollideId;
            if(BoneMovieFactory.instance.model.getBonesStyle(sceneEffectBlastOutName))
            {
               sceneEffectBlastOut = BoneMovieFactory.instance.creatBoneMovie(sceneEffectBlastOutName);
               sceneEffectBlastOut.visible = false;
               addChild(sceneEffectBlastOut);
               _blastOutEffects.push(sceneEffectBlastOut);
            }
         }
      }
      
      protected function removeBulletSceneEffect() : void
      {
         var bulletEffect:* = null;
         if(_bulletEffects)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _bulletEffects;
            for each(var bulletEffectObject in _bulletEffects)
            {
               if(bulletEffectObject.movie != null)
               {
                  bulletEffect = bulletEffectObject.movie as BoneMovieStarling;
                  StarlingObjectUtils.disposeObject(bulletEffect);
               }
            }
            _bulletEffects = [];
         }
      }
      
      private function playBlastOutEffects(delay:Number) : void
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
            _playBlastOutEffectTimer = new Timer(delay,_blastOutEffects.length - 1);
            _playBlastOutEffectTimer.addEventListener("timer",_playBlastOutEffectTimerHandler);
            _playBlastOutEffectTimer.start();
            _playBlastOutEffectTimerHandler(null);
         }
      }
      
      private function _playBlastOutEffectTimerHandler(evt:TimerEvent) : void
      {
         evt = evt;
         playBlastOutEffect(function():void
         {
            _playBlastOutEffectCount = Number(_playBlastOutEffectCount) - 1;
            if(_playBlastOutEffectCount <= 0)
            {
               die();
            }
         });
      }
      
      private function playBlastOutEffect(backFun:Function) : void
      {
         backFun = backFun;
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
            for each(var blastOutEffect in _blastOutEffects)
            {
               StarlingObjectUtils.disposeObject(blastOutEffect);
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
      
      override protected function updatePosition(dt:Number) : void
      {
         _lifeTime = _lifeTime + 40;
         super.updatePosition(dt);
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
      
      public function set sceneEffectCollideId(value:int) : void
      {
         _sceneEffectCollideId = value;
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
