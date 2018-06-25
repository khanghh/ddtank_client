package game.actions
{
   import flash.geom.Point;
   import game.objects.GameLiving;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   
   public class PlayerFallingAction extends BaseAction
   {
       
      
      protected var _player:GameLiving;
      
      private var _info:Living;
      
      private var _target:Point;
      
      private var _isLiving:Boolean;
      
      private var _canIgnore:Boolean;
      
      private var _finishedFun:Function;
      
      public function PlayerFallingAction(player:GameLiving, target:Point, isLiving:Boolean, canIgnore:Boolean, finishedFun:Function = null)
      {
         super();
         _target = target;
         _isLiving = isLiving;
         if(!_isLiving)
         {
            _target.y = _target.y + 70;
         }
         _info = player.info;
         _player = player;
         _canIgnore = canIgnore;
         _finishedFun = finishedFun;
      }
      
      override public function connect(action:BaseAction) : Boolean
      {
         var ac:PlayerFallingAction = action as PlayerFallingAction;
         if(ac && ac._target.y < _target.y)
         {
            return true;
         }
         return false;
      }
      
      override public function canReplace(action:BaseAction) : Boolean
      {
         if(action is PlayerWalkAction)
         {
            if(_canIgnore)
            {
               return true;
            }
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
         if(_player.isLiving)
         {
            if(_player.x == _target.x || !_canIgnore)
            {
               _player.startMoving();
               _player.info.isFalling = true;
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
         if(_target.y - _info.pos.y <= Player.FALL_SPEED)
         {
            executeAtOnce();
         }
         else
         {
            _info.pos = new Point(_target.x,_info.pos.y + Player.FALL_SPEED);
            _player.needFocus(0,0,{
               "strategy":"directly",
               "priority":0
            });
         }
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         _info.pos = _target;
         _player.map.setCenter(_info.pos.x,_info.pos.y - 150,false);
         if(!_isLiving && !GameControl.Instance.playerNotDie)
         {
            _info.die();
         }
         finish();
      }
      
      private function finish() : void
      {
         _isFinished = true;
         _player.stopMoving();
         if(_player.info)
         {
            _player.info.isFalling = false;
         }
         if(_finishedFun != null)
         {
            _finishedFun();
            _finishedFun = null;
         }
      }
   }
}
