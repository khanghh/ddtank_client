package gotopage.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   
   public class GotoPageController
   {
      
      private static var _instance:GotoPageController;
       
      
      public var _gotoPageView:GotoPageView;
      
      public var isShow:Boolean;
      
      public function GotoPageController(){super();}
      
      public static function get Instance() : GotoPageController{return null;}
      
      public function switchVisible() : void{}
      
      private function onUIModuleComplete() : void{}
      
      public function hide() : void{}
      
      private function show() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
   }
}
