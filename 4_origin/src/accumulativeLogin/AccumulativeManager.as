package accumulativeLogin
{
   import accumulativeLogin.view.AccumulativeLoginView;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class AccumulativeManager extends EventDispatcher
   {
      
      public static const ACCUMULATIVE_AWARD_REFRESH:String = "accumulativeLoginAwardRefresh";
      
      private static var _instance:AccumulativeManager;
       
      
      public var dataDic:Dictionary;
      
      public function AccumulativeManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : AccumulativeManager
      {
         if(_instance == null)
         {
            _instance = new AccumulativeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(238),__awardHandler);
      }
      
      protected function __awardHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var self:SelfInfo = PlayerManager.Instance.Self;
         self.accumulativeLoginDays = pkg.readInt();
         self.accumulativeAwardDays = pkg.readInt();
         dispatchEvent(new Event("accumulativeLoginAwardRefresh"));
      }
      
      public function addAct() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 10)
         {
            HallIconManager.instance.updateSwitchHandler("accumulativeLogin",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("accumulativeLogin",true,10);
         }
      }
      
      public function removeAct() : void
      {
         HallIconManager.instance.updateSwitchHandler("accumulativeLogin",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("accumulativeLogin",false);
      }
      
      public function loadTempleteDataComplete(analyzer:AccumulativeLoginAnalyer) : void
      {
         dataDic = analyzer.accumulativeloginDataDic;
      }
      
      public function showFrame() : void
      {
         SoundManager.instance.play("008");
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("wonderfulactivity");
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "wonderfulactivity")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         var _view:* = null;
         if(event.module == "wonderfulactivity")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            _view = new AccumulativeLoginView();
            _view.init();
            _view.x = -227;
            HallIconManager.instance.showCommonFrame(_view,"wonderfulActivityManager.btnTxt15");
         }
      }
   }
}
