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
      
      public function WitchBlessingManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      public function templateDataSetup(param1:Array) : void
      {
         _model.itemInfoList = param1;
      }
      
      private function __witchBlessingHandle(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         switch(int(_loc2_) - 112)
         {
            case 0:
               isOpenIcon(_loc3_);
               break;
            case 1:
               enterView(_loc3_);
            default:
               enterView(_loc3_);
         }
      }
      
      private function enterView(param1:PackageIn) : void
      {
         _model.isDouble = param1.readBoolean();
         _model.totalExp = param1.readInt();
         _model.lv1GetAwardsTimes = param1.readInt();
         _model.lv1CD = param1.readInt();
         _model.lv2GetAwardsTimes = param1.readInt();
         _model.lv2CD = param1.readInt();
         _model.lv3GetAwardsTimes = param1.readInt();
         _model.lv3CD = param1.readInt();
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
      
      public function isOpenIcon(param1:PackageIn) : void
      {
         _model.isOpen = param1.readBoolean();
         _model.startDate = param1.readDate();
         _model.endDate = param1.readDate();
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
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
      }
      
      private function __progressShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "witchblessing")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __completeShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "witchblessing")
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
