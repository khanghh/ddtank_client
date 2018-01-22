package godsRoads
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import godsRoads.manager.GodsRoadsManager;
   import godsRoads.view.GodsRoadsView;
   
   public class GodRoadsController extends EventDispatcher
   {
      
      private static var _instance:GodRoadsController;
       
      
      public var _view:GodsRoadsView;
      
      public var lastStep:int = 0;
      
      public var lastMssion:int = 0;
      
      public function GodRoadsController(param1:PrivateClass)
      {
         super();
      }
      
      public static function get instance() : GodRoadsController
      {
         if(GodRoadsController._instance == null)
         {
            GodRoadsController._instance = new GodRoadsController(new PrivateClass());
         }
         return GodRoadsController._instance;
      }
      
      public function setup() : void
      {
         GodsRoadsManager.instance.addEventListener("godsroadsopenframe",__onGodsRoadsOpenFrame);
         GodsRoadsManager.instance.addEventListener("godsroadschangesteps",__onGodsRoadsChangeSteps);
      }
      
      private function __onGodsRoadsChangeSteps(param1:Event) : void
      {
         _view.changeSteps(GodsRoadsManager.instance.level);
      }
      
      private function __onGodsRoadsOpenFrame(param1:Event) : void
      {
         if(_view == null)
         {
            _view = ComponentFactory.Instance.creat("godsRoads.GodsRoadsView");
            _view.initView();
            _view.titleText = LanguageMgr.GetTranslation("ddt.godsRoads.title");
            _view.addEventListener("removedFromStage",disposeView);
            LayerManager.Instance.addToLayer(_view,3,true,1);
         }
         _view.updateView(GodsRoadsManager.instance._model,lastStep,lastMssion);
      }
      
      private function disposeView(param1:Event) : void
      {
         _view.removeEventListener("removedFromStage",disposeView);
         _view = null;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
