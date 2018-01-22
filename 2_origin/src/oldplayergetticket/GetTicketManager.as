package oldplayergetticket
{
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.utils.HelperUIModuleLoad;
   
   public class GetTicketManager extends CoreManager
   {
      
      public static const GETTICKET_DATA:String = "getTicket_data";
      
      public static const UPDATETICKET_DATA:String = "updateTicket_data";
      
      public static const HIDE_VIEW:String = "hide_view";
      
      private static var _instance:GetTicketManager;
       
      
      public var ticketInfo:Array;
      
      public function GetTicketManager()
      {
         super();
         initEvent();
      }
      
      public static function get instance() : GetTicketManager
      {
         if(!_instance)
         {
            _instance = new GetTicketManager();
         }
         return _instance;
      }
      
      private function initEvent() : void
      {
         addEventListener("getTicket_data",getTicketData);
      }
      
      protected function getTicketData(param1:CEvent) : void
      {
         ticketInfo = param1.data as Array;
         dispatchEvent(new CEvent("updateTicket_data"));
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["ddtGetTicketView"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new CEvent("openview"));
      }
      
      public function hide() : void
      {
         dispatchEvent(new CEvent("hide_view"));
      }
   }
}
