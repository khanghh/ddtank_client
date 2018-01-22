package newTitle
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import newTitle.event.NewTitleEvent;
   import newTitle.view.NewTitleFrame;
   import newTitle.view.NewTitleListCell;
   
   public class NewTitleControl extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:NewTitleControl;
       
      
      private var _titleFrame:NewTitleFrame;
      
      public function NewTitleControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : NewTitleControl{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:NewTitleEvent) : void{}
      
      public function show() : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function showTitleFrame() : void{}
      
      public function hide() : void{}
   }
}
