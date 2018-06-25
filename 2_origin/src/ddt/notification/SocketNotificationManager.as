package ddt.notification
{
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   
   public class SocketNotificationManager
   {
      
      private static var instance:SocketNotificationManager;
       
      
      private var _p1Dic:Dictionary;
      
      public function SocketNotificationManager(single:inner)
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
      
      public function addNotificationListener(lv1:int, lv2:int, handler:Function) : void
      {
         var __p2:Dictionary = _p1Dic[lv1];
         if(__p2 == null)
         {
            __p2 = new Dictionary();
         }
         var handlerList:Array = __p2[lv2];
         if(handlerList == null)
         {
            handlerList = [];
         }
         handlerList.push(handler);
         __p2[lv2] = handlerList;
         _p1Dic[lv1] = __p2;
      }
      
      public function removeNotificationListener(lv1:int, lv2:int, handler:Function) : void
      {
         var hdlrArr:* = null;
         var len:int = 0;
         var i:int = 0;
         var __p2:Dictionary = _p1Dic[lv1];
         if(__p2 != null)
         {
            hdlrArr = __p2[lv2];
            if(hdlrArr != null)
            {
               len = hdlrArr.length;
               for(i = 0; i < len; )
               {
                  if(hdlrArr[i] == handler)
                  {
                     if(i + 1 == len)
                     {
                        hdlrArr.pop();
                     }
                     else
                     {
                        hdlrArr[i] = hdlrArr.pop();
                     }
                     if(hdlrArr.length == 0)
                     {
                        delete __p2[lv2];
                        var _loc10_:int = 0;
                        var _loc9_:* = _p1Dic[lv1];
                        for each(var v in _p1Dic[lv1])
                        {
                           return;
                        }
                        delete _p1Dic[lv1];
                     }
                     break;
                  }
                  i++;
               }
            }
         }
      }
      
      public function dispatchNotification(lv1:int, lv2:int, pkg:PackageIn) : void
      {
         var handlerList:* = null;
         var len:int = 0;
         var i:int = 0;
         var p2Dic:Dictionary = _p1Dic[lv1];
         if(p2Dic != null)
         {
            handlerList = p2Dic[lv2];
            if(handlerList != null)
            {
               len = handlerList.length;
               for(i = 0; i < len; )
               {
                  handlerList[i](pkg);
                  i++;
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
