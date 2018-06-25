package gameStarling.objects
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import starlingPhy.object.PhysicalObj3D;
   
   public class BurrowBomb3D extends SimpleBomb3D
   {
       
      
      public function BurrowBomb3D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         super(info,owner,refineryLevel,isPhantom);
      }
      
      override protected function initMovie() : void
      {
         super.initMovie();
         _isMoving = false;
         _isMoving = true;
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
            if(currentAction && currentAction.type == 24)
            {
               removeEmitters();
               _gf = _gf * -2;
               _arf = _arf * 8;
            }
            else if(_map.IsOutMap(p.x,p.y))
            {
               die();
            }
            else
            {
               map.smallMap.updatePos(_smallBall,pos);
               if(_particleRenderInfo)
               {
                  _particleRenderInfo.emitter.x = x;
                  _particleRenderInfo.emitter.y = y;
                  _particleRenderInfo.addAngle = motionAngle;
               }
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
               if(_owner && _owner.isSelf || !GameControl.Instance.Current.togetherShoot)
               {
                  needFocus();
               }
            }
         }
      }
      
      override public function get motionAngle() : Number
      {
         return Math.atan2(_vy.x1,_vx.x1);
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
         removeEmitters();
         super.dispose();
      }
   }
}
