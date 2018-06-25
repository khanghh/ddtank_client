package demonChiYou.view
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.BackgoundView;
   import ddt.view.MainToolBar;
   import ddt.view.chat.ChatView;
   import flash.events.Event;
   import gameCommon.GameControl;
   import hall.GameLoadingManager;
   import invite.InviteManager;
   
   public class DemonChiYouSence extends BaseStateView
   {
       
      
      private var _worldBossHPScript:WorldBossHPScript;
      
      private var _roomMenuView:RoomMenuView;
      
      private var _worldBossRoomTotalInfoView:WorldBossRoomTotalInfoView;
      
      private var _sceneHelpBtn:BaseButton;
      
      public function DemonChiYouSence()
      {
         super();
      }
      
      override public function getType() : String
      {
         return "demon_chi_you";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
         initView();
         BackgoundView.Instance.hide();
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("demon_chi_you");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         GameLoadingManager.Instance.hide();
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         MainToolBar.Instance.hide();
         ChatManager.Instance.state = 35;
         ChatManager.Instance.lock = true;
         ChatManager.Instance.chatDisabled = false;
         var chatView:ChatView = ChatManager.Instance.view;
         chatView.visible = true;
         addChild(chatView);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
      }
      
      private function initView() : void
      {
         _worldBossHPScript = new WorldBossHPScript();
         _worldBossHPScript.x = 312;
         _worldBossHPScript.y = 65;
         _worldBossHPScript.mouseChildren = false;
         _worldBossHPScript.mouseEnabled = false;
         addChild(_worldBossHPScript);
         _roomMenuView = new RoomMenuView();
         _roomMenuView.setRightDown();
         addChild(_roomMenuView);
         _worldBossRoomTotalInfoView = new WorldBossRoomTotalInfoView();
         _worldBossRoomTotalInfoView.setRightDown();
         addChild(_worldBossRoomTotalInfoView);
         _sceneHelpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonLong",{
            "x":17,
            "y":145
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"Demonchiyou.help",438,550);
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         super.leaving(next);
         BackgoundView.Instance.show();
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("demon_chi_you");
         CacheSysManager.getInstance().release("demon_chi_you");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         ObjectUtils.disposeAllChildren(this);
         _worldBossHPScript = null;
         _roomMenuView = null;
         _worldBossRoomTotalInfoView = null;
         _sceneHelpBtn = null;
      }
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
   }
}
