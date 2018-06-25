package worldboss{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.KeyboardShortcutsManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import invite.InviteManager;   import worldboss.event.WorldBossRoomEvent;   import worldboss.view.WorldBossAwardView;      public class WorldBossAwardController extends BaseStateView   {                   private var _optionView:WorldBossAwardView;            private var _mapLoader:BaseLoader;            public function WorldBossAwardController() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function init() : void { }
            private function addEvent() : void { }
            private function __gotoWorldBossRoom(event:WorldBossRoomEvent) : void { }
            private function onMapSrcLoadedComplete(e:Event) : void { }
            private function __loadingIsCloseRoom(e:Event) : void { }
            override public function getBackType() : String { return null; }
            override public function getType() : String { return null; }
            override public function leaving(next:BaseStateView) : void { }
            override public function dispose() : void { }
   }}