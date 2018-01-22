package toyMachine
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import toyMachine.view.ToyMachineFrame;
   
   public class ToyMachineManager extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:ToyMachineManager;
       
      
      private var _toyMachineFrame:ToyMachineFrame;
      
      public function ToyMachineManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : ToyMachineManager{return null;}
      
      public function show() : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function showToyFrame() : void{}
      
      public function hide() : void{}
   }
}
