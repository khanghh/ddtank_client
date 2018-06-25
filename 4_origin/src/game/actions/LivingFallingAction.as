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
      
      public function LivingFallingAction(living:GameLiving, target:Point, speed:int, fallType:int = 0)
      {
         _living = living;
         _target = target;
         _speed = speed;
         _fallType = fallType;
         super();
      }
      
      override public function connect(action:BaseAction) : Boolean
      {
         var ac:LivingFallingAction = action as LivingFallingAction;
         if(ac && ac._target.y < _target.y)
         {
            return true;
         }
         return false;
      }
      
      override public function prepare() : void
      {
         if(_isPrepare)
         {
            return;
         }
         _isPrepare = true;
         super.prepare();
         if(_living.isLiving)
         {
            if(_living.x == _target.x)
            {
               _living.startMoving();
            }
            else
            {
               finish();
            }
         }
         else
         {
            finish();
         }
      }
      
      override public function execute() : void
      {
         if(_fallType == 0)
         {
            executeImp();
         }
         else if(_fallType == 2)
         {
            executeImpShock();
         }
         else
         {
            fallingAmortize();
         }
      }
      
      private function fallingAmortize() : void
      {
         if(_state == 0)
         {
            _times = Number(_times) + 1;
            _tempSpeed = _speed * 1.5 * (1 - _times * 0.1);
            if(_tempSpeed < 0)
            {
               _tempSpeed = 0;
            }
            setPoint(-_tempSpeed);
            if(_times > 4)
            {
               _state = 1;
               _times = 0;
               _maxY = _living.info.pos.y;
            }
         }
         else if(_state > 15)
         {
            _times = Number(_times) + 1;
            _tempSpeed = _speed + _times * 10;
            if(_target.y == _living.info.pos.y)
            {
               executeAtOnce();
               _times = 0;
               _tempSpeed = 0;
               _living.map.animateSet.addAnimation(new ShockMapAnimation(_living,25,10));
               SoundManager.instance.play("078");
               return;
            }
            setPoint(_tempSpeed);
            if(_target.y - _living.info.pos.y < _speed)
            {
               _living.info.pos = _target;
            }
         }
         else
         {
            _state = Number(_state) + 1;
            _living.info.pos = new Point(_living.info.pos.x,_maxY);
            _living.map.animateSet.addAnimation(new BaseSetCenterAnimation(_living.x,_living.y - 150,1,true));
         }
      }
      
      private function executeImp() : void
      {
         if(_target.y - _living.info.pos.y <= _speed)
         {
            executeAtOnce();
         }
         else
         {
            setPoint(_speed);
         }
      }
      
      private function executeImpShock() : void
      {
         if(_target.y - _living.info.pos.y <= _speed)
         {
            executeAtOnce();
            _living.map.animateSet.addAnimation(new ShockMapAnimation(_living,25,10));
            SoundManager.instance.play("078");
         }
         else
         {
            setPoint(_speed);
         }
      }
      
      private function setPoint($speed:Number) : void
      {
         _living.info.pos = new Point(_target.x,_living.info.pos.y + $speed);
         _living.map.animateSet.addAnimation(new BaseSetCenterAnimation(_living.x,_living.y - 150,1,true));
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         _living.info.pos = _target;
         if(_living.actionMovie)
         {
            if(_living.actionMovie.currentAction == "stand")
            {
               _living.info.doDefaultAction();
            }
         }
         if(_living.map.IsOutMap(_target.x,_target.y) && !GameControl.Instance.playerNotDie)
         {
            _living.info.die();
         }
         finish();
      }
      
      private function finish() : void
      {
         _living.stopMoving();
         _isFinished = true;
      }
   }
}
