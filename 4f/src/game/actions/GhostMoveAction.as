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
      
      public function GhostMoveAction(param1:GamePlayer, param2:Point, param3:Array = null){super();}
      
      override public function prepare() : void{}
      
      override public function execute() : void{}
      
      public function finish() : void{}
      
      override public function executeAtOnce() : void{}
   }
}
