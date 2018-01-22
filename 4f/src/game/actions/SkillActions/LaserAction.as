package game.actions.SkillActions
{
   import ddt.command.PlayerAction;
   import ddt.manager.BallManager;
   import ddt.view.character.GameCharacter;
   import flash.display.MovieClip;
   import flash.events.Event;
   import game.objects.GamePlayer;
   import game.view.map.MapView;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import road7th.utils.MovieClipWrapper;
   
   public class LaserAction extends BaseAction
   {
      
      public static const radius:int = 60;
       
      
      private var _player:GamePlayer;
      
      private var _laserMovie:MovieClipWrapper;
      
      private var _movieComplete:Boolean = false;
      
      private var _movieStarted:Boolean = false;
      
      private var _shocked:Boolean = false;
      
      private var _showAction:PlayerAction;
      
      private var _hideAction:PlayerAction;
      
      private var _living:Living;
      
      private var _map:MapView;
      
      private var _angle:int;
      
      private var _speed:int;
      
      private var _length:int;
      
      private var _info:Bomb;
      
      public function LaserAction(param1:Living, param2:MapView, param3:Bomb, param4:int, param5:Number){super();}
      
      override public function prepare() : void{}
      
      override public function execute() : void{}
      
      private function __laserFrame(param1:Event) : void{}
      
      private function __movieComplete(param1:Event) : void{}
   }
}
