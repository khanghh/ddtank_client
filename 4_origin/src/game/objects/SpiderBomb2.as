package game.objects
{
   import com.greensock.TweenLite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import phy.object.PhysicalObj;
   import road.game.resource.ActionMovie;
   import road7th.utils.MathUtils;
   
   public class SpiderBomb2 extends SimpleBomb
   {
       
      
      private var _isWalk:Boolean = false;
      
      private var _path:Array;
      
      private var _currentPathIndex:int = 0;
      
      public function SpiderBomb2(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
      {
         _path = [];
         initData(param1);
         super(param1,param2,param3,param4);
      }
      
      private function initData(param1:Bomb) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.Actions.length)
         {
            if(param1.Actions[_loc4_].type == 27)
            {
               _loc3_.push(new Point(param1.Actions[_loc4_].param1,param1.Actions[_loc4_].param2));
            }
            else
            {
               _loc2_.push(param1.Actions[_loc4_]);
            }
            _loc4_++;
         }
         param1.Actions = _loc2_;
         _path = _loc3_;
      }
      
      override protected function initMovie() : void
      {
         super.initMovie();
         _isMoving = false;
         rotation = 0;
         if(_dir == 1)
         {
            _movie.rotation = 0;
         }
         else
         {
            _movie.rotation = -180;
         }
         doAction("born",function():void
         {
            _isMoving = true;
         });
      }
      
      override public function moveTo(param1:Point) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:Point = new Point(pos.x,pos.y);
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
         if(!isMoving())
         {
            return;
         }
         checkWalkBall();
         map.smallMap.updatePos(_smallBall,pos);
         if(_isLiving)
         {
            _loc4_ = getCollideRect();
            _loc4_.offset(pos.x,pos.y);
            if(isPillarCollide())
            {
               _loc3_ = _map.getSceneEffectPhysicalObject(_loc4_,this,_loc5_);
               if(_loc3_ && _loc3_ is GameSceneEffect)
               {
                  sceneEffectCollideId = _loc3_.Id;
               }
               checkCreateBombSceneEffect();
            }
            if(_owner && _owner.isSelf || !GameControl.Instance.Current.togetherShoot)
            {
               needFocus();
            }
         }
      }
      
      override protected function computeFallNextXY(param1:Number) : Point
      {
         return new Point(_vx.x0,_vy.x0);
      }
      
      override protected function updatePosition(param1:Number) : void
      {
         _lifeTime = _lifeTime + 40;
         moveTo(computeFallNextXY(param1));
         dispatchEvent(new Event("updatenamepos"));
         if(!_isLiving)
         {
            return;
         }
      }
      
      override public function get motionAngle() : Number
      {
         return Math.atan2(_vy.x1,_vx.x1);
      }
      
      private function checkWalkBall() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(_isLiving && _info)
         {
            if(_isWalk)
            {
               if(_path[_currentPathIndex])
               {
                  pos = _path[_currentPathIndex];
                  _loc3_ = _path[_currentPathIndex + 1];
                  if(_loc3_)
                  {
                     _loc4_ = _loc3_;
                     _loc5_ = pos;
                     _loc2_ = _loc4_.x - _loc5_.x;
                     _loc1_ = _loc4_.y - _loc5_.y;
                     if(Math.abs(_loc2_) >= 2 && Math.abs(_loc1_) >= 2)
                     {
                        if(_dir == 1)
                        {
                           _movie.rotation = MathUtils.GetAngleTwoPoint(_loc4_,_loc5_);
                        }
                        else
                        {
                           _movie.rotation = MathUtils.GetAngleTwoPoint(_loc4_,_loc5_);
                        }
                     }
                  }
               }
               _currentPathIndex = Number(_currentPathIndex) + 1;
               if(_currentPathIndex >= _path.length)
               {
                  doDefaultAction();
               }
            }
            else
            {
               _isWalk = true;
               this.canCollided = true;
               _currentPathIndex = 0;
               doAction("walk");
            }
         }
         else
         {
            _isWalk = false;
         }
      }
      
      public function doAction(param1:String, param2:Function = null) : void
      {
         if(_movie)
         {
            ActionMovie(_movie).doAction(param1,param2);
         }
      }
      
      public function doDefaultAction() : void
      {
         doAction("stand");
      }
      
      override protected function isPillarCollide() : Boolean
      {
         return true;
      }
      
      override public function dispose() : void
      {
         _path = null;
         _currentPathIndex = 0;
         TweenLite.killTweensOf(this);
         super.dispose();
      }
   }
}
