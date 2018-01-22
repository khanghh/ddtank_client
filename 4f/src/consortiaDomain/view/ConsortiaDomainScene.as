package consortiaDomain.view
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.BackgoundView;
   import ddt.view.MainToolBar;
   import ddt.view.SimpleReturnBar;
   import ddt.view.chat.ChatView;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import hall.GameLoadingManager;
   import invite.InviteManager;
   import starling.core.Starling;
   
   public class ConsortiaDomainScene extends BaseStateView
   {
       
      
      private var _nextWaveMonsterView:NextWaveMonsterView;
      
      private var _killRankView:KillRankView;
      
      private var _buildStateView:BuildsStateView;
      
      private var _showOrHideFightMonsterBtn:SimpleBitmapButton;
      
      private var _blackGound:Shape;
      
      private var _returnBtn:SimpleReturnBar;
      
      public function ConsortiaDomainScene(){super();}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function initView() : void{}
      
      private function checkShowOrHideFightMonsterBtn() : void{}
      
      private function setShowOrHideFightMonsterBtnBackStyle() : void{}
      
      private function onClickShowOrHideFightMonsterBtn(param1:MouseEvent) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      private function onActiveStateChange(param1:Event) : void{}
      
      private function onTweenBlackGoundComplete() : void{}
      
      private function checkShowNextWaveMonsterView() : void{}
      
      private function __startLoading(param1:Event) : void{}
   }
}
