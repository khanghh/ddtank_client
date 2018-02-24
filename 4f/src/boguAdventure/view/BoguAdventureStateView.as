package boguAdventure.view
{
   import boguAdventure.BoguAdventureControl;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.SimpleReturnBar;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class BoguAdventureStateView extends BaseStateView
   {
       
      
      private var _bg:Bitmap;
      
      private var _gameView:BoguAdventureGameView;
      
      private var _control:BoguAdventureControl;
      
      private var _returnBar:SimpleReturnBar;
      
      public function BoguAdventureStateView(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function addedToStage() : void{}
      
      private function initEvent() : void{}
      
      private function __onUpdateView(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      private function returnCell() : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function getType() : String{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function dispose() : void{}
   }
}
