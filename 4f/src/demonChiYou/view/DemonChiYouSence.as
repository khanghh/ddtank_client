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
      
      public function DemonChiYouSence(){super();}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function initView() : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      private function __startLoading(param1:Event) : void{}
   }
}
