package mx.utils
{
   import flash.utils.Dictionary;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class XMLNotifier
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static var instance:XMLNotifier;
       
      
      public function XMLNotifier(param1:XMLNotifierSingleton){super();}
      
      public static function getInstance() : XMLNotifier{return null;}
      
      mx_internal static function initializeXMLForNotification() : Function{return null;}
      
      public function watchXML(param1:Object, param2:IXMLNotifiable, param3:String = null) : void{}
      
      public function unwatchXML(param1:Object, param2:IXMLNotifiable) : void{}
   }
}

class XMLNotifierSingleton
{
    
   
   function XMLNotifierSingleton(){super();}
}
