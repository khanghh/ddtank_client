package draft
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.PkgEvent;
   import ddt.manager.DraftManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import draft.data.DraftModel;
   import draft.view.DraftView;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.comm.PackageIn;
   
   public class DraftControl extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:DraftControl;
       
      
      public var TicketNum:int = 0;
      
      private var _draftView:DraftView;
      
      public function DraftControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : DraftControl{return null;}
      
      public function setup() : void{}
      
      protected function __onUploadStyle(param1:PkgEvent) : void{}
      
      protected function __onOpenView(param1:Event) : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      private function __complainShow(param1:UIModuleEvent) : void{}
      
      private function __progressShow(param1:UIModuleEvent) : void{}
      
      protected function __onClose(param1:Event) : void{}
      
      private function showDraftFrame() : void{}
   }
}
