package littleGame
{
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import invite.InviteManager;
   import littleGame.events.LittleGameSocketEvent;
   import littleGame.model.Scenario;
   import littleGame.view.LittleGameOptionView;
   
   public class LittleHall extends BaseStateView
   {
       
      
      private var _game:Scenario;
      
      private var _optionView:LittleGameOptionView;
      
      private var _gameLoader:LittleGameLoader;
      
      public function LittleHall()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         InviteManager.Instance.enabled = false;
         _optionView = new LittleGameOptionView();
         addChild(_optionView);
         ChatManager.Instance.state = 26;
         ChatManager.Instance.view.visible = true;
         ChatManager.Instance.chatDisabled = false;
         addChild(ChatManager.Instance.view);
         addEvent();
         KeyboardShortcutsManager.Instance.forbiddenFull();
         super.enter(prev,data);
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         removeEvent();
         KeyboardShortcutsManager.Instance.cancelForbidden();
         if(_optionView)
         {
            ObjectUtils.disposeObject(_optionView);
         }
         _optionView = null;
         super.leaving(next);
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener("startload",__loadGame);
         SocketManager.Instance.addEventListener("gamestart",__gameStart);
      }
      
      private function __gameStart(event:LittleGameSocketEvent) : void
      {
         LittleGameManager.Instance.enterGame(_game,event.pkg);
         StateManager.setState("littleGame",_game);
         _game = null;
      }
      
      private function __loadGame(event:LittleGameSocketEvent) : void
      {
         _game = LittleGameManager.Instance.createGame(event.pkg);
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.addEventListener("close",__loadClose);
         UIModuleSmallLoading.Instance.show();
         _gameLoader = new LittleGameLoader(_game);
         _gameLoader.addEventListener("complete",__gameComplete);
         _gameLoader.addEventListener("progress",__gameLoaderProgress);
         _gameLoader.startup();
      }
      
      private function __gameLoaderProgress(event:LoaderEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = _gameLoader.progress;
      }
      
      private function __loadClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadClose);
         _gameLoader.shutdown();
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener("startload",__loadGame);
         SocketManager.Instance.removeEventListener("gamestart",__gameStart);
         UIModuleSmallLoading.Instance.removeEventListener("close",__loadClose);
      }
      
      private function __gameComplete(event:LoaderEvent) : void
      {
         var loader:LittleGameLoader = event.currentTarget as LittleGameLoader;
         loader.removeEventListener("complete",__gameComplete);
         loader.removeEventListener("progress",__gameLoaderProgress);
         _game.gameLoader = loader;
         _game.grid = loader.grid;
         _game.grid.calculateLinks(0);
         UIModuleSmallLoading.Instance.hide();
         LittleGameManager.Instance.loadComplete();
      }
      
      override public function getType() : String
      {
         return "littleHall";
      }
   }
}
