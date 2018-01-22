package game.actions
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import game.animations.PhysicalObjFocusAnimation;
   import game.objects.GameLiving;
   import gameCommon.actions.BaseAction;
   
   public class LivingJumpAction extends BaseAction
   {
       
      
      private var _living:GameLiving;
      
      protected var _target:Point;
      
      private var _speed:int;
      
      private var _firstExcuted:Boolean = true;
      
      private var _jumpType:int;
      
      private var _moveMovie:MovieClip;
      
      private var _state:int = 0;
      
      private var _times:int = 0;
      
      private var _g:Number = 0.04;
      
      private var _tempSpeed:Number = 0;
      
      private var _ax:Number;
      
      private var _ay:Number;
      
      public function LivingJumpAction(param1:GameLiving, param2:Point, param3:int, param4:int = 0){super();}
      
      override public function connect(param1:BaseAction) : Boolean{return false;}
      
      override public function prepare() : void{}
      
      private function __checkMoveMovie(param1:Event) : void{}
      
      private function stopMovie() : void{}
      
      private function contuineMovie() : void{}
      
      private function doActionStand() : void{}
      
      override public function execute() : void{}
      
      private function jumpAmortize() : void{}
      
      private function jumpContinuous() : void{}
      
      private function setPoint(param1:Number) : void{}
      
      private function setPoint2(param1:Number) : void{}
      
      private function setPoint3() : void{}
      
      private function jumpBass() : void{}
      
      private function jumpWalk() : void{}
      
      private function jump() : void{}
      
      private function prepareJump() : void{}
      
      override public function executeAtOnce() : void{}
      
      private function finish() : void{}
   }
}
