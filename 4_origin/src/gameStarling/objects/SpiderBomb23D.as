package gameStarling.objects
{
   import com.greensock.TweenLite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import road7th.utils.MathUtils;
   import starling.events.Event;
   import starlingPhy.object.PhysicalObj3D;
   
   public class SpiderBomb23D extends SimpleBomb3D
   {
       
      
      private var _isWalk:Boolean = false;
      
      private var _path:Array;
      
      private var _currentPathIndex:int = 0;
      
      public function SpiderBomb23D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         _path = [];
         initData(info);
         super(info,owner,refineryLevel,isPhantom);
      }
      
      private function initData(info:Bomb) : void
      {
         var i:int = 0;
         var arr1:Array = [];
         var arr2:Array = [];
         for(i = 0; i < info.Actions.length; )
         {
            if(info.Actions[i].type == 27)
            {
               arr1.push(new Point(info.Actions[i].param1,info.Actions[i].param2));
            }
            else
            {
               arr2.push(info.Actions[i]);
            }
            i++;
         }
         info.Actions = arr2;
         _path = arr1;
      }
      
      override protected function initMovie() : void
      {
         super.initMovie();
         _isMoving = false;
         angle = 0;
         if(_dir == 1)
         {
            _movie.angle = 0;
         }
         else
         {
            _movie.angle = -180;
         }
         doAction("born",function():void
         {
            _isMoving = true;
         });
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
         if(!isMoving())
         {
            return;
         }
         checkWalkBall();
         map.smallMap.updatePos(_smallBall,pos);
         if(_isLiving)
         {
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
            if(_owner && _owner.isSelf || !GameControl.Instance.Current.togetherShoot)
            {
               needFocus();
            }
         }
      }
      
      override protected function computeFallNextXY(dt:Number) : Point
      {
         return new Point(_vx.x0,_vy.x0);
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
      }
      
      override public function get motionAngle() : Number
      {
         return Math.atan2(_vy.x1,_vx.x1);
      }
      
      private function checkWalkBall() : void
      {
         var nextPos:* = null;
         var point1:* = null;
         var point2:* = null;
         var disX:Number = NaN;
         var disY:Number = NaN;
         if(_isLiving && _info)
         {
            if(_isWalk)
            {
               if(_path[_currentPathIndex])
               {
                  pos = _path[_currentPathIndex];
                  nextPos = _path[_currentPathIndex + 1];
                  if(nextPos)
                  {
                     point1 = nextPos;
                     point2 = pos;
                     disX = point1.x - point2.x;
                     disY = point1.y - point2.y;
                     if(Math.abs(disX) >= 2 && Math.abs(disY) >= 2)
                     {
                        if(_dir == 1)
                        {
                           _movie.angle = MathUtils.GetAngleTwoPoint(point1,point2);
                        }
                        else
                        {
                           _movie.angle = MathUtils.GetAngleTwoPoint(point1,point2);
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
      
      public function doAction(type:String, backFun:Function = null) : void
      {
         if(_movie)
         {
            _movieWrapper.playAction(type,backFun);
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
