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
      
      public function GotoPageController()
      {
         super();
      }
      
      public static function get Instance() : GotoPageController
      {
         if(_instance == null)
         {
            _instance = new GotoPageController();
         }
         return _instance;
      }
      
      public function switchVisible() : void
      {
         AssetModuleLoader.addModelLoader("gotopage",6);
         AssetModuleLoader.startCodeLoader(onUIModuleComplete);
      }
      
      private function onUIModuleComplete() : void
      {
         if(isShow)
         {
            hide();
         }
         else
         {
            show();
         }
      }
      
      public function hide() : void
      {
         isShow = false;
         if(_gotoPageView)
         {
            _gotoPageView.removeEventListener("response",__responseHandler);
            _gotoPageView.dispose();
         }
         _gotoPageView = null;
      }
      
      private function show() : void
      {
         isShow = true;
         if(_gotoPageView == null)
         {
            _gotoPageView = ComponentFactory.Instance.creatComponentByStylename("gotopage.mainFrame");
            _gotoPageView.addEventListener("response",__responseHandler);
         }
         LayerManager.Instance.addToLayer(_gotoPageView,3,false,2);
         StageReferance.stage.focus = _gotoPageView;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               hide();
            default:
               hide();
            default:
            case 4:
               hide();
         }
      }
   }
}
