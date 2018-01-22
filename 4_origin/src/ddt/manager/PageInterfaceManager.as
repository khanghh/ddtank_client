package ddt.manager
{
   import flash.external.ExternalInterface;
   import flash.system.fscommand;
   
   public class PageInterfaceManager
   {
       
      
      public function PageInterfaceManager()
      {
         super();
      }
      
      public static function changePageTitle() : void
      {
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call("title_effect.tickerBegin",LanguageMgr.GetTranslation("pageInterface.yourturn"));
         }
         else
         {
            fscommand("OnTitleChanged","0|" + LanguageMgr.GetTranslation("pageInterface.yourturn"));
         }
      }
      
      public static function restorePageTitle() : void
      {
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call("title_effect.tickerStop");
         }
         else
         {
            fscommand("OnTitleChanged","1|" + LanguageMgr.GetTranslation("pageInterface.yourturn"));
         }
      }
      
      public static function askForFavorite() : void
      {
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call("AddFavorite",PathManager.solveLogin());
         }
      }
      
      private static function call(param1:String, ... rest) : void
      {
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call(param1,rest);
         }
      }
   }
}
