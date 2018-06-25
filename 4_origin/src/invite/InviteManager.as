package invite
{
   import ddt.CoreManager;
   import ddt.data.InviteInfo;
   import ddt.events.CEvent;
   
   public class InviteManager extends CoreManager
   {
      
      public static const SHOW_RESPONSEINVITEFRAME:String = "showResponseInviteFrame";
      
      public static const CLEAR_RESPONSEINVITEFRAME:String = "clearResponseInviteFrame";
      
      private static var _ins:InviteManager;
       
      
      private var _enabled:Boolean = true;
      
      private var _inviteFrameInfo:InviteInfo;
      
      public function InviteManager()
      {
         super();
      }
      
      public static function get Instance() : InviteManager
      {
         return _ins || new InviteManager();
      }
      
      public function setup() : void
      {
         InviteManager.Instance.addEventListener("showResponseInviteFrame",__showResponseInviteFrameHandler);
         InviteManager.Instance.addEventListener("clearResponseInviteFrame",__clearResponseInviteFrameHandler);
      }
      
      private function __showResponseInviteFrameHandler(event:CEvent) : void
      {
         var info:InviteInfo = event.data as InviteInfo;
         var response:ResponseInviteFrame = ResponseInviteFrame.newInvite(info);
         response.show();
      }
      
      private function __clearResponseInviteFrameHandler(event:CEvent) : void
      {
         ResponseInviteFrame.clearInviteFrame();
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(value:Boolean) : void
      {
         if(_enabled == value)
         {
            return;
         }
         _enabled = value;
      }
      
      public function clearResponseInviteFrame() : void
      {
         dispatchEvent(new CEvent("clearResponseInviteFrame"));
      }
      
      public function showResponseInviteFrame(info:InviteInfo) : void
      {
         _inviteFrameInfo = info;
         dispatchEvent(new CEvent("showResponseInviteFrame",_inviteFrameInfo));
      }
   }
}
