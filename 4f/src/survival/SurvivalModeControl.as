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
      
      public function SurvivalModeControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : SurvivalModeControl{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:Event) : void{}
      
      private function __onUIModuleComplete(param1:UIModuleEvent) : void{}
      
      private function __onProgress(param1:UIModuleEvent) : void{}
      
      private function __onClose(param1:Event) : void{}
      
      private function showSurvivalRoom() : void{}
      
      public function start() : void{}
      
      protected function __onSingleRoomEvent(param1:FrameEvent) : void{}
      
      private function hideSingleRoomView() : void{}
   }
}
