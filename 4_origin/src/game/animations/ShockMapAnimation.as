package game.animations
{
   import game.objects.SimpleBomb;
   import game.view.map.MapView;
   import phy.object.PhysicalObj;
   
   public class ShockMapAnimation implements IAnimate
   {
       
      
      private var _bomb:PhysicalObj;
      
      private var _finished:Boolean;
      
      private var _age:Number;
      
      private var _life:Number;
      
      private var _radius:Number;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _scale:int;
      
      public function ShockMapAnimation(bomb:PhysicalObj, radius:Number = 7, life:Number = 0)
      {
         var b:* = null;
         super();
         _age = 0;
         _life = life;
         _finished = false;
         _bomb = bomb;
         _radius = radius;
         _scale = 1;
         if(_bomb is SimpleBomb)
         {
            b = _bomb as SimpleBomb;
            if(b.target && b.owner)
            {
               if(b.target.x - b.owner.pos.x < 0)
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
      
      public function canReplace(anit:IAnimate) : Boolean
      {
         return true;
      }
      
      public function prepare(aniset:AnimationSet) : void
      {
      }
      
      public function cancel() : void
      {
         _finished = true;
         _life = 0;
      }
      
      public function update(movie:MapView) : Boolean
      {
         _life = Number(_life) - 1;
         if(!_finished)
         {
            if(_age == 0)
            {
               _x = movie.x;
               _y = movie.y;
            }
            _age = _age + 0.25;
            if(_age < 1.5)
            {
               _radius = -_radius;
               movie.x = _x + _radius * scale;
               movie.y = _y + _radius;
            }
            else
            {
               movie.x = _x;
               movie.y = _y;
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
