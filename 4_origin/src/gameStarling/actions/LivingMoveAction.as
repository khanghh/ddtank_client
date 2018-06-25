package gameStarling.actions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.objects.GameLiving3D;
   import gameStarling.objects.GameSmallEnemy3D;
   
   public class LivingMoveAction extends BaseAction
   {
       
      
      private var _living:GameLiving3D;
      
      private var _path:Array;
      
      private var _currentPathIndex:int = 0;
      
      private var _dir:int;
      
      private var _endAction:String;
      
      public function LivingMoveAction(living:GameLiving3D, path:Array, dir:int, endAction:String = "")
      {
         super();
         _isFinished = false;
         _living = living;
         _path = path;
         _dir = dir;
         _currentPathIndex = 0;
         _endAction = endAction;
      }
      
      override public function prepare() : void
      {
         if(_living.isLiving)
         {
            _living.startMoving();
            if(!(_living is GameSmallEnemy3D) || _living == _living.map.currentFocusedLiving)
            {
               _living.needFocus(0,0,{
                  "strategy":"directly",
                  "priority":0
               });
            }
         }
         else
         {
            finish();
         }
      }
      
      override public function execute() : void
      {
         if(_living is GameSmallEnemy3D)
         {
            _living.map.requestForFocus(_living,0);
         }
         else
         {
            _living.needFocus(0,0,{
               "strategy":"directly",
               "priority":0
            });
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
