package game.actions
{
   import ddt.manager.SoundManager;
   import flash.geom.Point;
   import game.animations.BaseSetCenterAnimation;
   import game.animations.ShockMapAnimation;
   import game.objects.GameLiving;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   
   public class LivingFallingAction extends BaseAction
   {
       
      
      private var _living:GameLiving;
      
      protected var _target:Point;
      
      private var _speed:int;
      
      private var _fallType:int;
      
      private var _firstExcuted:Boolean = true;
      
      private var _acceleration:int = 20;
      
      private var _state:int = 0;
      
      private var _times:int = 0;
      
      private var _tempSpeed:int = 0;
      
      private var _g:Number = 0.04;
      
      private var _maxY:Number;
      
      public function LivingFallingAction(param1:GameLiving, param2:Point, param3:int, param4:int = 0){super();}
      
      override public function connect(param1:BaseAction) : Boolean{return false;}
      
      override public function prepare() : void{}
      
      override public function execute() : void{}
      
      private function fallingAmortize() : void{}
      
      private function executeImp() : void{}
      
      private function executeImpShock() : void{}
      
      private function setPoint(param1:Number) : void{}
      
      override public function executeAtOnce() : void{}
      
      private function finish() : void{}
   }
}
