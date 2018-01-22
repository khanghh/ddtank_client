package ddt.manager
{
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.sendToURL;
   
   public class ExternalInterfaceManager
   {
      
      private static var loader:URLLoader;
       
      
      public function ExternalInterfaceManager(){super();}
      
      public static function sendToAgent(param1:int, param2:int = -1, param3:String = "", param4:String = "", param5:int = -1, param6:String = "", param7:String = "") : void{}
      
      public static function sendTo360Agent(param1:int) : void{}
      
      private static function getEvent(param1:int) : String{return null;}
   }
}
