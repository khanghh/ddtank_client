package game.actions
{
   import ddt.manager.SoundManager;
   import ddt.view.character.GameCharacter;
   import flash.geom.Point;
   import game.objects.GameLocalPlayer;
   import game.objects.GamePlayer;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Player;
   
   public class GhostMoveAction extends BaseAction
   {
       
      
      private var _startPos:Point;
      
      private var _target:Point;
      
      private var _player:GamePlayer;
      
      private var _vp:Point;
      
      private var _start:Point;
      
      private var _life:int = 0;
      
      private var _pickBoxActions:Array;
      
      public function GhostMoveAction(param1:GamePlayer, param2:Point, param3:Array = null)
      {
         super();
         _target = param2;
         _player = param1;
         _startPos = _player.pos;
         _pickBoxActions = param3;
         _vp = _target.subtract(_startPos);
         _vp.normalize(2);
      }
      
      override public function prepare() : void
      {
         if(_isPrepare)
         {
            return;
         }
         _isPrepare = true;
         SoundManager.instance.play("010",true);
         _player.startMoving();
         _player.body.doAction(GameCharacter.SOUL_MOVE);
      }
      
      override public function execute() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         _player.info.direction = _vp.x > 0?1:-1;
         if(Point.distance(_startPos,_target) > _vp.length)
         {
            if(_vp.length < Player.GHOST_MOVE_SPEED)
            {
               _vp.normalize(_vp.length * 1.1);
            }
            _loc2_ = _startPos;
            _startPos = _startPos.add(_vp);
            _player.info.pos = _startPos;
            _loc1_ = _startPos;
            if(_player is GameLocalPlayer)
            {
               (_player as GameLocalPlayer).localPlayer.energy = (_player as GameLocalPlayer).localPlayer.energy - Math.round(Point.distance(_loc2_,_loc1_) / 1.5);
            }
         }
         else
         {
            _player.info.pos = _target;
            if(_player is GameLocalPlayer)
            {
               GameLocalPlayer(_player).hideTargetMouseTip();
            }
            finish();
         }
         _life = _life + 40;
         var _loc5_:int = 0;
         var _loc4_:* = _pickBoxActions;
         for each(var _loc3_ in _pickBoxActions)
         {
            if(_life >= _loc3_.time && !_loc3_.executed)
            {
               _loc3_.execute(_player);
            }
         }
      }
      
      public function finish() : void
      {
         _player.body.doAction(GameCharacter.SOUL);
         _player.stopMoving();
         _isFinished = true;
      }
      
      override public function executeAtOnce() : void
      {
         _player.pos = _target;
         super.executeAtOnce();
      }
   }
}
