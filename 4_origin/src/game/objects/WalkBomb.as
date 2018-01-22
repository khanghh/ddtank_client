package game.objects
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import par.emitters.Emitter;
   import phy.object.PhysicalObj;
   import road7th.utils.MathUtils;
   
   public class WalkBomb extends SimpleBomb
   {
       
      
      private var _isWalk:Boolean = false;
      
      private var _path:Array;
      
      private var _currentPathIndex:int = 0;
      
      private var _isDown:Boolean = false;
      
      private var _isStartWalk:Boolean = false;
      
      private var _minScale:Number = 0.8;
      
      private var _maxScale:Number = 1.2;
      
      public function WalkBomb(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
      {
         _path = [];
         var _loc5_:* = _minScale;
         this.scaleY = _loc5_;
         this.scaleX = _loc5_;
         param1.Actions.sort(actionSort);
         super(param1,param2,param3,param4);
         doDefaultAction();
      }
      
      private function actionSort(param1:BombAction, param2:BombAction) : int
      {
         if(param1.time < param2.time)
         {
            return -1;
         }
         if(param1.time == param2.time)
         {
            if(param1.type == 23)
            {
               return -1;
            }
            if(param1.type == 22)
            {
               if(param2.type == 23)
               {
                  return 1;
               }
               return -1;
            }
            if(param1.type == 24)
            {
               if(param2.type == 23 || param2.type == 22)
               {
                  return 1;
               }
               return -1;
            }
         }
         return 1;
      }
      
      override public function moveTo(param1:Point) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc6_:Point = new Point(pos.x,pos.y);
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
         startWalkMovie();
         checkWalkBallDown();
         checkWalkBall();
         if(!_isWalk && !isCurrentActionDown(_loc2_))
         {
            if(_map.IsOutMap(param1.x,param1.y))
            {
               die();
            }
            else
            {
               map.smallMap.updatePos(_smallBall,pos);
               var _loc8_:int = 0;
               var _loc7_:* = _emitters;
               for each(var _loc3_ in _emitters)
               {
                  _loc3_.x = x;
                  _loc3_.y = y;
                  _loc3_.angle = motionAngle;
               }
               pos = param1;
            }
         }
         if(_isLiving)
         {
            _loc5_ = getCollideRect();
            _loc5_.offset(pos.x,pos.y);
            if(isPillarCollide())
            {
               _loc4_ = _map.getSceneEffectPhysicalObject(_loc5_,this,_loc6_);
               if(_loc4_ && _loc4_ is GameSceneEffect)
               {
                  sceneEffectCollideId = _loc4_.Id;
               }
               checkCreateBombSceneEffect();
            }
            if(_owner && _owner.isSelf || !GameControl.Instance.Current.togetherShoot)
            {
               needFocus();
            }
         }
      }
      
      private function isCurrentActionDown(param1:BombAction) : Boolean
      {
         if(param1 && param1.type == 22)
         {
            return true;
         }
         return false;
      }
      
      override protected function computeFallNextXY(param1:Number) : Point
      {
         if(_isDown)
         {
            _vy.x0 = _vy.x0 + _vy.x1;
         }
         else
         {
            _vx.ComputeOneEulerStep(_mass,_arf,_wf + _ef.x,param1);
            _vy.ComputeOneEulerStep(_mass,_arf,_gf + _ef.y,param1);
         }
         return new Point(_vx.x0,_vy.x0);
      }
      
      override public function get motionAngle() : Number
      {
         if(_isWalk)
         {
            if(_dir == 1)
            {
               return MathUtils.AngleToRadian(calcObjectAngle());
            }
            return MathUtils.AngleToRadian(calcObjectAngle()) - 3.14159265358979;
         }
         if(_isDown)
         {
            return 3.14159265358979 / 2;
         }
         return Math.atan2(_vy.x1,_vx.x1);
      }
      
      private function checkWalkBallDown() : void
      {
         var _loc1_:* = null;
         if(_isLiving && _info)
         {
            if(_info.UsedActions.length > 0)
            {
               _loc1_ = _info.UsedActions[_info.UsedActions.length - 1];
               if(_loc1_.type == 22)
               {
                  _isStartWalk = true;
                  _isDown = true;
                  this.canCollided = true;
               }
               else
               {
                  _isDown = false;
               }
            }
         }
      }
      
      private function checkWalkBall() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_isLiving && _info)
         {
            if(_info.UsedActions.length > 0)
            {
               _loc2_ = _info.UsedActions[_info.UsedActions.length - 1];
               if(_loc2_.type == 24)
               {
                  if(_isWalk)
                  {
                     if(_path[_currentPathIndex])
                     {
                        pos = _path[_currentPathIndex];
                     }
                     _currentPathIndex = Number(_currentPathIndex) + 1;
                     if(_currentPathIndex >= _path.length)
                     {
                        doDefaultAction();
                     }
                  }
                  else
                  {
                     _isStartWalk = true;
                     _isWalk = true;
                     var _loc6_:int = 0;
                     var _loc5_:* = _emitters;
                     for each(var _loc3_ in _emitters)
                     {
                        _map.particleEnginee.removeEmitter(_loc3_);
                     }
                     _emitters = [];
                     this.canCollided = true;
                     var _loc8_:int = 0;
                     var _loc7_:* = _info.Actions;
                     for each(var _loc4_ in _info.Actions)
                     {
                        if(_loc4_.type == 2 || _loc4_.type == 22)
                        {
                           _loc1_ = _loc4_;
                           break;
                        }
                     }
                     _currentPathIndex = 0;
                     walk(new Point(_loc1_.param1,_loc1_.param2));
                  }
               }
               else
               {
                  _isWalk = false;
               }
            }
         }
      }
      
      protected function walk(param1:Point) : void
      {
         var _loc8_:* = param1;
         var _loc5_:int = param1.x > pos.x?1:-1;
         if(x == _loc8_.x && y == _loc8_.y)
         {
            doDefaultAction();
            return;
         }
         var _loc4_:int = x;
         var _loc3_:int = y;
         var _loc2_:Point = new Point(x,y);
         var _loc6_:int = _loc8_.x > _loc4_?1:-1;
         var _loc7_:Point = new Point(x,y);
         _path = [];
         while((_loc8_.x - _loc4_) * _loc6_ > 0)
         {
            _loc7_ = _map.findNextWalkPoint(_loc4_,_loc3_,_loc6_,5,15);
            if(_loc7_)
            {
               _path.push(_loc7_);
               _loc4_ = _loc7_.x;
               _loc3_ = _loc7_.y;
               continue;
            }
            break;
         }
         if(_path.length > 0)
         {
            doAction("walkB");
         }
         else
         {
            doDefaultAction();
         }
      }
      
      private function startWalkMovie() : void
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(!_isStartWalk && _isLiving && _info)
         {
            if(_info.UsedActions.length > 0)
            {
               _loc3_ = _info.UsedActions[_info.UsedActions.length - 1];
               _loc1_ = _info.Actions[_info.Actions.length - 1];
               if((_loc3_.type == 24 || _loc3_.type == 22) && _loc1_.type == 2)
               {
                  _loc2_ = _loc1_.time - _loc3_.time;
                  TweenLite.to(this,_loc2_ / 1000,{
                     "scaleX":_maxScale,
                     "scaleY":_maxScale
                  });
               }
            }
         }
      }
      
      public function doAction(param1:String) : void
      {
         if(_movie)
         {
            MovieClip(_movie).gotoAndPlay(param1);
         }
      }
      
      public function doDefaultAction() : void
      {
         doAction("walkA");
      }
      
      override protected function isPillarCollide() : Boolean
      {
         return true;
      }
      
      override public function dispose() : void
      {
         _path = null;
         _currentPathIndex = 0;
         _minScale = 0;
         _maxScale = 0;
         TweenLite.killTweensOf(this);
         super.dispose();
      }
   }
}
