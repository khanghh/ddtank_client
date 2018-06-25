package game.actions
{
   import game.view.map.MapView;
   import gameCommon.actions.BaseAction;
   
   public class ViewEachObjectAction extends BaseAction
   {
       
      
      private var _map:MapView;
      
      private var _objects:Array;
      
      private var _interval:Number;
      
      private var _index:int;
      
      private var _count:int;
      
      private var _type:int;
      
      public function ViewEachObjectAction(map:MapView, objects:Array, type:int = 0, interval:Number = 1500)
      {
         super();
         _objects = objects;
         _map = map;
         _interval = interval / 40;
         _index = 0;
         _count = 0;
         _type = type;
      }
      
      override public function canReplace(action:BaseAction) : Boolean
      {
         var i:int = 0;
         var viewAction:ViewEachObjectAction = action as ViewEachObjectAction;
         if(viewAction && viewAction.objects.length == _objects.length)
         {
            for(i = 0; i < _objects.length; )
            {
               if(_objects[i].x != viewAction.objects[i].x || _objects[i].y != viewAction.objects[i].y)
               {
                  return false;
               }
               i++;
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
