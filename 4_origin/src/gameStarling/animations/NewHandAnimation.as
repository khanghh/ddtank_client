package gameStarling.animations
{
   import flash.geom.Point;
   import gameStarling.view.map.MapView3D;
   
   public class NewHandAnimation extends BaseSetCenterAnimation
   {
       
      
      public function NewHandAnimation(param1:Number, param2:Number, param3:int = 0, param4:Boolean = false, param5:int = 0, param6:int = 4, param7:Object = null)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function canAct() : Boolean
      {
         if(_life <= 0)
         {
            return false;
         }
         return true;
      }
      
      override public function prepare(param1:AnimationSet) : void
      {
         _target.x = param1.stageWidth / 2 - _target.x;
         _target.y = param1.stageHeight / 2 - _target.y;
         _target.x = _target.x < param1.minX?param1.minX:Number(_target.x > 0?0:Number(_target.x));
         _target.y = _target.y < param1.minY?param1.minY:Number(_target.y > 0?0:Number(_target.y));
      }
      
      override public function update(param1:MapView3D) : Boolean
      {
         var _loc2_:* = null;
         _life = Number(_life) - 1;
         if(_life <= 0)
         {
            return false;
         }
         if(!_directed)
         {
            _tween.target = _target;
            _loc2_ = _tween.update(param1);
            param1.x = _loc2_.x;
            param1.y = _loc2_.y;
         }
         else
         {
            param1.x = _target.x;
            param1.y = _target.y;
         }
         return true;
      }
   }
}
