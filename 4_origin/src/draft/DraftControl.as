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
      
      public function DraftControl(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : DraftControl
      {
         if(!_instance)
         {
            _instance = new DraftControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DraftManager.instance.addEventListener("DraftOpenView",__onOpenView);
         SocketManager.Instance.addEventListener(PkgEvent.format(310),__onUploadStyle);
      }
      
      protected function __onUploadStyle(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var flag:Boolean = pkg.readBoolean();
         if(flag)
         {
            DraftModel.UploadNum++;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("draftView.vote.uploadSuccessText"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("draftView.vote.uploadFailedText"));
         }
      }
      
      protected function __onOpenView(event:Event) : void
      {
         show();
      }
      
      public function show() : void
      {
         if(loadComplete)
         {
            showDraftFrame();
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__complainShow);
            UIModuleLoader.Instance.addUIModuleImp("draft");
         }
      }
      
      public function hide() : void
      {
         if(_draftView != null)
         {
            _draftView.dispose();
         }
         _draftView = null;
         DraftManager.instance.showDraft = false;
      }
      
      private function __complainShow(event:UIModuleEvent) : void
      {
         if(event.module == "draft")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            useFirst = false;
            show();
         }
      }
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "draft")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
      }
      
      private function showDraftFrame() : void
      {
         DraftManager.instance.showDraft = true;
         _draftView = ComponentFactory.Instance.creatComponentByStylename("draftView.mainframe");
         LayerManager.Instance.addToLayer(_draftView,3,true,1);
      }
   }
}
