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
      
      public function GhostMoveAction(player:GamePlayer, target:Point, actions:Array = null)
      {
         super();
         _target = target;
         _player = player;
         _startPos = _player.pos;
         _pickBoxActions = actions;
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
         var posA:* = null;
         var posB:* = null;
         _player.info.direction = _vp.x > 0?1:-1;
         if(Point.distance(_startPos,_target) > _vp.length)
         {
            if(_vp.length < Player.GHOST_MOVE_SPEED)
            {
               _vp.normalize(_vp.length * 1.1);
            }
            posA = _startPos;
            _startPos = _startPos.add(_vp);
            _player.info.pos = _startPos;
            posB = _startPos;
            if(_player is GameLocalPlayer)
            {
               (_player as GameLocalPlayer).localPlayer.energy = (_player as GameLocalPlayer).localPlayer.energy - Math.round(Point.distance(posA,posB) / 1.5);
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
         for each(var act in _pickBoxActions)
         {
            if(_life >= act.time && !act.executed)
            {
               act.execute(_player);
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
