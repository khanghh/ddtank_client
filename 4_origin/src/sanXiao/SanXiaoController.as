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
      
      public function SanXiaoController(single:inner)
      {
         _eventsLists = [["sanxiao_map_status",onMapStatus],["sanxiao_update_data",onViewUpdate],["sanxiao_drop_out_item_gained",onDropOutItemUpdate]];
         super();
      }
      
      public static function getInstance() : SanXiaoController
      {
         if(!instance)
         {
            instance = new SanXiaoController(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         _manager = SanXiaoManager.getInstance();
         addEvents(["sanxiao_show_view"],_manager);
      }
      
      override protected function eventsHandler(e:CEvent) : void
      {
         var _loc2_:* = e.type;
         if("sanxiao_show_view" === _loc2_)
         {
            onShowView(e);
         }
      }
      
      private function onShowView(e:CEvent) : void
      {
         if(_sanxiaoMainView)
         {
            _sanxiaoMainView = null;
         }
         new HelperUIModuleLoad().loadUIModule(["sanxiao"],onResLoaded);
      }
      
      private function onResLoaded() : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createSanXiaoScoreRewardDataLoader,LoaderCreate.Instance.createSanXiaoStoreDataLoader],onDataLoaded);
      }
      
      private function onDataLoaded() : void
      {
         _sanxiaoMainView = ComponentFactory.Instance.creatComponentByStylename("sanxiao.frame");
         LayerManager.Instance.addToLayer(_sanxiaoMainView,3,true,1);
         mainViewInited();
         GameInSocketOut.sendSXRequireMapInfo();
         GameInSocketOut.sendSXRequireViewData();
      }
      
      protected function onRFS(e:Event) : void
      {
         mainViewDisposed();
      }
      
      private function mainViewInited() : void
      {
         !_sanxiaoMainView.hasEventListener("removedFromStage") && _sanxiaoMainView.addEventListener("removedFromStage",onRFS);
         _manager = SanXiaoManager.getInstance();
         addEventsMap(_eventsLists,_manager);
      }
      
      private function mainViewDisposed() : void
      {
         _sanxiaoMainView.hasEventListener("removedFromStage") && _sanxiaoMainView.removeEventListener("removedFromStage",onRFS);
         removeEventsMap(_eventsLists,_manager);
         _sanxiaoMainView = null;
      }
      
      private function onDropOutItemUpdate(e:CEvent) : void
      {
      }
      
      private function onViewUpdate(e:CEvent) : void
      {
      }
      
      private function onMapStatus(e:CEvent) : void
      {
         SanXiaoGameMediator.getInstance().startGame();
      }
      
      public function lockFrame() : void
      {
         if(_sanxiaoMainView != null && _sanxiaoMainView.parent != null)
         {
            _sanxiaoMainView.closeButton.enable = false;
            _sanxiaoMainView.closeButton.mouseEnabled = false;
            _sanxiaoMainView.autoExit = false;
            _sanxiaoMainView.lockProps();
         }
      }
      
      public function unLockFrame() : void
      {
         if(_sanxiaoMainView != null && _sanxiaoMainView.parent != null)
         {
            _sanxiaoMainView.closeButton.enable = true;
            _sanxiaoMainView.closeButton.mouseEnabled = true;
            _sanxiaoMainView.autoExit = true;
            _sanxiaoMainView.unLockProps();
         }
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
