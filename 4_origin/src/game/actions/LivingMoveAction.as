package game.actions
{
   import game.objects.GameLiving;
   import game.objects.GameSmallEnemy;
   import gameCommon.actions.BaseAction;
   
   public class LivingMoveAction extends BaseAction
   {
       
      
      private var _living:GameLiving;
      
      private var _path:Array;
      
      private var _currentPathIndex:int = 0;
      
      private var _dir:int;
      
      private var _endAction:String;
      
      public function LivingMoveAction(param1:GameLiving, param2:Array, param3:int, param4:String = "")
      {
         super();
         _isFinished = false;
         _living = param1;
         _path = param2;
         _dir = param3;
         _currentPathIndex = 0;
         _endAction = param4;
      }
      
      override public function prepare() : void
      {
         if(_living.isLiving)
         {
            _living.startMoving();
            if(!(_living is GameSmallEnemy) || _living == _living.map.currentFocusedLiving)
            {
               _living.needFocus(0,0,{
                  "strategy":"directly",
                  "priority":0
               });
            }
            if(_path[0].x < _path[_path.length - 1].x)
            {
               if(_living.actionMovie && !_living.actionMovie.shouldReplace)
               {
                  _living.actionMovie.scaleX = -1;
               }
            }
            else if(_path[0].x > _path[_path.length - 1].x)
            {
               if(_living.actionMovie && !_living.actionMovie.shouldReplace)
               {
                  _living.actionMovie.scaleX = 1;
               }
            }
         }
         else
         {
            finish();
         }
      }
      
      override public function execute() : void
      {
         if(_living is GameSmallEnemy)
         {
            _living.map.requestForFocus(_living,0);
         }
         else
         {
            _living.needFocus(0,0,{
               "strategy":"directly",
               "priority":0
            },_living);
         }
         if(_path[_currentPathIndex])
         {
            _living.info.pos = _path[_currentPathIndex];
         }
         _currentPathIndex = Number(_currentPathIndex) + 1;
         if(_currentPathIndex >= _path.length)
         {
            finish();
            if(_endAction != "")
            {
               _living.doAction(_endAction);
            }
            else
            {
               _living.info.doDefaultAction();
            }
         }
      }
      
      private function finish() : void
      {
         _living.stopMoving();
         _isFinished = true;
      }
      
      override public function cancel() : void
      {
         _isFinished = true;
      }
   }
}
