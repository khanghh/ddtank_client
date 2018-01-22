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
      
      public function DDQiYuanController(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : DDQiYuanController{return null;}
      
      public function setup() : void{}
      
      protected function onOpenView(param1:Event) : void{}
      
      private function loadCompleteHandler() : void{}
      
      private function onOpenTowerFrameView(param1:Event) : void{}
      
      public function disposeFrame() : void{}
      
      public function disposeTowerFrame() : void{}
   }
}
