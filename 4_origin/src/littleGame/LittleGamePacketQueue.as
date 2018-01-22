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
      
      public function addQueue(param1:LittleGameSocketEvent) : void
      {
         _waitlist.push(param1);
      }
      
      public function startup() : void
      {
         ProcessManager.Instance.addObject(this);
      }
      
      public function shutdown() : void
      {
         ProcessManager.Instance.removeObject(this);
      }
      
      public function setLifeTime(param1:int) : void
      {
         _lifeTime = param1;
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
      
      public function set onProcess(param1:Boolean) : void
      {
         _onProcess = param1;
      }
      
      public function get running() : Boolean
      {
         return _onProcess;
      }
      
      public function process(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         _lifeTime = Number(_lifeTime) + 1;
         if(running)
         {
            _loc2_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _waitlist.length)
            {
               _loc3_ = _waitlist[_loc5_];
               if(_loc3_.pkg.extend2 <= _lifeTime)
               {
                  _executable.push(_loc3_);
                  _loc2_++;
                  _loc5_++;
                  continue;
               }
               break;
            }
            _waitlist.splice(0,_loc2_);
            _loc2_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _executable.length)
            {
               if(running)
               {
                  dispatchEvent(_executable[_loc4_]);
                  _loc2_++;
               }
               _loc4_++;
            }
            _executable.splice(0,_loc2_);
         }
      }
      
      private function dispatchEvent(param1:Event) : void
      {
         try
         {
            SocketManager.Instance.dispatchEvent(param1);
            return;
         }
         catch(err:Error)
         {
            SocketManager.Instance.out.sendErrorMsg("type:" + param1.type + "msg:" + err.message + "\r\n" + err.getStackTrace());
            trace(param1.type,err.message,err.getStackTrace());
            return;
         }
      }
   }
}
