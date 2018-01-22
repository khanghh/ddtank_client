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
       
      
      public function BurrowBomb3D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function initMovie() : void
      {
         super.initMovie();
         _isMoving = false;
         _isMoving = true;
      }
      
      override public function moveTo(param1:Point) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
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
            if(_loc2_ && _loc2_.type == 24)
            {
               removeEmitters();
               _gf = _gf * -2;
               _arf = _arf * 8;
            }
            else if(_map.IsOutMap(param1.x,param1.y))
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
               _loc5_ = new Point(pos.x,pos.y);
               pos = param1;
               _loc4_ = getCollideRect();
               _loc4_.offset(pos.x,pos.y);
               if(isPillarCollide())
               {
                  _loc3_ = _map.getSceneEffectPhysicalObject(_loc4_,this,_loc5_);
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
      
      override public function get motionAngle() : Number
      {
         return Math.atan2(_vy.x1,_vx.x1);
      }
      
      public function doAction(param1:String, param2:Function = null) : void
      {
         if(_movie)
         {
            _movieWrapper.playAction(param1,param2);
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
