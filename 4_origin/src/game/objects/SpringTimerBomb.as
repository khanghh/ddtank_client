package game.objects
{
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import par.emitters.Emitter;
   import phy.object.PhysicalObj;
   
   public class SpringTimerBomb extends SimpleBomb
   {
       
      
      private var _currentBombTimer:int = -1;
      
      public function SpringTimerBomb(param1:Bomb, param2:Living, param3:int = 0)
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
               _movie.rotation = _movie.rotation + _spinV;
            }
            rotation = motionAngle * 180 / 3.14159265358979;
         }
      }
      
      override public function moveTo(param1:Point) : void
      {
         var _loc2_:* = null;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
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
               map.updateObjectPos(this,pos);
               if(_currentBombTimer > -1)
               {
                  _loc7_ = Point.distance(param1,pos);
                  _loc6_ = _testRect.width / 2;
                  _loc5_ = _loc7_ * 180 / (_loc6_ * 3.14159265358979);
                  this.rotation = this.rotation + _loc5_;
               }
               else
               {
                  var _loc11_:int = 0;
                  var _loc10_:* = _emitters;
                  for each(var _loc3_ in _emitters)
                  {
                     _loc3_.x = x;
                     _loc3_.y = y;
                     _loc3_.angle = motionAngle;
                  }
               }
               _loc9_ = new Point(pos.x,pos.y);
               pos = param1;
               _loc8_ = getCollideRect();
               _loc8_.offset(pos.x,pos.y);
               if(isPillarCollide())
               {
                  _loc4_ = _map.getSceneEffectPhysicalObject(_loc8_,this,_loc9_);
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
         var _loc3_:int = 0;
         var _loc2_:* = _emitters;
         for each(var _loc1_ in _emitters)
         {
            _map.particleEnginee.removeEmitter(_loc1_);
         }
         _emitters = [];
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
