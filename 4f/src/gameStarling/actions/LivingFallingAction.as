package gameStarling.actions{   import ddt.manager.SoundManager;   import flash.geom.Point;   import gameCommon.GameControl;   import gameCommon.actions.BaseAction;   import gameStarling.animations.BaseSetCenterAnimation;   import gameStarling.animations.ShockMapAnimation;   import gameStarling.objects.GameLiving3D;      public class LivingFallingAction extends BaseAction   {                   private var _living:GameLiving3D;            protected var _target:Point;            private var _speed:int;            private var _fallType:int;            private var _firstExcuted:Boolean = true;            private var _acceleration:int = 20;            private var _state:int = 0;            private var _times:int = 0;            private var _tempSpeed:int = 0;            private var _g:Number = 0.04;            private var _maxY:Number;            public function LivingFallingAction(living:GameLiving3D, target:Point, speed:int, fallType:int = 0) { super(); }
            override public function connect(action:BaseAction) : Boolean { return false; }
            override public function prepare() : void { }
            override public function execute() : void { }
            private function fallingAmortize() : void { }
            private function executeImp() : void { }
            private function executeImpShock() : void { }
            private function setPoint($speed:Number) : void { }
            override public function executeAtOnce() : void { }
            private function finish() : void { }
   }}