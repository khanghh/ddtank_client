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
      
      private function __showResponseInviteFrameHandler(param1:CEvent) : void
      {
         var _loc3_:InviteInfo = param1.data as InviteInfo;
         var _loc2_:ResponseInviteFrame = ResponseInviteFrame.newInvite(_loc3_);
         _loc2_.show();
      }
      
      private function __clearResponseInviteFrameHandler(param1:CEvent) : void
      {
         ResponseInviteFrame.clearInviteFrame();
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(_enabled == param1)
         {
            return;
         }
         _enabled = param1;
      }
      
      public function clearResponseInviteFrame() : void
      {
         dispatchEvent(new CEvent("clearResponseInviteFrame"));
      }
      
      public function showResponseInviteFrame(param1:InviteInfo) : void
      {
         _inviteFrameInfo = param1;
         dispatchEvent(new CEvent("showResponseInviteFrame",_inviteFrameInfo));
      }
   }
}
