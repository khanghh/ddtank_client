package ddt.manager
{
   import com.pickgliss.loader.LoadResourceManager;
   import flash.external.ExternalInterface;
   
   public class DesktopManager
   {
      
      private static var _instance:DesktopManager;
       
      
      private var _desktopType:int;
      
      private var _landersAwardFlag:Boolean;
      
      public function DesktopManager()
      {
         super();
      }
      
      public static function get Instance() : DesktopManager
      {
         if(_instance == null)
         {
            _instance = new DesktopManager();
         }
         return _instance;
      }
      
      public function checkIsDesktop() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("SetIsDesktop",SetIsDesktop);
            ExternalInterface.addCallback("landersAward",landersAward);
            ExternalInterface.call("IsDesktop");
         }
         if(LoadResourceManager.Instance.clientType == 2)
         {
            SetIsDesktop();
         }
      }
      
      private function landersAward() : void
      {
         _landersAwardFlag = true;
      }
      
      private function SetIsDesktop() : void
      {
         _desktopType = 1;
      }
      
      public function get isDesktop() : Boolean
      {
         return _desktopType > 0;
      }
      
      public function get desktopType() : int
      {
         return _desktopType;
      }
      
      public function backToLogin() : void
      {
         ExternalInterface.call("WindowReturn");
      }
      
      public function get landersAwardFlag() : Boolean
      {
         return _landersAwardFlag;
      }
   }
}
