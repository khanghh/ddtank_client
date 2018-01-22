package game.actions
{
   import ddt.manager.SocketManager;
   import flash.utils.getQualifiedClassName;
   import gameCommon.actions.BaseAction;
   
   public class ActionManager
   {
       
      
      private var _queue:Array;
      
      public function ActionManager()
      {
         super();
         _queue = [];
      }
      
      public function act(param1:BaseAction) : void
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
      
      public function traceAllRemainAction(param1:String = "") : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:String = "";
         _loc5_ = 0;
         while(_loc5_ < _queue.length)
         {
            _loc2_ = getQualifiedClassName(_queue[_loc5_]);
            _loc3_ = _loc2_.split("::");
            _loc4_ = _loc4_ + (_loc3_[_loc3_.length - 1] + " | ");
            _loc5_++;
         }
         SocketManager.Instance.out.sendErrorMsg("客户端卡死了" + param1 + " : " + _loc4_);
      }
      
      public function get actionCount() : int
      {
         return _queue.length;
      }
      
      public function executeAtOnce() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _queue;
         for each(var _loc1_ in _queue)
         {
            _loc1_.executeAtOnce();
         }
      }
      
      public function clear() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _queue;
         for each(var _loc1_ in _queue)
         {
            _loc1_.cancel();
         }
         _queue = [];
      }
   }
}
