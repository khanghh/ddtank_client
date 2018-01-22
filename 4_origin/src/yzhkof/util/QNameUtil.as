package yzhkof.util
{
   import flash.sampler.getMemberNames;
   
   public class QNameUtil
   {
      
      public static const LISTENERS:QName = new QName("flash.events:EventDispatcher","listeners");
      
      public static const SAVEDTHIS:QName = new QName("builtin.as$0:MethodClosure","savedThis");
       
      
      public function QNameUtil()
      {
         super();
      }
      
      public static function isListeners(param1:QName) : Boolean
      {
         return isEqual(param1,LISTENERS);
      }
      
      public static function isSavedThis(param1:QName) : Boolean
      {
         return isEqual(param1,SAVEDTHIS);
      }
      
      public static function isEqual(param1:QName, param2:QName) : Boolean
      {
         if(param1.uri == param2.uri && param1.localName == param2.localName)
         {
            return true;
         }
         return false;
      }
      
      public static function getObjectQname(param1:Object, param2:QName) : QName
      {
         var _loc4_:QName = null;
         var _loc3_:Object = getMemberNames(param1);
         for each(_loc4_ in _loc3_)
         {
            if(isEqual(_loc4_,param2))
            {
               return _loc4_;
            }
         }
         return null;
      }
   }
}
