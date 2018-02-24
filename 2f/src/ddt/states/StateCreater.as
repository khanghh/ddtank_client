package ddt.states
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.utils.StringUtils;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import hall.HallStateView;
   import login.LoginStateView;
   import room.RoomManager;
   import shop.ShopController;
   import superWinner.controller.SuperWinnerController;
   import worldboss.WorldBossManager;
   import worldboss.event.WorldBossRoomEvent;
   
   public class StateCreater
   {
       
      
      private var _state:Dictionary;
      
      private var _currentStateType:String;
      
      private var _loadCall:Function;
      
      public function StateCreater(){super();}
      
      public static function getNeededUIModuleByType(param1:String) : String{return null;}
      
      public function create(param1:String, param2:int = 0) : BaseStateView{return null;}
      
      public function createAsync(param1:String, param2:Function) : void{}
      
      private function __onAudioLoadComplete(param1:Event) : void{}
      
      private function loadComplete() : void{}
      
      private function __onCloseLoading(param1:Event) : void{}
      
      private function getStateLoadingInfo(param1:String, param2:String = null, param3:Function = null) : StateLoadingInfo{return null;}
      
      private function __onUimoduleLoadComplete(param1:UIModuleEvent) : void{}
      
      private function __onUimoduleLoadError(param1:UIModuleEvent) : void{}
      
      private function __onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function isLoaderDDTCORE(param1:String) : Boolean{return false;}
   }
}
