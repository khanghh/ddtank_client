package DDPlay
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class DDPlayManaer extends EventDispatcher
   {
      
      public static const UPDATE_SCORE:String = "update_score";
      
      private static var loadComplete:Boolean = false;
      
      private static var useFirst:Boolean = true;
      
      private static var _instance:DDPlayManaer;
       
      
      public var isOpen:Boolean;
      
      public var DDPlayScore:int;
      
      public var DDPlayMoney:int;
      
      public var exchangeFold:int;
      
      public var beginDate:Date;
      
      public var endDate:Date;
      
      private var _ddPlayView:DDPlayView;
      
      public function DDPlayManaer(ddplay:DDPlayInstance, target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get Instance() : DDPlayManaer
      {
         var ddplayinstance:* = null;
         if(_instance == null)
         {
            ddplayinstance = new DDPlayInstance();
            _instance = new DDPlayManaer(ddplayinstance);
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("DDPlay_brgin",__addDDPlayBtn);
      }
      
      protected function __addDDPlayBtn(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = event._cmd;
         var events:CrazyTankSocketEvent = null;
         switch(int(cmd) - 74)
         {
            case 0:
               openOrClose(pkg);
               break;
            case 1:
               events = new CrazyTankSocketEvent("DDPlay_enter",pkg);
               break;
            case 2:
               events = new CrazyTankSocketEvent("DDPlay_start",pkg);
         }
         if(events)
         {
            dispatchEvent(events);
         }
      }
      
      private function openOrClose(pkg:PackageIn) : void
      {
         isOpen = pkg.readBoolean();
         beginDate = pkg.readDate();
         endDate = pkg.readDate();
         DDPlayMoney = pkg.readInt();
         exchangeFold = pkg.readInt();
         if(isOpen)
         {
            createDDPlayBtn();
         }
         else
         {
            deleteDDPlayBtn();
         }
      }
      
      public function createDDPlayBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("DDPlay",true);
      }
      
      public function deleteDDPlayBtn() : void
      {
         HallIconManager.instance.updateSwitchHandler("DDPlay",false);
      }
      
      public function show() : void
      {
         if(loadComplete)
         {
            showDDPlayView();
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__complainShow);
            UIModuleLoader.Instance.addUIModuleImp("ddplay");
         }
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
      }
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "ddplay")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __complainShow(event:UIModuleEvent) : void
      {
         if(event.module == "ddplay")
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
      
      private function showDDPlayView() : void
      {
         _ddPlayView = ComponentFactory.Instance.creatComponentByStylename("ddPlay.view.ddPlayView");
         _ddPlayView.show();
      }
   }
}

class DDPlayInstance
{
    
   
   function DDPlayInstance()
   {
      super();
   }
}
