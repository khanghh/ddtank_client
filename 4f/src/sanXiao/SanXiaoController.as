package sanXiao
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreController;
   import ddt.events.CEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.GameInSocketOut;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import sanXiao.game.SanXiaoGameMediator;
   import sanXiao.view.SanXiaoMainView;
   
   public class SanXiaoController extends CoreController
   {
      
      private static var instance:SanXiaoController;
       
      
      private var _manager:SanXiaoManager;
      
      private var _sanxiaoMainView:SanXiaoMainView;
      
      private var _eventsLists:Array;
      
      public function SanXiaoController(param1:inner){super();}
      
      public static function getInstance() : SanXiaoController{return null;}
      
      public function setup() : void{}
      
      override protected function eventsHandler(param1:CEvent) : void{}
      
      private function onShowView(param1:CEvent) : void{}
      
      private function onResLoaded() : void{}
      
      private function onDataLoaded() : void{}
      
      protected function onRFS(param1:Event) : void{}
      
      private function mainViewInited() : void{}
      
      private function mainViewDisposed() : void{}
      
      private function onDropOutItemUpdate(param1:CEvent) : void{}
      
      private function onViewUpdate(param1:CEvent) : void{}
      
      private function onMapStatus(param1:CEvent) : void{}
      
      public function lockFrame() : void{}
      
      public function unLockFrame() : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
