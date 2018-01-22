package trainer.controller
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.Event;
   import trainer.data.Step;
   
   public class NewHandQueue
   {
      
      private static var _instance:NewHandQueue;
       
      
      private var _queue:Array;
      
      private var _isDelay:Boolean;
      
      public function NewHandQueue(param1:NewHandQueueEnforcer)
      {
         super();
         _queue = [];
         _isDelay = false;
         StageReferance.stage.addEventListener("enterFrame",__enterFrame);
      }
      
      public static function get Instance() : NewHandQueue
      {
         if(!_instance)
         {
            _instance = new NewHandQueue(new NewHandQueueEnforcer());
         }
         return _instance;
      }
      
      public function push(param1:Step) : void
      {
         _queue.push(param1);
         if(_queue.length == 1)
         {
            _queue[0].prepare();
         }
      }
      
      private function __enterFrame(param1:Event) : void
      {
         var _loc2_:* = null;
         if(_queue == null)
         {
            return;
         }
         if(_isDelay)
         {
            _loc2_ = _queue[0];
            _loc2_.delay = Number(_loc2_.delay) - 1;
            if(_loc2_.delay <= 0)
            {
               _loc2_.prepare();
               _isDelay = false;
            }
         }
         else
         {
            execute();
         }
      }
      
      private function execute() : void
      {
         var _loc1_:* = null;
         if(!_queue)
         {
            return;
         }
         if(_queue.length > 0)
         {
            _loc1_ = _queue[0];
            if(_loc1_.execute())
            {
               if(_loc1_.ID != 100)
               {
                  NewHandGuideManager.Instance.progress = _loc1_.ID;
               }
               _loc1_.finish();
               _loc1_.dispose();
               if(_queue)
               {
                  _queue.shift();
                  next();
               }
            }
         }
      }
      
      private function next() : void
      {
         var _loc1_:* = null;
         if(_queue.length > 0)
         {
            _loc1_ = _queue[0];
            if(_loc1_.delay > 0)
            {
               _isDelay = true;
            }
            else
            {
               _loc1_.prepare();
            }
         }
      }
      
      public function dispose() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",__enterFrame);
         _instance = null;
         _queue = null;
      }
   }
}

class NewHandQueueEnforcer
{
    
   
   function NewHandQueueEnforcer()
   {
      super();
   }
}
