package gameStarling.objects
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import starling.events.Event;
   import starlingPhy.object.PhysicalObj3D;
   
   public class SpringTimerBomb3D extends SimpleBomb3D
   {
       
      
      private var _currentBombTimer:int = -1;
      
      public function SpringTimerBomb3D(param1:Bomb, param2:Living, param3:int = 0)
      {
         super(param1,param2,param3);
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
         if(_currentBombTimer == -1)
         {
            if(_spinV > 1 || _spinV < -1)
            {
               _spinV = int(_spinV * _info.Template.SpinVA);
               _movie.angle = _movie.angle + _spinV;
            }
            angle = motionAngle * 180 / 3.14159265358979;
         }
      }
      
      override public function moveTo(param1:Point) : void
      {
         var _loc2_:* = null;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         if(_currentBombTimer > -1)
         {
            _currentBombTimer = _currentBombTimer + 40;
         }
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
            if(_loc2_ && _loc2_.type == 22 || isLastPosSpring())
            {
               if(_currentBombTimer == -1)
               {
                  _currentBombTimer = 0;
               }
               removeEmitters();
               _vx.x0 = pos.x;
               _vy.x0 = pos.y;
            }
            else if(_map.IsOutMap(param1.x,param1.y))
            {
               die();
            }
            else
            {
               map.smallMap.updatePos(_smallBall,pos);
               if(_currentBombTimer > -1)
               {
                  _loc6_ = Point.distance(param1,pos);
                  _loc5_ = _testRect.width / 2;
                  _loc4_ = _loc6_ * 180 / (_loc5_ * 3.14159265358979);
                  this.angle = this.angle + _loc4_;
               }
               else if(_particleRenderInfo)
               {
                  _particleRenderInfo.emitter.x = x;
                  _particleRenderInfo.emitter.y = y;
                  _particleRenderInfo.addAngle = motionAngle;
               }
               _loc8_ = new Point(pos.x,pos.y);
               pos = param1;
               _loc7_ = getCollideRect();
               _loc7_.offset(pos.x,pos.y);
               if(isPillarCollide())
               {
                  _loc3_ = _map.getSceneEffectPhysicalObject(_loc7_,this,_loc8_);
                  if(_loc3_ && _loc3_ is GameSceneEffect3D)
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
      }
      
      override protected function isPillarCollide() : Boolean
      {
         return true;
      }
      
      protected function isLastPosSpring() : Boolean
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_info.UsedActions.length > 0)
         {
            _loc2_ = _info.UsedActions[_info.UsedActions.length - 1];
            if(_loc2_.type == 22)
            {
               var _loc5_:int = 0;
               var _loc4_:* = _info.Actions;
               for each(var _loc3_ in _info.Actions)
               {
                  if(_loc3_.type == 2)
                  {
                     _loc1_ = _loc3_;
                     break;
                  }
               }
               if(_loc1_ && _loc1_.type == 2 && _loc2_.param1 == _loc1_.param1 && _loc2_.param2 == _loc1_.param2)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function removeEmitters() : void
      {
         if(_particleRenderInfo)
         {
            _particleRenderInfo.dispose();
            _particleRenderInfo = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
