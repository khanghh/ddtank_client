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
      
      public static function setup(stage:Stage) : void
      {
         stage.addEventListener("enterFrame",frameHandler);
      }
      
      public static function pause() : void
      {
         _running = false;
      }
      
      public static function resume() : void
      {
         _running = true;
      }
      
      public static function setLifeTime(value:int) : void
      {
         _lifeTime = value;
         _executable.concat(_waitlist);
      }
      
      public static function addQueue(e:CrazyTankSocketEvent) : void
      {
         _waitlist.push(e);
      }
      
      private static function frameHandler(event:Event) : void
      {
         var count:int = 0;
         var i:int = 0;
         var evt:* = null;
         var index:int = 0;
         var j:int = 0;
         _lifeTime = Number(_lifeTime) + 1;
         if(_running)
         {
            count = 0;
            i = 0;
            for(i = 0; i < _waitlist.length; )
            {
               evt = _waitlist[i];
               if(evt.pkg.extend2 <= _lifeTime)
               {
                  _executable.push(evt);
                  count++;
               }
               i++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = _executable;
            for each(var e in _executable)
            {
               index = _waitlist.indexOf(e);
               if(index != -1)
               {
                  _waitlist.splice(index,1);
               }
            }
            count = 0;
            for(j = 0; j < _executable.length; )
            {
               if(_running)
               {
                  dispatchEvent(_executable[j]);
                  count++;
               }
               j++;
            }
            _executable.splice(0,count);
         }
      }
      
      private static function dispatchEvent(event:Event) : void
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
      
      public static function get executable() : Array
      {
         return _executable;
      }
   }
}
