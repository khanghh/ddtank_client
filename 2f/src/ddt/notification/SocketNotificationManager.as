package ddt.notification
{
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   
   public class SocketNotificationManager
   {
      
      private static var instance:SocketNotificationManager;
       
      
      private var _p1Dic:Dictionary;
      
      public function SocketNotificationManager(param1:inner){super();}
      
      public static function getInstance() : SocketNotificationManager{return null;}
      
      public function addNotificationListener(param1:int, param2:int, param3:Function) : void{}
      
      public function removeNotificationListener(param1:int, param2:int, param3:Function) : void{}
      
      public function dispatchNotification(param1:int, param2:int, param3:PackageIn) : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
