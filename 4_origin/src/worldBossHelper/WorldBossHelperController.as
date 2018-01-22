package worldBossHelper
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import invite.InviteManager;
   import worldBossHelper.data.WorldBossHelperTypeData;
   import worldBossHelper.event.WorldBossHelperEvent;
   import worldBossHelper.view.WorldBossHelperFrame;
   
   public class WorldBossHelperController extends EventDispatcher
   {
      
      private static var _instance:WorldBossHelperController;
       
      
      public var data:WorldBossHelperTypeData;
      
      public var monkeyType:int;
      
      private var _honor:int;
      
      private var _money:int;
      
      private var _medal:int;
      
      private var _frame:WorldBossHelperFrame;
      
      private var _manager:WorldBossHelperManager;
      
      public function WorldBossHelperController()
      {
         super();
         _manager = WorldBossHelperManager.Instance;
      }
      
      public static function get Instance() : WorldBossHelperController
      {
         if(_instance == null)
         {
            _instance = new WorldBossHelperController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(102,39),__assistantHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(102,13),__playerInfoHandler);
         _manager.addEventListener("wldboss_boss_open",__onBossOpen);
         _manager.addEventListener("worldBossHelperOpenView",__onOpenView);
      }
      
      protected function __onOpenView(param1:CEvent) : void
      {
         show();
      }
      
      public function show() : void
      {
         _manager.setup();
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",_loadingCloseHandler);
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",_loaderCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",_loaderProgressHandler);
         UIModuleLoader.Instance.addUIModuleImp("worldBossHelper");
      }
      
      protected function __onBossOpen(param1:WorldBossHelperEvent) : void
      {
         if(_frame)
         {
            _frame.startFight();
         }
      }
      
      protected function __playerInfoHandler(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         _manager.isFighting = param1.pkg.readBoolean();
         var _loc3_:int = param1.pkg.readInt();
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(param1.pkg.readInt());
            _loc4_++;
         }
         _honor = param1.pkg.readInt();
         _manager.allHonor = _manager.allHonor + _honor;
         _money = param1.pkg.readInt();
         _manager.allMoney = _manager.allMoney + _money;
         _medal = param1.pkg.readInt();
         _manager.allMedal = _manager.allMedal + _medal;
         if(_frame)
         {
            _frame.addPlayerInfo(true,_manager.num,_loc2_,_honor);
         }
         _manager.num++;
      }
      
      protected function __assistantHandler(param1:PkgEvent) : void
      {
         data.isOpen = param1.pkg.readBoolean();
         _manager.helperOpen = data.isOpen;
         data.buffNum = param1.pkg.readInt();
         data.type = param1.pkg.readInt();
         data.openType = param1.pkg.readInt();
         if(data.openType == 0)
         {
            data.openType = 1;
         }
         if(_frame)
         {
            _frame.updateView();
            return;
         }
         _frame = ComponentFactory.Instance.creatComponentByStylename("worldBossHelperFrame");
         _frame.titleText = LanguageMgr.GetTranslation("worldbosshelper.title");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      protected function _loadingCloseHandler(param1:Event) : void
      {
         closeLoading();
         UIModuleSmallLoading.Instance.removeEventListener("close",_loadingCloseHandler);
      }
      
      private function closeLoading() : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",_loaderCompleteHandler);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",_loaderProgressHandler);
         UIModuleSmallLoading.Instance.hide();
      }
      
      protected function _loaderCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "worldBossHelper")
         {
            closeLoading();
            data = new WorldBossHelperTypeData();
            data.requestType = 1;
            SocketManager.Instance.out.openOrCloseWorldBossHelper(data);
         }
      }
      
      public function dispose() : void
      {
         data = null;
         if(_frame)
         {
            var _loc1_:* = 0;
            _manager.allMedal = _loc1_;
            _loc1_ = _loc1_;
            _manager.allMoney = _loc1_;
            _manager.allHonor = _loc1_;
            _manager.isHelperInited = false;
            ObjectUtils.disposeObject(_frame);
            _frame = null;
            _manager.isInWorldBossHelperFrame = false;
            SocketManager.Instance.out.quitWorldBossHelperView();
         }
         InviteManager.Instance.enabled = true;
      }
      
      protected function _loaderProgressHandler(param1:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
      }
   }
}
