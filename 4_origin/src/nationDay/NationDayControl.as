package nationDay
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import nationDay.model.NationModel;
   import nationDay.view.NationalDayView;
   import road7th.comm.PackageIn;
   
   public class NationDayControl extends EventDispatcher
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      private static var _instance:NationDayControl;
       
      
      private var _nationView:NationalDayView;
      
      public function NationDayControl(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : NationDayControl
      {
         if(!_instance)
         {
            _instance = new NationDayControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(NationDayManager.instance.curActivity != "lt_nation_day")
         {
            return;
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(288,2),__onGetNationInfo);
         NationDayManager.instance.addEventListener("nationOpenView",__onOpenView);
      }
      
      protected function __onOpenView(param1:Event) : void
      {
         sendPkg();
      }
      
      public function sendPkg() : void
      {
         SocketManager.Instance.out.getNationDayInfo();
      }
      
      protected function __onGetNationInfo(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         NationDayManager.instance.nationModel = new NationModel();
         NationDayManager.instance.nationModel.StartDate = ServerConfigManager.instance.nationalDayDropBeginDate;
         NationDayManager.instance.nationModel.EndDate = ServerConfigManager.instance.nationalDayDropEndDate;
         NationDayManager.instance.nationModel.Description = LanguageMgr.GetTranslation("nationDay.Description");
         var _loc2_:int = _loc3_.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = _loc3_.readInt();
            NationDayManager.instance.nationModel.WordArray[_loc4_] = _loc3_.readInt();
            _loc5_++;
         }
         NationDayManager.instance.nationModel.maxTimes = ServerConfigManager.instance.nationDayGetMaxTimes;
         NationDayManager.instance.nationModel.getTimes[0] = _loc3_.readInt();
         NationDayManager.instance.nationModel.getTimes[1] = _loc3_.readInt();
         NationDayManager.instance.nationModel.getTimes[2] = _loc3_.readInt();
         NationDayManager.instance.nationModel.getTimes[3] = _loc3_.readInt();
         show();
         if(NationDayManager.instance.nationDayIcon)
         {
            NationDayManager.instance.setIconFrame();
         }
      }
      
      public function show() : void
      {
         if(loadComplete)
         {
            showNationDayFrame();
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__complainShow);
            UIModuleLoader.Instance.addUIModuleImp("nationDay");
         }
      }
      
      private function __complainShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "nationDay")
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
      
      private function __progressShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "nationDay")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
      }
      
      private function showNationDayFrame() : void
      {
         if(_nationView)
         {
            _nationView.setViewInfo();
         }
         else
         {
            _nationView = new NationalDayView();
            _nationView.show();
            _nationView.setViewInfo();
         }
      }
      
      public function hide() : void
      {
         ObjectUtils.disposeObject(_nationView);
         _nationView = null;
      }
   }
}
