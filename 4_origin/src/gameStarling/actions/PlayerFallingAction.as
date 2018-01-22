package gameStarling.actions
{
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameStarling.objects.GameLiving3D;
   
   public class PlayerFallingAction extends BaseAction
   {
       
      
      protected var _player:GameLiving3D;
      
      private var _info:Living;
      
      private var _target:Point;
      
      private var _isLiving:Boolean;
      
      private var _canIgnore:Boolean;
      
      private var _finishedFun:Function;
      
      public function PlayerFallingAction(param1:GameLiving3D, param2:Point, param3:Boolean, param4:Boolean, param5:Function = null)
      {
         super();
         _target = param2;
         _isLiving = param3;
         if(!_isLiving)
         {
            _target.y = _target.y + 70;
         }
         _info = param1.info;
         _player = param1;
         _canIgnore = param4;
         _finishedFun = param5;
      }
      
      override public function connect(param1:BaseAction) : Boolean
      {
         var _loc2_:PlayerFallingAction = param1 as PlayerFallingAction;
         if(_loc2_ && _loc2_._target.y < _target.y)
         {
            return true;
         }
         return false;
      }
      
      override public function canReplace(param1:BaseAction) : Boolean
      {
         if(param1 is PlayerWalkAction)
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
            _player.info.isFalling = false;
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
