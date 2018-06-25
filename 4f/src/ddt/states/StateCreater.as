package ddt.states{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.QueueLoader;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.utils.StringUtils;   import ddt.loader.LoaderCreate;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.AssetModuleLoader;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import flash.utils.Dictionary;   import flash.utils.getDefinitionByName;   import hall.HallStateView;   import login.LoginStateView;   import room.RoomManager;   import shop.ShopController;   import superWinner.controller.SuperWinnerController;   import worldboss.WorldBossManager;   import worldboss.event.WorldBossRoomEvent;      public class StateCreater   {                   private var _state:Dictionary;            private var _currentStateType:String;            private var _loadCall:Function;            public function StateCreater() { super(); }
            public static function getNeededUIModuleByType(type:String) : String { return null; }
            public function create(type:String, id:int = 0) : BaseStateView { return null; }
            public function createAsync(type:String, callback:Function) : void { }
            private function __onAudioLoadComplete(e:Event) : void { }
            private function loadComplete() : void { }
            private function __onCloseLoading(event:Event) : void { }
            private function getStateLoadingInfo(type:String, needUIModule:String = null, callBack:Function = null) : StateLoadingInfo { return null; }
            private function __onUimoduleLoadComplete(event:UIModuleEvent) : void { }
            private function __onUimoduleLoadError(event:UIModuleEvent) : void { }
            private function __onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function isLoaderDDTCORE(type:String) : Boolean { return false; }
   }}