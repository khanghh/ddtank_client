package yzhkof.util
{
   import flash.sampler.getMemberNames;
   
   public class QNameUtil
   {
      
      public static const LISTENERS:QName = new QName("flash.events:EventDispatcher","listeners");
      
      public static const SAVEDTHIS:QName = new QName("builtin.as$0:MethodClosure","savedThis");
       
      
      public function QNameUtil(){super();}
      
      public static function isListeners(param1:QName) : Boolean{return false;}
      
      public static function isSavedThis(param1:QName) : Boolean{return false;}
      
      public static function isEqual(param1:QName, param2:QName) : Boolean{return false;}
      
      public static function getObjectQname(param1:Object, param2:QName) : QName{return null;}
   }
}
