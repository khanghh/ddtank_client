package gameStarling.animations
{
   import flash.geom.Point;
   import gameStarling.view.map.MapView3D;
   
   public class NewHandAnimation extends BaseSetCenterAnimation
   {
       
      
      public function NewHandAnimation(cx:Number, cy:Number, life:int = 0, directed:Boolean = false, level:int = 0, speed:int = 4, data:Object = null)
      {
         super(cx,cy,life,directed,level);
      }
      
      override public function canAct() : Boolean
      {
         if(_life <= 0)
         {
            return false;
         }
         return true;
      }
      
      override public function prepare(aniset:AnimationSet) : void
      {
         _target.x = aniset.stageWidth / 2 - _target.x;
         _target.y = aniset.stageHeight / 2 - _target.y;
         _target.x = _target.x < aniset.minX?aniset.minX:Number(_target.x > 0?0:Number(_target.x));
         _target.y = _target.y < aniset.minY?aniset.minY:Number(_target.y > 0?0:Number(_target.y));
      }
      
      override public function update(movie:MapView3D) : Boolean
      {
         var result:* = null;
         _life = Number(_life) - 1;
         if(_life <= 0)
         {
            return false;
         }
         if(!_directed)
         {
            _tween.target = _target;
            result = _tween.update(movie);
            movie.x = result.x;
            movie.y = result.y;
         }
         else
         {
            movie.x = _target.x;
            movie.y = _target.y;
         }
         return true;
      }
   }
}
