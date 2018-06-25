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
      
      public function act(action:BaseAction) : void
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
      
      public function traceAllRemainAction(name:String = "") : void
      {
         var i:int = 0;
         var actionClassName:* = null;
         var tmpArr:* = null;
         var tmp:String = "";
         for(i = 0; i < _queue.length; )
         {
            actionClassName = getQualifiedClassName(_queue[i]);
            tmpArr = actionClassName.split("::");
            tmp = tmp + (tmpArr[tmpArr.length - 1] + " | ");
            i++;
         }
         SocketManager.Instance.out.sendErrorMsg("客户端卡死了" + name + " : " + tmp);
      }
      
      public function get actionCount() : int
      {
         return _queue.length;
      }
      
      public function executeAtOnce() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _queue;
         for each(var action in _queue)
         {
            action.executeAtOnce();
         }
      }
      
      public function clear() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _queue;
         for each(var action in _queue)
         {
            action.cancel();
         }
         _queue = [];
      }
   }
}
