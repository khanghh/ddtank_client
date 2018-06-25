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
      
      public function SimpleBomb(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         _bulletEffects = [];
         _blastOutEffects = [];
         _info = info;
         _lifeTime = 0;
         _owner = owner;
         _bitmapNum = 0;
         _refineryLevel = refineryLevel;
         _isPhantom = isPhantom;
         _emitters = [];
         _smallBall = new SmallBomb();
         super(_info.Id,info.Template.Mass,info.Template.Weight,info.Template.Wind,info.Template.DragIndex);
         createBallAsset();
      }
      
      public function get map() : MapView
      {
         return _map as MapView;
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
         _bullet = BallManager.instance.createBulletMovie(info.Template.ID);
         _blastOut = BallManager.instance.createBlastOutMovie(info.Template.blastOutID);
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
         _blastMC = new MovieClipWrapper(_blastOut,false,true);
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
         rotation = motionAngle * 180 / 3.14159265358979;
         if(owner && !owner.isSelf && _info.Template.ID == 3 && owner.isHidden)
         {
            this.visible = false;
            _smallBall.visible = false;
         }
         mouseEnabled = false;
         mouseChildren = false;
         startMoving();
      }
      
      override public function setMap(map:Map) : void
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
         var index:int = 0;
         var emitter:* = null;
         var player:* = null;
         super.startMoving();
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         if(SharedManager.Instance.showParticle && visible)
         {
            index = 0;
            if(_info.changedPartical != "")
            {
               if(owner && owner.isPlayer())
               {
                  player = owner as Player;
                  index = player.currentWeapInfo.refineryLevel;
               }
               emitter = ParticleManager.creatEmitter(int(_info.changedPartical));
            }
            if(emitter)
            {
               _map.particleEnginee.addEmitter(emitter);
               _emitters.push(emitter);
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
               map.updateObjectPos(this,pos);
               var _loc8_:int = 0;
               var _loc7_:* = _emitters;
               for each(var e in _emitters)
               {
                  e.x = x;
                  e.y = y;
                  e.angle = motionAngle;
               }
               prePos = new Point(pos.x,pos.y);
               pos = p;
               rect = getCollideRect();
               rect.offset(pos.x,pos.y);
               if(isPillarCollide())
               {
                  phyObj = _map.getSceneEffectPhysicalObject(rect,this,prePos);
                  if(phyObj && phyObj is GameSceneEffect)
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
      
      public function get movie() : Sprite
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
            if(p is TombView)
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
               if(!_isReplaceBullet)
               {
                  _blastOutEffects.unshift(_blastMC);
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
         var sceneEffectBlastOut:* = null;
         var blastOutEffect:* = null;
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
            bulletEffect = BallManager.instance.createSceneEffectBullet(_sceneEffectCollideId);
            if(bulletEffect)
            {
               if(_isReplaceBullet)
               {
                  _bullet.visible = false;
               }
               addChild(bulletEffect);
            }
            _bulletEffects.push({
               "id":_sceneEffectCollideId,
               "movie":bulletEffect
            });
            sceneEffectBlastOut = BallManager.instance.createSceneEffectBlastOut(_sceneEffectCollideId);
            if(sceneEffectBlastOut)
            {
               blastOutEffect = new MovieClipWrapper(sceneEffectBlastOut,false,true);
               blastOutEffect.movie.visible = false;
               addChild(blastOutEffect.movie);
               _blastOutEffects.push(blastOutEffect);
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
               bulletEffect = bulletEffectObject.movie;
               if(bulletEffect)
               {
                  bulletEffect.stop();
                  ObjectUtils.disposeObject(bulletEffect);
               }
            }
            _bulletEffects = [];
         }
      }
      
      private function playBlastOutEffects(delay:Number) : void
      {
         if(_blastOutEffects.length == 1)
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
         var blastOutEffect:MovieClipWrapper = _blastOutEffects.shift();
         blastOutEffect.movie.x = x;
         blastOutEffect.movie.y = y;
         _map.addToPhyLayer(blastOutEffect.movie);
         blastOutEffect.movie.visible = true;
         blastOutEffect.addEventListener("complete",function(evt:Event):void
         {
            evt.currentTarget.removeEventListener("complete",arguments.callee);
            ObjectUtils.disposeObject(blastOutEffect);
         });
         blastOutEffect.play();
      }
      
      protected function removeBlastOutSceneEffect() : void
      {
         if(_blastOutEffects)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _blastOutEffects;
            for each(var blastOutEffect in _blastOutEffects)
            {
               ObjectUtils.disposeObject(blastOutEffect);
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
      
      override public function stopMoving() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _emitters;
         for each(var e in _emitters)
         {
            _map.particleEnginee.removeEmitter(e);
         }
         _emitters = [];
         super.stopMoving();
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
            _movie.rotation = _movie.rotation + _spinV;
         }
         rotation = motionAngle * 180 / 3.14159265358979;
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
         super.dispose();
         removeBulletSceneEffect();
         removeBlastOutSceneEffect();
         if(_blastMC)
         {
            _blastMC.dispose();
            _blastMC = null;
         }
         if(_map)
         {
            _map.removePhysical(this);
         }
         if(_smallBall)
         {
            if(_smallBall.parent)
            {
               _smallBall.parent.removeChild(_smallBall);
            }
            _smallBall.dispose();
            _smallBall = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _crater = null;
         _craterBrink = null;
         _owner = null;
         _emitters = null;
         _info = null;
         _game = null;
         _bullet = null;
         _blastOut = null;
      }
   }
}
