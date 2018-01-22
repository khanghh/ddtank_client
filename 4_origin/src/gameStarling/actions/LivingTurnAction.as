package gameStarling.actions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.objects.GameLiving3D;
   
   public class LivingTurnAction extends BaseAction
   {
      
      public static const PLUS:int = 0;
      
      public static const REDUCE:int = 1;
       
      
      private var _movie:GameLiving3D;
      
      private var _rotation:int;
      
      private var _speed:int;
      
      private var _endPlay:String;
      
      private var _dir:int;
      
      private var _turnRo:int;
      
      public function LivingTurnAction(param1:GameLiving3D, param2:int, param3:int, param4:String)
      {
         super();
         _isFinished = false;
         _movie = param1;
         _rotation = param2;
         _speed = param3;
         _endPlay = param4;
      }
      
      override public function connect(param1:BaseAction) : Boolean
      {
         var _loc2_:LivingTurnAction = param1 as LivingTurnAction;
         if(_loc2_)
         {
            _rotation = _loc2_._rotation;
            _speed = _loc2_._speed;
            _endPlay = _loc2_._endPlay;
            _dir = _movie.angle > _rotation?1:0;
            return true;
         }
         return false;
      }
      
      override public function prepare() : void
      {
         if(_movie)
         {
            _dir = _movie.angle > _rotation?1:0;
            _turnRo = _movie.angle;
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
               _movie.angle = _turnRo;
            }
         }
         else if(_turnRo - _speed <= _rotation)
         {
            finish();
         }
         else
         {
            _turnRo = _turnRo - _speed;
            _movie.angle = _turnRo;
         }
      }
      
      private function finish() : void
      {
         _movie.angle = _rotation;
         _movie.doAction(_endPlay);
         _isFinished = true;
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         _movie.angle = _rotation;
         _movie.doAction(_endPlay);
      }
   }
}
