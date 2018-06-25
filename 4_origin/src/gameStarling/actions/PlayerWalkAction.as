package gameStarling.actions
{
   import ddt.manager.SoundManager;
   import ddt.view.characterStarling.GameCharacter3D;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.LocalPlayer;
   import gameStarling.objects.GameLiving3D;
   import gameStarling.objects.GameLocalPlayer3D;
   import gameStarling.objects.GamePlayer3D;
   
   public class PlayerWalkAction extends BaseAction
   {
       
      
      private var _living:GameLiving3D;
      
      private var _action;
      
      private var _target:Point;
      
      private var _dir:Number;
      
      private var _self:LocalPlayer;
      
      private var _finishedFun:Function;
      
      public function PlayerWalkAction(living:GameLiving3D, target:Point, dir:Number, action:* = null, finishedFun:Function = null)
      {
         super();
         _isFinished = false;
         _self = GameControl.Instance.Current.selfGamePlayer;
         _living = living;
         _action = !!action?action:GameCharacter3D.WALK;
         _target = target;
         _dir = dir;
         _finishedFun = finishedFun;
      }
      
      override public function connect(action:BaseAction) : Boolean
      {
         var walk:PlayerWalkAction = action as PlayerWalkAction;
         if(walk && _target.equals(walk._target))
         {
            _target = walk._target;
            _dir = walk._dir;
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
         if(_living.isLiving)
         {
            _living.startMoving();
         }
         else
         {
            finish();
         }
      }
      
      override public function execute() : void
      {
         var p:* = null;
         if(Point.distance(_living.pos,_target) <= _living.stepX || _target.x == _living.x)
         {
            finish();
         }
         else
         {
            _living.info.direction = _target.x > _living.x?1:-1;
            p = _living.getNextWalkPoint(_living.info.direction);
            if(p == null || _living.info.direction > 0 && p.x >= _target.x || _living.info.direction < 0 && p.x <= _target.x)
            {
               finish();
            }
            else
            {
               _living.info.pos = p;
               _living.doAction(_action);
               if(_living is GamePlayer3D)
               {
                  GamePlayer3D(_living).body.WingState = "move";
               }
               SoundManager.instance.play("044",false,false);
               if(!_living.info.isHidden)
               {
                  if(!GameControl.Instance.Current.togetherShoot || _living is GameLocalPlayer3D)
                  {
                     _living.needFocus(0,0,{
                        "strategy":"directly",
                        "priority":1
                     });
                  }
               }
            }
         }
      }
      
      private function finish() : void
      {
         _living.info.pos = _target;
         _living.info.direction = _dir;
         _living.stopMoving();
         if(_living.isLiving)
         {
            _living.doAction(GameCharacter3D.STAND);
         }
         _isFinished = true;
         if(_finishedFun != null)
         {
            _finishedFun();
            _finishedFun = null;
         }
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         _living.info.pos = _target;
         _living.info.direction = _dir;
         _living.stopMoving();
      }
   }
}
