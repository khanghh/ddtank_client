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
      
      public function act(param1:LittleAction) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _queue.length)
         {
            _loc2_ = _queue[_loc3_];
            if(_loc2_.connect(param1))
            {
               return;
            }
            if(_loc2_.canReplace(param1))
            {
               param1.prepare();
               _queue[_loc3_] = param1;
               return;
            }
            _loc3_++;
         }
         _queue.push(param1);
         if(_queue.length == 1)
         {
            param1.prepare();
         }
      }
      
      public function execute() : void
      {
         var _loc1_:* = null;
         if(_queue.length > 0)
         {
            _loc1_ = _queue[0];
            if(!_loc1_.isFinished)
            {
               _loc1_.execute();
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
         for each(var _loc1_ in _queue)
         {
            _loc1_.cancel();
         }
         _queue = null;
      }
   }
}
