package littleGame
{
   import ddt.interfaces.IProcessObject;
   import ddt.manager.ProcessManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import littleGame.events.LittleGameSocketEvent;
   
   public class LittleGamePacketQueue implements IProcessObject
   {
      
      private static var _ins:LittleGamePacketQueue;
       
      
      private var _executable:Array;
      
      public var _waitlist:Array;
      
      private var _lifeTime:int;
      
      private var _onProcess:Boolean = false;
      
      public function LittleGamePacketQueue()
      {
         super();
      }
      
      public static function get Instance() : LittleGamePacketQueue
      {
         return _ins || new LittleGamePacketQueue();
      }
      
      public function addQueue(event:LittleGameSocketEvent) : void
      {
         _waitlist.push(event);
      }
      
      public function startup() : void
      {
         ProcessManager.Instance.addObject(this);
      }
      
      public function shutdown() : void
      {
         ProcessManager.Instance.removeObject(this);
      }
      
      public function setLifeTime(time:int) : void
      {
         _lifeTime = time;
      }
      
      public function reset() : void
      {
         _executable = [];
         _waitlist = [];
      }
      
      public function dispose() : void
      {
      }
      
      public function get onProcess() : Boolean
      {
         return _onProcess;
      }
      
      public function set onProcess(val:Boolean) : void
      {
         _onProcess = val;
      }
      
      public function get running() : Boolean
      {
         return _onProcess;
      }
      
      public function process(rate:Number) : void
      {
         var count:int = 0;
         var i:int = 0;
         var evt:* = null;
         var j:int = 0;
         _lifeTime = Number(_lifeTime) + 1;
         if(running)
         {
            count = 0;
            for(i = 0; i < _waitlist.length; )
            {
               evt = _waitlist[i];
               if(evt.pkg.extend2 <= _lifeTime)
               {
                  _executable.push(evt);
                  count++;
                  i++;
                  continue;
               }
               break;
            }
            _waitlist.splice(0,count);
            count = 0;
            for(j = 0; j < _executable.length; )
            {
               if(running)
               {
                  dispatchEvent(_executable[j]);
                  count++;
               }
               j++;
            }
            _executable.splice(0,count);
         }
      }
      
      private function dispatchEvent(event:Event) : void
      {
         try
         {
            SocketManager.Instance.dispatchEvent(event);
            return;
         }
         catch(err:Error)
         {
            SocketManager.Instance.out.sendErrorMsg("type:" + event.type + "msg:" + err.message + "\r\n" + err.getStackTrace());
            trace(event.type,err.message,err.getStackTrace());
            return;
         }
      }
   }
}
