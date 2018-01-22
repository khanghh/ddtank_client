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
      
      public function BoguAdventureStateView()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         CacheSysManager.lock("AlaertInBoguAdventure");
         super.enter(param1,param2);
      }
      
      override public function addedToStage() : void
      {
         _bg = UICreatShortcut.creatAndAdd("boguAdventure.stateView.Bg",this);
         _control = new BoguAdventureControl();
         _gameView = new BoguAdventureGameView(_control);
         addChild(_gameView);
         _returnBar = UICreatShortcut.creatAndAdd("asset.simpleReturnBar.Button",this);
         _returnBar.returnCall = returnCell;
         initEvent();
         SocketManager.Instance.out.sendBoguAdventureEnter();
         KeyboardShortcutsManager.Instance.forbiddenFull();
      }
      
      private function initEvent() : void
      {
         addEventListener("enterFrame",__onUpdateView);
      }
      
      private function __onUpdateView(param1:Event) : void
      {
         _gameView.updateView();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__onUpdateView);
      }
      
      private function returnCell() : void
      {
         if(_control.isMove)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.notReturn"));
            return;
         }
         StateManager.setState("main");
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "boguadventure";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         dispose();
         super.leaving(param1);
      }
      
      override public function dispose() : void
      {
         CacheSysManager.unlock("AlaertInBoguAdventure");
         CacheSysManager.getInstance().release("AlaertInBoguAdventure");
         SocketManager.Instance.out.sendOutBoguAdventure();
         removeEvent();
         KeyboardShortcutsManager.Instance.cancelForbidden();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_returnBar);
         _returnBar = null;
         _gameView.dispose();
         _gameView = null;
         _control.dispose();
         _control = null;
         super.dispose();
      }
   }
}
