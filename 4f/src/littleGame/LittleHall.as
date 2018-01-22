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
      
      public function LittleHall(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      private function addEvent() : void{}
      
      private function __gameStart(param1:LittleGameSocketEvent) : void{}
      
      private function __loadGame(param1:LittleGameSocketEvent) : void{}
      
      private function __gameLoaderProgress(param1:LoaderEvent) : void{}
      
      private function __loadClose(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      private function __gameComplete(param1:LoaderEvent) : void{}
      
      override public function getType() : String{return null;}
   }
}
