package ddQiYuan
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddQiYuan.view.DDQiYuanFrame;
   import ddQiYuan.view.DDQiYuanTowerFrame;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class DDQiYuanController extends EventDispatcher
   {
      
      private static var _instance:DDQiYuanController;
       
      
      private var _frame:DDQiYuanFrame;
      
      private var _towerFrame:DDQiYuanTowerFrame;
      
      public function DDQiYuanController(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : DDQiYuanController
      {
         if(_instance == null)
         {
            _instance = new DDQiYuanController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DDQiYuanManager.instance.addEventListener("event_open_frame",onOpenView);
         DDQiYuanManager.instance.addEventListener("event_query_tower_task_back",onOpenTowerFrameView);
      }
      
      protected function onOpenView(param1:Event) : void
      {
         new HelperUIModuleLoad().loadUIModule(["ddqiyuan","ddtbagandinfo"],loadCompleteHandler);
      }
      
      private function loadCompleteHandler() : void
      {
         disposeFrame();
         _frame = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.DDQiYuanFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function onOpenTowerFrameView(param1:Event) : void
      {
         _towerFrame = ComponentFactory.Instance.creatComponentByStylename("ddQiYuan.DDQiYuanTowerFrame");
         LayerManager.Instance.addToLayer(_towerFrame,3,true,1);
      }
      
      public function disposeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      public function disposeTowerFrame() : void
      {
         if(_towerFrame)
         {
            _towerFrame.dispose();
            _towerFrame = null;
         }
      }
   }
}
