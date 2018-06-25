package game.actions
{
   import game.objects.GameLiving;
   import gameCommon.actions.BaseAction;
   
   public class LivingTurnAction extends BaseAction
   {
      
      public static const PLUS:int = 0;
      
      public static const REDUCE:int = 1;
       
      
      private var _movie:GameLiving;
      
      private var _rotation:int;
      
      private var _speed:int;
      
      private var _endPlay:String;
      
      private var _dir:int;
      
      private var _turnRo:int;
      
      public function LivingTurnAction(movie:GameLiving, $rotation:int, speed:int, endPlay:String)
      {
         super();
         _isFinished = false;
         _movie = movie;
         _rotation = $rotation;
         _speed = speed;
         _endPlay = endPlay;
      }
      
      override public function connect(action:BaseAction) : Boolean
      {
         var turn:LivingTurnAction = action as LivingTurnAction;
         if(turn)
         {
            _rotation = turn._rotation;
            _speed = turn._speed;
            _endPlay = turn._endPlay;
            _dir = _movie.rotation > _rotation?1:0;
            return true;
         }
         return false;
      }
      
      override public function prepare() : void
      {
         if(_movie)
         {
            _dir = _movie.rotation > _rotation?1:0;
            _turnRo = _movie.rotation;
         }
         else
         {
            _isFinished = true;
         }
      }
      
      override public function execute() : void
      {
         if(_dir == 0)
         {
            if(_turnRo + _speed >= _rotation)
            {
               finish();
            }
            else
            {
               _turnRo = _turnRo + _speed;
               _movie.rotation = _turnRo;
            }
         }
         else if(_turnRo - _speed <= _rotation)
         {
            finish();
         }
         else
         {
            _turnRo = _turnRo - _speed;
            _movie.rotation = _turnRo;
         }
      }
      
      private function finish() : void
      {
         _movie.rotation = _rotation;
         _movie.doAction(_endPlay);
         _isFinished = true;
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         _movie.rotation = _rotation;
         _movie.doAction(_endPlay);
      }
   }
}
