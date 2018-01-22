package gameStarling.actions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.view.map.MapView3D;
   
   public class ViewEachObjectAction extends BaseAction
   {
       
      
      private var _map:MapView3D;
      
      private var _objects:Array;
      
      private var _interval:Number;
      
      private var _index:int;
      
      private var _count:int;
      
      private var _type:int;
      
      public function ViewEachObjectAction(param1:MapView3D, param2:Array, param3:int = 0, param4:Number = 1500)
      {
         super();
         _objects = param2;
         _map = param1;
         _interval = param4 / 40;
         _index = 0;
         _count = 0;
         _type = param3;
      }
      
      override public function canReplace(param1:BaseAction) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:ViewEachObjectAction = param1 as ViewEachObjectAction;
         if(_loc2_ && _loc2_.objects.length == _objects.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _objects.length)
            {
               if(_objects[_loc3_].x != _loc2_.objects[_loc3_].x || _objects[_loc3_].y != _loc2_.objects[_loc3_].y)
               {
                  return false;
               }
               _loc3_++;
            }
            return true;
         }
         return false;
      }
      
      override public function execute() : void
      {
         if(_count <= 0)
         {
            if(_index < _objects.length)
            {
               _map.scenarioSetCenter(_objects[_index].x,_objects[_index].y,_type);
               _count = _interval;
               _index = Number(_index) + 1;
            }
            else
            {
               _isFinished = true;
            }
         }
         _count = Number(_count) - 1;
      }
      
      public function get objects() : Array
      {
         return _objects;
      }
   }
}
