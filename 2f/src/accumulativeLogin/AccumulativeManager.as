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
      
      public function AccumulativeManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : AccumulativeManager{return null;}
      
      public function setup() : void{}
      
      protected function __awardHandler(param1:CrazyTankSocketEvent) : void{}
      
      public function addAct() : void{}
      
      public function removeAct() : void{}
      
      public function loadTempleteDataComplete(param1:AccumulativeLoginAnalyer) : void{}
      
      public function showFrame() : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
   }
}
