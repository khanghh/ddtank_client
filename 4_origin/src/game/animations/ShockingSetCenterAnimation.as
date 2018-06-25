package game.animations
{
   import flash.geom.Point;
   import game.view.map.MapView;
   
   public class ShockingSetCenterAnimation extends BaseSetCenterAnimation
   {
       
      
      private var _shocking:int;
      
      private var _shockDelay:int;
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function ShockingSetCenterAnimation(cx:Number, cy:Number, life:int = 165, directed:Boolean = false, level:int = 0, shocking:int = 12)
      {
         super(cx,cy,life,false,level,48);
         _shocking = shocking;
         _shockDelay = 0;
      }
      
      private function shockingOffset() : Number
      {
         return Math.random() * _shocking * 2 - _shocking;
      }
      
      override public function update(movie:MapView) : Boolean
      {
         var p:* = null;
         _life = Number(_life) - 1;
         if(_life < 0)
         {
            _finished = true;
         }
         if(!_finished)
         {
            p = new Point(_target.x - movie.x,_target.y - movie.y);
            if(p.length > 192)
            {
               movie.x = movie.x + p.x / 48;
               movie.y = movie.y + p.y / 48;
            }
            else if(p.length >= 4)
            {
               p.normalize(4);
               movie.x = movie.x + p.x;
               movie.y = movie.y + p.y;
            }
            else if(p.length >= 1)
            {
               movie.x = movie.x + p.x;
               movie.y = movie.y + p.y;
            }
            if(_life % 2)
            {
               _shocking = -_shocking;
               movie.y = movie.y + _shocking;
            }
            return true;
         }
         return false;
      }
   }
}
