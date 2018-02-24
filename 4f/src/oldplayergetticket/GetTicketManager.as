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
      
      public function GetTicketManager(){super();}
      
      public static function get instance() : GetTicketManager{return null;}
      
      private function initEvent() : void{}
      
      protected function getTicketData(param1:CEvent) : void{}
      
      override protected function start() : void{}
      
      private function onLoaded() : void{}
      
      public function hide() : void{}
   }
}
