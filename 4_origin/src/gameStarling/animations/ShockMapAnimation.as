package gameStarling.animations
{
   import gameStarling.objects.SimpleBomb3D;
   import gameStarling.view.map.MapView3D;
   import starlingPhy.object.PhysicalObj3D;
   
   public class ShockMapAnimation implements IAnimate
   {
       
      
      private var _bomb:PhysicalObj3D;
      
      private var _finished:Boolean;
      
      private var _age:Number;
      
      private var _life:Number;
      
      private var _radius:Number;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _scale:int;
      
      public function ShockMapAnimation(param1:PhysicalObj3D, param2:Number = 7, param3:Number = 0)
      {
         var _loc4_:* = null;
         super();
         _age = 0;
         _life = param3;
         _finished = false;
         _bomb = param1;
         _radius = param2;
         _scale = 1;
         if(_bomb is SimpleBomb3D)
         {
            _loc4_ = _bomb as SimpleBomb3D;
            if(_loc4_.target && _loc4_.owner)
            {
               if(_loc4_.target.x - _loc4_.owner.pos.x < 0)
               {
                  _scale = -1;
               }
            }
         }
      }
      
      public function get level() : int
      {
         return 2;
      }
      
      public function get scale() : int
      {
         return _scale;
      }
      
      public function canAct() : Boolean
      {
         return !_finished || _life > 0;
      }
      
      public function canReplace(param1:IAnimate) : Boolean
      {
         return true;
      }
      
      public function prepare(param1:AnimationSet) : void
      {
      }
      
      public function cancel() : void
      {
         _finished = true;
         _life = 0;
      }
      
      public function update(param1:MapView3D) : Boolean
      {
         _life = Number(_life) - 1;
         if(!_finished)
         {
            if(_age == 0)
            {
               _x = param1.x;
               _y = param1.y;
            }
            _age = _age + 0.25;
            if(_age < 1.5)
            {
               _radius = -_radius;
               param1.x = _x + _radius * scale;
               param1.y = _y + _radius;
            }
            else
            {
               param1.x = _x;
               param1.y = _y;
               _finished = true;
            }
            return true;
         }
         return false;
      }
      
      public function get finish() : Boolean
      {
         return _finished;
      }
   }
}
