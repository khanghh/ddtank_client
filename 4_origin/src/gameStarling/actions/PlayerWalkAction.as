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
      
      public function PlayerWalkAction(param1:GameLiving3D, param2:Point, param3:Number, param4:* = null, param5:Function = null)
      {
         super();
         _isFinished = false;
         _self = GameControl.Instance.Current.selfGamePlayer;
         _living = param1;
         _action = !!param4?param4:GameCharacter3D.WALK;
         _target = param2;
         _dir = param3;
         _finishedFun = param5;
      }
      
      override public function connect(param1:BaseAction) : Boolean
      {
         var _loc2_:PlayerWalkAction = param1 as PlayerWalkAction;
         if(_loc2_ && _target.equals(_loc2_._target))
         {
            _target = _loc2_._target;
            _dir = _loc2_._dir;
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
         var _loc1_:* = null;
         if(Point.distance(_living.pos,_target) <= _living.stepX || _target.x == _living.x)
         {
            finish();
         }
         else
         {
            _living.info.direction = _target.x > _living.x?1:-1;
            _loc1_ = _living.getNextWalkPoint(_living.info.direction);
            if(_loc1_ == null || _living.info.direction > 0 && _loc1_.x >= _target.x || _living.info.direction < 0 && _loc1_.x <= _target.x)
            {
               finish();
            }
            else
            {
               _living.info.pos = _loc1_;
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
