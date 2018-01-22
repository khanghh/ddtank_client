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
      
      public function AccumulativeManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      protected function __awardHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:SelfInfo = PlayerManager.Instance.Self;
         _loc3_.accumulativeLoginDays = _loc2_.readInt();
         _loc3_.accumulativeAwardDays = _loc2_.readInt();
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
      
      public function loadTempleteDataComplete(param1:AccumulativeLoginAnalyer) : void
      {
         dataDic = param1.accumulativeloginDataDic;
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
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "wonderfulactivity")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         var _loc2_:* = null;
         if(param1.module == "wonderfulactivity")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            _loc2_ = new AccumulativeLoginView();
            _loc2_.init();
            _loc2_.x = -227;
            HallIconManager.instance.showCommonFrame(_loc2_,"wonderfulActivityManager.btnTxt15");
         }
      }
   }
}
