package lanternriddles
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import lanternriddles.event.LanternEvent;
   import lanternriddles.view.LanternRiddlesView;
   
   public class LanternRiddlesControl extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:LanternRiddlesControl;
       
      
      private var _lanternView:LanternRiddlesView;
      
      public function LanternRiddlesControl(){super();}
      
      public static function get instance() : LanternRiddlesControl{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:LanternEvent) : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      private function dispose() : void{}
      
      private function removeEvent() : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function showLanternFrame() : void{}
   }
}
