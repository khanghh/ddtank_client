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
      
      protected function __onOpenView(event:CEvent) : void
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
      
      protected function __onBossOpen(event:WorldBossHelperEvent) : void
      {
         if(_frame)
         {
            _frame.startFight();
         }
      }
      
      protected function __playerInfoHandler(event:PkgEvent) : void
      {
         var i:int = 0;
         _manager.isFighting = event.pkg.readBoolean();
         var count:int = event.pkg.readInt();
         var hurtArr:Array = [];
         for(i = 0; i < count; )
         {
            hurtArr.push(event.pkg.readInt());
            i++;
         }
         _honor = event.pkg.readInt();
         _manager.allHonor = _manager.allHonor + _honor;
         _money = event.pkg.readInt();
         _manager.allMoney = _manager.allMoney + _money;
         _medal = event.pkg.readInt();
         _manager.allMedal = _manager.allMedal + _medal;
         if(_frame)
         {
            _frame.addPlayerInfo(true,_manager.num,hurtArr,_honor);
         }
         _manager.num++;
      }
      
      protected function __assistantHandler(event:PkgEvent) : void
      {
         data.isOpen = event.pkg.readBoolean();
         _manager.helperOpen = data.isOpen;
         data.buffNum = event.pkg.readInt();
         data.type = event.pkg.readInt();
         data.openType = event.pkg.readInt();
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
      
      protected function _loadingCloseHandler(event:Event) : void
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
      
      protected function _loaderCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "worldBossHelper")
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
      
      protected function _loaderProgressHandler(event:UIModuleEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
      }
   }
}
