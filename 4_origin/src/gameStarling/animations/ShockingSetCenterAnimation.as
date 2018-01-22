package gameStarling.animations
{
   import flash.geom.Point;
   import gameStarling.view.map.MapView3D;
   
   public class ShockingSetCenterAnimation extends BaseSetCenterAnimation
   {
       
      
      private var _shocking:int;
      
      private var _shockDelay:int;
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function ShockingSetCenterAnimation(param1:Number, param2:Number, param3:int = 165, param4:Boolean = false, param5:int = 0, param6:int = 12)
      {
         super(param1,param2,param3,false,param5,48);
         _shocking = param6;
         _shockDelay = 0;
      }
      
      private function shockingOffset() : Number
      {
         return Math.random() * _shocking * 2 - _shocking;
      }
      
      override public function update(param1:MapView3D) : Boolean
      {
         var _loc2_:* = null;
         _life = Number(_life) - 1;
         if(_life < 0)
         {
            _finished = true;
         }
         if(!_finished)
         {
            _loc2_ = new Point(_target.x - param1.x,_target.y - param1.y);
            if(_loc2_.length > 192)
            {
               param1.x = param1.x + _loc2_.x / 48;
               param1.y = param1.y + _loc2_.y / 48;
            }
            else if(_loc2_.length >= 4)
            {
               _loc2_.normalize(4);
               param1.x = param1.x + _loc2_.x;
               param1.y = param1.y + _loc2_.y;
            }
            else if(_loc2_.length >= 1)
            {
               param1.x = param1.x + _loc2_.x;
               param1.y = param1.y + _loc2_.y;
            }
            if(_life % 2)
            {
               _shocking = -_shocking;
               param1.y = param1.y + _shocking;
            }
            return true;
         }
         return false;
      }
   }
}
