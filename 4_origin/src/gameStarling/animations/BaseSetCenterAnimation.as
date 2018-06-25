package gameStarling.animations
{
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import gameStarling.view.map.MapView3D;
   
   public class BaseSetCenterAnimation extends BaseAnimate
   {
       
      
      protected var _target:Point;
      
      protected var _life:int;
      
      protected var _directed:Boolean;
      
      protected var _speed:int;
      
      protected var _moveSpeed:int = 4;
      
      protected var _tween:BaseStageTween;
      
      public function BaseSetCenterAnimation(cx:Number, cy:Number, life:int = 0, directed:Boolean = false, level:int = 0, speed:int = 4, data:Object = null)
      {
         super();
         var tweenObject:TweenObject = new TweenObject(data);
         _target = new Point(cx,cy);
         tweenObject.target = _target;
         var tweenType:String = StageTweenStrategys.getTweenClassNameByShortName(tweenObject.strategy);
         _finished = false;
         _life = life;
         _level = level;
         if(data && data.priority != null)
         {
            _level = data.priority;
         }
         if(data && data.duration != null)
         {
            _life = data.duration;
         }
         _directed = directed;
         _speed = speed;
         var tweenClass:Class = getDefinitionByName(tweenType) as Class;
         _tween = new tweenClass(tweenObject);
      }
      
      override public function canAct() : Boolean
      {
         if(_finished)
         {
            return false;
         }
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
            finished();
         }
         if(!_finished && _life > 0)
         {
            if(!_directed)
            {
               _tween.target = _target;
               result = _tween.update(movie);
               movie.x = result.x;
               movie.y = result.y;
               if(_tween.isFinished)
               {
                  finished();
               }
            }
            else
            {
               movie.x = _target.x;
               movie.y = _target.y;
               finished();
            }
            movie.setExpressionLoction();
            return true;
         }
         return false;
      }
      
      protected function finished() : void
      {
         _finished = true;
      }
   }
}
