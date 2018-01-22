package ddt.notification
{
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   
   public class SocketNotificationManager
   {
      
      private static var instance:SocketNotificationManager;
       
      
      private var _p1Dic:Dictionary;
      
      public function SocketNotificationManager(param1:inner)
      {
         super();
         _p1Dic = new Dictionary();
      }
      
      public static function getInstance() : SocketNotificationManager
      {
         if(!instance)
         {
            instance = new SocketNotificationManager(new inner());
         }
         return instance;
      }
      
      public function addNotificationListener(param1:int, param2:int, param3:Function) : void
      {
         var _loc5_:Dictionary = _p1Dic[param1];
         if(_loc5_ == null)
         {
            _loc5_ = new Dictionary();
         }
         var _loc4_:Array = _loc5_[param2];
         if(_loc4_ == null)
         {
            _loc4_ = [];
         }
         _loc4_.push(param3);
         _loc5_[param2] = _loc4_;
         _p1Dic[param1] = _loc5_;
      }
      
      public function removeNotificationListener(param1:int, param2:int, param3:Function) : void
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:Dictionary = _p1Dic[param1];
         if(_loc6_ != null)
         {
            _loc5_ = _loc6_[param2];
            if(_loc5_ != null)
            {
               _loc7_ = _loc5_.length;
               _loc8_ = 0;
               while(_loc8_ < _loc7_)
               {
                  if(_loc5_[_loc8_] == param3)
                  {
                     if(_loc8_ + 1 == _loc7_)
                     {
                        _loc5_.pop();
                     }
                     else
                     {
                        _loc5_[_loc8_] = _loc5_.pop();
                     }
                     if(_loc5_.length == 0)
                     {
                        delete _loc6_[param2];
                        var _loc10_:int = 0;
                        var _loc9_:* = _p1Dic[param1];
                        for each(var _loc4_ in _p1Dic[param1])
                        {
                           return;
                        }
                        delete _p1Dic[param1];
                     }
                     break;
                  }
                  _loc8_++;
               }
            }
         }
      }
      
      public function dispatchNotification(param1:int, param2:int, param3:PackageIn) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Dictionary = _p1Dic[param1];
         if(_loc7_ != null)
         {
            _loc4_ = _loc7_[param2];
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.length;
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc4_[_loc6_](param3);
                  _loc6_++;
               }
            }
         }
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
