package witchBlessing
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import witchBlessing.data.WitchBlessingModel;
   
   public class WitchBlessingManager extends EventDispatcher
   {
      
      private static var _instance:WitchBlessingManager;
      
      public static const WITCHBLESSING_SHOWFRAME:String = "witchblessingshowframe";
      
      public static const WITCHBLESSING_HIDE:String = "witchblessinghide";
      
      public static var loadComplete:Boolean = false;
       
      
      private var _model:WitchBlessingModel;
      
      public function WitchBlessingManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get Instance() : WitchBlessingManager
      {
         if(_instance == null)
         {
            _instance = new WitchBlessingManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new WitchBlessingModel();
         SocketManager.Instance.addEventListener("witchblessing_data",__witchBlessingHandle);
      }
      
      public function get model() : WitchBlessingModel
      {
         return _model;
      }
      
      public function isOpen() : Boolean
      {
         return _model.isOpen;
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         _model.itemInfoList = dataList;
      }
      
      private function __witchBlessingHandle(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         switch(int(cmd) - 112)
         {
            case 0:
               isOpenIcon(pkg);
               break;
            case 1:
               enterView(pkg);
            default:
               enterView(pkg);
         }
      }
      
      private function enterView(pkg:PackageIn) : void
      {
         _model.isDouble = pkg.readBoolean();
         _model.totalExp = pkg.readInt();
         _model.lv1GetAwardsTimes = pkg.readInt();
         _model.lv1CD = pkg.readInt();
         _model.lv2GetAwardsTimes = pkg.readInt();
         _model.lv2CD = pkg.readInt();
         _model.lv3GetAwardsTimes = pkg.readInt();
         _model.lv3CD = pkg.readInt();
         if(loadComplete)
         {
            showMainView();
         }
         else
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__completeShow);
            UIModuleLoader.Instance.addUIModuleImp("witchblessing");
         }
      }
      
      public function testEnter() : void
      {
         if(loadComplete)
         {
            showMainView();
         }
         else
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__completeShow);
            UIModuleLoader.Instance.addUIModuleImp("witchblessing");
         }
      }
      
      public function isOpenIcon(pkg:PackageIn) : void
      {
         _model.isOpen = pkg.readBoolean();
         _model.startDate = pkg.readDate();
         _model.endDate = pkg.readDate();
         HallIconManager.instance.updateSwitchHandler("witchblessing",_model.isOpen);
      }
      
      public function onClickIcon() : void
      {
         SocketManager.Instance.out.witchBlessing_enter();
      }
      
      private function showMainView() : void
      {
         dispatchEvent(new Event("witchblessingshowframe"));
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
      }
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "witchblessing")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __completeShow(event:UIModuleEvent) : void
      {
         if(event.module == "witchblessing")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            showMainView();
         }
      }
      
      public function hide() : void
      {
         dispatchEvent(new Event("witchblessinghide"));
      }
   }
}
