package ddt.manager
{
   import ddt.events.CrazyTankSocketEvent;
   import flash.display.Stage;
   import flash.events.Event;
   
   public class QueueManager
   {
      
      private static var _executable:Array = [];
      
      public static var _waitlist:Array = [];
      
      private static var _lifeTime:int = 0;
      
      private static var _running:Boolean = true;
      
      private static var _diffTimeValue:int = 0;
      
      private static var _speedUp:int = 2;
       
      
      public function QueueManager()
      {
         super();
      }
      
      public static function get lifeTime() : int
      {
         return _lifeTime;
      }
      
      public static function setup(param1:Stage) : void
      {
         param1.addEventListener("enterFrame",frameHandler);
      }
      
      public static function pause() : void
      {
         _running = false;
      }
      
      public static function resume() : void
      {
         _running = true;
      }
      
      public static function setLifeTime(param1:int) : void
      {
         _lifeTime = param1;
         _executable.concat(_waitlist);
      }
      
      public static function addQueue(param1:CrazyTankSocketEvent) : void
      {
         _waitlist.push(param1);
      }
      
      private static function frameHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         _lifeTime = Number(_lifeTime) + 1;
         if(_running)
         {
            _loc4_ = 0;
            _loc7_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _waitlist.length)
            {
               _loc5_ = _waitlist[_loc7_];
               if(_loc5_.pkg.extend2 <= _lifeTime)
               {
                  _executable.push(_loc5_);
                  _loc4_++;
               }
               _loc7_++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = _executable;
            for each(var _loc3_ in _executable)
            {
               _loc2_ = _waitlist.indexOf(_loc3_);
               if(_loc2_ != -1)
               {
                  _waitlist.splice(_loc2_,1);
               }
            }
            _loc4_ = 0;
            _loc6_ = 0;
            while(_loc6_ < _executable.length)
            {
               if(_running)
               {
                  dispatchEvent(_executable[_loc6_]);
                  _loc4_++;
               }
               _loc6_++;
            }
            _executable.splice(0,_loc4_);
         }
      }
      
      private static function dispatchEvent(param1:Event) : void
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
      
      public static function get executable() : Array
      {
         return _executable;
      }
   }
}
