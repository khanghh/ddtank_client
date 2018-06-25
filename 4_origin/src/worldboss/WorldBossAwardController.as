package worldboss
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import invite.InviteManager;
   import worldboss.event.WorldBossRoomEvent;
   import worldboss.view.WorldBossAwardView;
   
   public class WorldBossAwardController extends BaseStateView
   {
       
      
      private var _optionView:WorldBossAwardView;
      
      private var _mapLoader:BaseLoader;
      
      public function WorldBossAwardController()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _optionView = new WorldBossAwardView();
         ChatManager.Instance.state = 26;
         ChatManager.Instance.view.visible = true;
         ChatManager.Instance.chatDisabled = false;
         addChild(_optionView);
         addChild(ChatManager.Instance.view);
         KeyboardShortcutsManager.Instance.forbiddenFull();
      }
      
      private function addEvent() : void
      {
         WorldBossManager.Instance.addEventListener("can enter",__gotoWorldBossRoom);
      }
      
      private function __gotoWorldBossRoom(event:WorldBossRoomEvent) : void
      {
         _mapLoader = LoadResourceManager.Instance.createLoader(WorldBossManager.Instance.mapPath,4);
         _mapLoader.addEventListener("complete",onMapSrcLoadedComplete);
         LoadResourceManager.Instance.startLoad(_mapLoader);
      }
      
      private function onMapSrcLoadedComplete(e:Event) : void
      {
         if(StateManager.getState("worldboss") == null)
         {
            UIModuleSmallLoading.Instance.addEventListener("close",__loadingIsCloseRoom);
         }
         StateManager.setState("worldboss");
      }
      
      private function __loadingIsCloseRoom(e:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadingIsCloseRoom);
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "worldbossAward";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         KeyboardShortcutsManager.Instance.cancelForbidden();
         WorldBossManager.Instance.removeEventListener("can enter",__gotoWorldBossRoom);
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_optionView)
         {
            ObjectUtils.disposeObject(_optionView);
         }
         _optionView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
