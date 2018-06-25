package littleGame.actions
{
   import ddt.ddt_internal;
   
   use namespace ddt_internal;
   
   public class LittleActionManager
   {
       
      
      ddt_internal var _queue:Array;
      
      public function LittleActionManager()
      {
         super();
         _queue = [];
      }
      
      public function act(action:LittleAction) : void
      {
         var i:int = 0;
         var c:* = null;
         for(i = 0; i < _queue.length; )
         {
            c = _queue[i];
            if(c.connect(action))
            {
               return;
            }
            if(c.canReplace(action))
            {
               action.prepare();
               _queue[i] = action;
               return;
            }
            i++;
         }
         _queue.push(action);
         if(_queue.length == 1)
         {
            action.prepare();
         }
      }
      
      public function execute() : void
      {
         var c:* = null;
         if(_queue.length > 0)
         {
            c = _queue[0];
            if(!c.isFinished)
            {
               c.execute();
            }
            else
            {
               _queue.shift();
               if(_queue.length > 0)
               {
                  _queue[0].prepare();
               }
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _queue;
         for each(var action in _queue)
         {
            action.cancel();
         }
         _queue = null;
      }
   }
}
