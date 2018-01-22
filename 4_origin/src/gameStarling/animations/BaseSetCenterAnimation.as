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
      
      public function BaseSetCenterAnimation(param1:Number, param2:Number, param3:int = 0, param4:Boolean = false, param5:int = 0, param6:int = 4, param7:Object = null)
      {
         super();
         var _loc8_:TweenObject = new TweenObject(param7);
         _target = new Point(param1,param2);
         _loc8_.target = _target;
         var _loc9_:String = StageTweenStrategys.getTweenClassNameByShortName(_loc8_.strategy);
         _finished = false;
         _life = param3;
         _level = param5;
         if(param7 && param7.priority != null)
         {
            _level = param7.priority;
         }
         if(param7 && param7.duration != null)
         {
            _life = param7.duration;
         }
         _directed = param4;
         _speed = param6;
         var _loc10_:Class = getDefinitionByName(_loc9_) as Class;
         _tween = new _loc10_(_loc8_);
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
            finished();
         }
         if(!_finished && _life > 0)
         {
            if(!_directed)
            {
               _tween.target = _target;
               _loc2_ = _tween.update(param1);
               param1.x = _loc2_.x;
               param1.y = _loc2_.y;
               if(_tween.isFinished)
               {
                  finished();
               }
            }
            else
            {
               param1.x = _target.x;
               param1.y = _target.y;
               finished();
            }
            param1.setExpressionLoction();
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
