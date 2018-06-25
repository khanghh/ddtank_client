package survival
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.manager.SurvivalModeManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import room.view.roomView.SingleRoomView;
   
   public class SurvivalModeControl extends EventDispatcher
   {
      
      private static var _instance:SurvivalModeControl;
       
      
      private var _moduleComplete:Boolean;
      
      private var _singleRoomView:SingleRoomView;
      
      public function SurvivalModeControl(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get Instance() : SurvivalModeControl
      {
         if(!_instance)
         {
            _instance = new SurvivalModeControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SurvivalModeManager.Instance.addEventListener(SurvivalModeManager.SURVIVAL_OPENVIEW,__onOpenView);
      }
      
      protected function __onOpenView(event:Event) : void
      {
         if(_moduleComplete)
         {
            showSurvivalRoom();
         }
         else
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onProgress);
            UIModuleLoader.Instance.addUIModuleImp("ddtroom");
         }
      }
      
      private function __onUIModuleComplete(evt:UIModuleEvent) : void
      {
         if(evt.module == "ddtroom")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            _moduleComplete = true;
            UIModuleSmallLoading.Instance.hide();
            showSurvivalRoom();
         }
      }
      
      private function __onProgress(event:UIModuleEvent) : void
      {
         if(event.module == "ddtroom")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __onClose(event:Event) : void
      {
         _moduleComplete = false;
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIModuleComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onProgress);
      }
      
      private function showSurvivalRoom() : void
      {
         _singleRoomView = ComponentFactory.Instance.creat("room.view.roomView.singleRoomView",[21]);
         LayerManager.Instance.addToLayer(_singleRoomView,3,true,2);
         _singleRoomView.addEventListener("response",__onSingleRoomEvent);
      }
      
      public function start() : void
      {
         if(_singleRoomView != null)
         {
            _singleRoomView.startTime();
         }
      }
      
      protected function __onSingleRoomEvent(event:FrameEvent) : void
      {
         if(event.responseCode == 1 || event.responseCode == 4 || event.responseCode == 0)
         {
            SoundManager.instance.playButtonSound();
            _singleRoomView.isCloseOrEscClick = true;
            hideSingleRoomView();
         }
      }
      
      private function hideSingleRoomView() : void
      {
         _singleRoomView.removeEventListener("response",__onSingleRoomEvent);
         ObjectUtils.disposeObject(_singleRoomView);
         _singleRoomView = null;
      }
   }
}
