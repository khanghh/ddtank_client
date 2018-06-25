package wasteRecycle
{
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import wonderfulActivity.WonderfulActivityManager;
   
   public class WasteRecycleManager
   {
      
      private static var _instance:WasteRecycleManager;
       
      
      private var _endDate:Date;
      
      private var _isOpen:Boolean;
      
      public function WasteRecycleManager()
      {
         super();
      }
      
      public static function get Instance() : WasteRecycleManager
      {
         if(!_instance)
         {
            _instance = new WasteRecycleManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(346,4),__onActivity);
      }
      
      private function __onActivity(e:PkgEvent) : void
      {
         _isOpen = e.pkg.readBoolean();
         if(_isOpen)
         {
            _endDate = e.pkg.readDate();
            WonderfulActivityManager.Instance.addElement(50);
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("ddt.wasteRecycle.activityStart"));
         }
         else
         {
            WonderfulActivityManager.Instance.removeElement(50);
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("ddt.wasteRecycle.activityEnd"));
         }
      }
      
      public function get endDate() : Date
      {
         return _endDate;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
   }
}
