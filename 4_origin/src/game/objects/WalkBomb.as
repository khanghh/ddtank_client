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
      
      public function WalkBomb(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         _path = [];
         var _loc5_:* = _minScale;
         this.scaleY = _loc5_;
         this.scaleX = _loc5_;
         info.Actions.sort(actionSort);
         super(info,owner,refineryLevel,isPhantom);
         doDefaultAction();
      }
      
      private function actionSort(a:BombAction, b:BombAction) : int
      {
         if(a.time < b.time)
         {
            return -1;
         }
         if(a.time == b.time)
         {
            if(a.type == 23)
            {
               return -1;
            }
            if(a.type == 22)
            {
               if(b.type == 23)
               {
                  return 1;
               }
               return -1;
            }
            if(a.type == 24)
            {
               if(b.type == 23 || b.type == 22)
               {
                  return 1;
               }
               return -1;
            }
         }
         return 1;
      }
      
      override public function moveTo(p:Point) : void
      {
         var currentAction:* = null;
         var rect:* = null;
         var phyObj:* = null;
         var prePos:Point = new Point(pos.x,pos.y);
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
         startWalkMovie();
         checkWalkBallDown();
         checkWalkBall();
         if(!_isWalk && !isCurrentActionDown(currentAction))
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
               pos = p;
            }
         }
         if(_isLiving)
         {
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
      
      private function isCurrentActionDown(act:BombAction) : Boolean
      {
         if(act && act.type == 22)
         {
            return true;
         }
         return false;
      }
      
      override protected function computeFallNextXY(dt:Number) : Point
      {
         if(_isDown)
         {
            _vy.x0 = _vy.x0 + _vy.x1;
         }
         else
         {
            _vx.ComputeOneEulerStep(_mass,_arf,_wf + _ef.x,dt);
            _vy.ComputeOneEulerStep(_mass,_arf,_gf + _ef.y,dt);
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
         var currentAction:* = null;
         if(_isLiving && _info)
         {
            if(_info.UsedActions.length > 0)
            {
               currentAction = _info.UsedActions[_info.UsedActions.length - 1];
               if(currentAction.type == 22)
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
         var currentAction:* = null;
         var lastAction:* = null;
         if(_isLiving && _info)
         {
            if(_info.UsedActions.length > 0)
            {
               currentAction = _info.UsedActions[_info.UsedActions.length - 1];
               if(currentAction.type == 24)
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
                     for each(var e in _emitters)
                     {
                        _map.particleEnginee.removeEmitter(e);
                     }
                     _emitters = [];
                     this.canCollided = true;
                     var _loc8_:int = 0;
                     var _loc7_:* = _info.Actions;
                     for each(var act in _info.Actions)
                     {
                        if(act.type == 2 || act.type == 22)
                        {
                           lastAction = act;
                           break;
                        }
                     }
                     _currentPathIndex = 0;
                     walk(new Point(lastAction.param1,lastAction.param2));
                  }
               }
               else
               {
                  _isWalk = false;
               }
            }
         }
      }
      
      protected function walk(endPos:Point) : void
      {
         var pt:* = endPos;
         var dir:int = endPos.x > pos.x?1:-1;
         if(x == pt.x && y == pt.y)
         {
            doDefaultAction();
            return;
         }
         var tx:int = x;
         var ty:int = y;
         var thisPos:Point = new Point(x,y);
         var direction:int = pt.x > tx?1:-1;
         var p:Point = new Point(x,y);
         _path = [];
         while((pt.x - tx) * direction > 0)
         {
            p = _map.findNextWalkPoint(tx,ty,direction,5,15);
            if(p)
            {
               _path.push(p);
               tx = p.x;
               ty = p.y;
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
         var currentAction:* = null;
         var lastAction:* = null;
         var time:int = 0;
         if(!_isStartWalk && _isLiving && _info)
         {
            if(_info.UsedActions.length > 0)
            {
               currentAction = _info.UsedActions[_info.UsedActions.length - 1];
               lastAction = _info.Actions[_info.Actions.length - 1];
               if((currentAction.type == 24 || currentAction.type == 22) && lastAction.type == 2)
               {
                  time = lastAction.time - currentAction.time;
                  TweenLite.to(this,time / 1000,{
                     "scaleX":_maxScale,
                     "scaleY":_maxScale
                  });
               }
            }
         }
      }
      
      public function doAction(type:String) : void
      {
         if(_movie)
         {
            MovieClip(_movie).gotoAndPlay(type);
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
