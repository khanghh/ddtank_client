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
      
      public function DDPlayManaer(param1:DDPlayInstance, param2:IEventDispatcher = null)
      {
         super(param2);
      }
      
      public static function get Instance() : DDPlayManaer
      {
         var _loc1_:* = null;
         if(_instance == null)
         {
            _loc1_ = new DDPlayInstance();
            _instance = new DDPlayManaer(_loc1_);
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
      
      protected function __addDDPlayBtn(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 74)
         {
            case 0:
               openOrClose(_loc4_);
               break;
            case 1:
               _loc3_ = new CrazyTankSocketEvent("DDPlay_enter",_loc4_);
               break;
            case 2:
               _loc3_ = new CrazyTankSocketEvent("DDPlay_start",_loc4_);
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      private function openOrClose(param1:PackageIn) : void
      {
         isOpen = param1.readBoolean();
         beginDate = param1.readDate();
         endDate = param1.readDate();
         DDPlayMoney = param1.readInt();
         exchangeFold = param1.readInt();
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
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
      }
      
      private function __progressShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddplay")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __complainShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddplay")
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
