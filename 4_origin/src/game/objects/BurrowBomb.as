package game.objects
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.GameControl;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import par.emitters.Emitter;
   import phy.object.PhysicalObj;
   import road.game.resource.ActionMovie;
   
   public class BurrowBomb extends SimpleBomb
   {
       
      
      public function BurrowBomb(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
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
            ActionMovie(_movie).doAction(type,backFun);
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
