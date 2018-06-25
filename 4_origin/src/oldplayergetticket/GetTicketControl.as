package oldplayergetticket
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.CEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class GetTicketControl extends EventDispatcher
   {
      
      private static var _instance:GetTicketControl;
       
      
      private var _getTicketView:GetTicketView;
      
      public function GetTicketControl(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : GetTicketControl
      {
         if(!_instance)
         {
            _instance = new GetTicketControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         GetTicketManager.instance.addEventListener("openview",__openViewHandler);
         GetTicketManager.instance.addEventListener("hide_view",__hideViewHandler);
         GetTicketManager.instance.addEventListener("updateTicket_data",__updateTeticketDataHandler);
      }
      
      private function __openViewHandler(event:CEvent) : void
      {
         showGetTicketFrame();
      }
      
      private function __hideViewHandler(event:CEvent) : void
      {
         if(_getTicketView != null)
         {
            _getTicketView.dispose();
         }
         _getTicketView = null;
      }
      
      private function showGetTicketFrame() : void
      {
         _getTicketView = ComponentFactory.Instance.creatComponentByStylename("oldplayer.getTicket");
         _getTicketView.setViewData(GetTicketManager.instance.ticketInfo);
         _getTicketView.show();
      }
      
      private function __updateTeticketDataHandler(event:CEvent) : void
      {
         if(_getTicketView)
         {
            _getTicketView.setViewData(GetTicketManager.instance.ticketInfo);
         }
      }
   }
}
