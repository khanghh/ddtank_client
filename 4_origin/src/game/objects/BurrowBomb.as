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
       
      
      public function BurrowBomb(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
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
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
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
               var _loc8_:int = 0;
               var _loc7_:* = _emitters;
               for each(var _loc3_ in _emitters)
               {
                  _loc3_.x = x;
                  _loc3_.y = y;
                  _loc3_.angle = motionAngle;
               }
               _loc6_ = new Point(pos.x,pos.y);
               pos = param1;
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
      }
      
      override public function get motionAngle() : Number
      {
         return Math.atan2(_vy.x1,_vx.x1);
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
