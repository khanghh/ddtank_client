package game.animations{   import flash.geom.Point;   import flash.utils.getDefinitionByName;   import game.view.map.MapView;      public class BaseSetCenterAnimation extends BaseAnimate   {                   protected var _target:Point;            protected var _life:int;            protected var _directed:Boolean;            protected var _speed:int;            protected var _moveSpeed:int = 4;            protected var _tween:BaseStageTween;            public function BaseSetCenterAnimation(cx:Number, cy:Number, life:int = 0, directed:Boolean = false, level:int = 0, speed:int = 4, data:Object = null) { super(); }
            override public function canAct() : Boolean { return false; }
            override public function prepare(aniset:AnimationSet) : void { }
            override public function update(movie:MapView) : Boolean { return false; }
            protected function finished() : void { }
   }}