package game.animations
{
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import game.view.map.MapView;
   
   public class BaseSetCenterAnimation extends BaseAnimate
   {
       
      
      protected var _target:Point;
      
      protected var _life:int;
      
      protected var _directed:Boolean;
      
      protected var _speed:int;
      
      protected var _moveSpeed:int = 4;
      
      protected var _tween:BaseStageTween;
      
      public function BaseSetCenterAnimation(param1:Number, param2:Number, param3:int = 0, param4:Boolean = false, param5:int = 0, param6:int = 4, param7:Object = null){super();}
      
      override public function canAct() : Boolean{return false;}
      
      override public function prepare(param1:AnimationSet) : void{}
      
      override public function update(param1:MapView) : Boolean{return false;}
      
      protected function finished() : void{}
   }
}
