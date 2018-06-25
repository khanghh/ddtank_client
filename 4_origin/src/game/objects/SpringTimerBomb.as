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
      
      public function SpringTimerBomb(info:Bomb, owner:Living, refineryLevel:int = 0)
      {
         super(info,owner,refineryLevel);
      }
      
      override protected function updatePosition(dt:Number) : void
      {
         _lifeTime = _lifeTime + 40;
         moveTo(computeFallNextXY(dt));
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
      
      override public function moveTo(p:Point) : void
      {
         var currentAction:* = null;
         var dis:Number = NaN;
         var r:Number = NaN;
         var rotationAngle:Number = NaN;
         var prePos:* = null;
         var rect:* = null;
         var phyObj:* = null;
         if(_currentBombTimer > -1)
         {
            _currentBombTimer = _currentBombTimer + 40;
         }
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
            if(currentAction && currentAction.type == 22 || isLastPosSpring())
            {
               if(_currentBombTimer == -1)
               {
                  _currentBombTimer = 0;
               }
               removeEmitters();
               _vx.x0 = pos.x;
               _vy.x0 = pos.y;
            }
            else if(_map.IsOutMap(p.x,p.y))
            {
               die();
            }
            else
            {
               map.smallMap.updatePos(_smallBall,pos);
               map.updateObjectPos(this,pos);
               if(_currentBombTimer > -1)
               {
                  dis = Point.distance(p,pos);
                  r = _testRect.width / 2;
                  rotationAngle = dis * 180 / (r * 3.14159265358979);
                  this.rotation = this.rotation + rotationAngle;
               }
               else
               {
                  var _loc11_:int = 0;
                  var _loc10_:* = _emitters;
                  for each(var e in _emitters)
                  {
                     e.x = x;
                     e.y = y;
                     e.angle = motionAngle;
                  }
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
         var currentAction:* = null;
         var lastAction:* = null;
         if(_info.UsedActions.length > 0)
         {
            currentAction = _info.UsedActions[_info.UsedActions.length - 1];
            if(currentAction.type == 22)
            {
               var _loc5_:int = 0;
               var _loc4_:* = _info.Actions;
               for each(var act in _info.Actions)
               {
                  if(act.type == 2)
                  {
                     lastAction = act;
                     break;
                  }
               }
               if(lastAction && lastAction.type == 2 && currentAction.param1 == lastAction.param1 && currentAction.param2 == lastAction.param2)
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
         for each(var e in _emitters)
         {
            _map.particleEnginee.removeEmitter(e);
         }
         _emitters = [];
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
