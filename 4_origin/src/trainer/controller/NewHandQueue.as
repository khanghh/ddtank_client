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
      
      public function NewHandQueue(enforcer:NewHandQueueEnforcer)
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
      
      public function push(step:Step) : void
      {
         _queue.push(step);
         if(_queue.length == 1)
         {
            _queue[0].prepare();
         }
      }
      
      private function __enterFrame(evt:Event) : void
      {
         var step:* = null;
         if(_queue == null)
         {
            return;
         }
         if(_isDelay)
         {
            step = _queue[0];
            step.delay = Number(step.delay) - 1;
            if(step.delay <= 0)
            {
               step.prepare();
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
         var step:* = null;
         if(!_queue)
         {
            return;
         }
         if(_queue.length > 0)
         {
            step = _queue[0];
            if(step.execute())
            {
               if(step.ID != 100)
               {
                  NewHandGuideManager.Instance.progress = step.ID;
               }
               step.finish();
               step.dispose();
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
         var current:* = null;
         if(_queue.length > 0)
         {
            current = _queue[0];
            if(current.delay > 0)
            {
               _isDelay = true;
            }
            else
            {
               current.prepare();
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
