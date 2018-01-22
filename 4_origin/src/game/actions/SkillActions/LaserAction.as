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
      
      public function LaserAction(param1:Living, param2:MapView, param3:Bomb, param4:int, param5:Number)
      {
         super();
         _living = param1;
         _map = param2;
         _info = param3;
         _angle = param4;
         _length = param5;
      }
      
      override public function prepare() : void
      {
         var _loc2_:int = 0;
         if(_isPrepare)
         {
            return;
         }
         _isPrepare = true;
         _laserMovie = new MovieClipWrapper(BallManager.instance.createBulletMovie(_info.Template.ID));
         var _loc1_:MovieClip = _laserMovie.movie.getChildByName("beam") as MovieClip;
         if(_loc1_)
         {
            _loc1_.width = _length;
         }
         var _loc3_:int = 0;
         if(_living.direction == -1)
         {
            _loc3_ = 180 + _angle;
            _laserMovie.movie.scaleX = -1;
         }
         else
         {
            _loc3_ = _angle;
            _laserMovie.movie.scaleX = 1;
         }
         _laserMovie.movie.rotation = _loc3_;
         if(_living is Player)
         {
            if(_living.direction == 1)
            {
               _laserMovie.movie.x = _living.pos.x + 30;
               _laserMovie.movie.y = _living.pos.y - 20;
            }
            else
            {
               _laserMovie.movie.x = _living.pos.x - 30;
               _laserMovie.movie.y = _living.pos.y - 20;
            }
         }
         else
         {
            _laserMovie.movie.x = _living.pos.x;
            _laserMovie.movie.y = _living.pos.y;
         }
         _map.addChild(_laserMovie.movie);
         _showAction = GameCharacter.SHOT;
         _hideAction = GameCharacter.HIDEGUN;
      }
      
      override public function execute() : void
      {
         if(!_movieStarted)
         {
            _laserMovie.addEventListener("complete",__movieComplete);
            _laserMovie.movie.addEventListener("enterFrame",__laserFrame);
            _laserMovie.gotoAndPlay(1);
            _movieStarted = true;
         }
      }
      
      private function __laserFrame(param1:Event) : void
      {
      }
      
      private function __movieComplete(param1:Event) : void
      {
         _laserMovie.removeEventListener("complete",__movieComplete);
         _laserMovie.movie.removeEventListener("enterFrame",__laserFrame);
         if(_laserMovie.movie.parent)
         {
            _laserMovie.movie.parent.removeChild(_laserMovie.movie);
         }
         _laserMovie.dispose();
         _isFinished = true;
      }
   }
}
