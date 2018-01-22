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
      
      public function ConsortiaDomainScene()
      {
         super();
      }
      
      override public function getType() : String
      {
         return "consortia_domain";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         initView();
         BackgoundView.Instance.hide();
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("consortia_domain");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         GameLoadingManager.Instance.hide();
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         MainToolBar.Instance.hide();
         ChatManager.Instance.state = 35;
         ChatManager.Instance.lock = true;
         ChatManager.Instance.chatDisabled = false;
         ChatManager.Instance.input.faceEnabled = false;
         ChatManager.Instance.input.savePreChannel();
         ChatManager.Instance.inputChannel = 3;
         var _loc3_:ChatView = ChatManager.Instance.view;
         _loc3_.visible = true;
         addChild(_loc3_);
         _returnBtn = ComponentFactory.Instance.creatCustomObject("asset.simpleReturnBar.Button");
         _returnBtn.returnCall = ConsortiaDomainManager.instance.leaveScene;
         addChild(_returnBtn);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         ConsortiaDomainManager.instance.addEventListener("event_active_state_change",onActiveStateChange);
      }
      
      private function initView() : void
      {
         var _loc1_:int = ConsortiaDomainManager.instance.activeState;
         _killRankView = new KillRankView();
         _killRankView.setOpen(_loc1_ == 1);
         _buildStateView = new BuildsStateView();
         _buildStateView.x = 2;
         _buildStateView.y = 2;
         addChild(_buildStateView);
         checkShowOrHideFightMonsterBtn();
         checkShowNextWaveMonsterView();
      }
      
      private function checkShowOrHideFightMonsterBtn() : void
      {
         var _loc1_:int = ConsortiaDomainManager.instance.activeState;
         if(_loc1_ == 100)
         {
            ObjectUtils.disposeObject(_showOrHideFightMonsterBtn);
            _showOrHideFightMonsterBtn = null;
         }
         else if(_loc1_ == 1)
         {
            if(!_showOrHideFightMonsterBtn)
            {
               _showOrHideFightMonsterBtn = UICreatShortcut.creatAndAdd("consortiadomain.showOrHideMonsterBtn",this);
               _showOrHideFightMonsterBtn.x = StageReferance.stageWidth - _showOrHideFightMonsterBtn.width - 4;
               _showOrHideFightMonsterBtn.y = 28;
               _showOrHideFightMonsterBtn.addEventListener("click",onClickShowOrHideFightMonsterBtn);
               setShowOrHideFightMonsterBtnBackStyle();
            }
         }
      }
      
      private function setShowOrHideFightMonsterBtnBackStyle() : void
      {
         if(ConsortiaDomainManager.instance.isShowFightMonster)
         {
            _showOrHideFightMonsterBtn.backStyle = "consortiadomain.showOrHideMonster1";
            _showOrHideFightMonsterBtn.tipData = LanguageMgr.GetTranslation("consortiadomain.showOrHideMonsterBtn.showTip");
         }
         else
         {
            _showOrHideFightMonsterBtn.backStyle = "consortiadomain.showOrHideMonster.hideBg";
            _showOrHideFightMonsterBtn.tipData = LanguageMgr.GetTranslation("consortiadomain.showOrHideMonsterBtn.hideTip");
         }
      }
      
      private function onClickShowOrHideFightMonsterBtn(param1:MouseEvent) : void
      {
         ConsortiaDomainManager.instance.isShowFightMonster = !ConsortiaDomainManager.instance.isShowFightMonster;
         setShowOrHideFightMonsterBtnBackStyle();
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         super.leaving(param1);
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         BackgoundView.Instance.show();
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("consortia_domain");
         CacheSysManager.getInstance().release("consortia_domain");
         ChatManager.Instance.inputChannel = 5;
         KeyboardShortcutsManager.Instance.cancelForbidden();
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         ConsortiaDomainManager.instance.removeEventListener("event_active_state_change",onActiveStateChange);
         _showOrHideFightMonsterBtn && _showOrHideFightMonsterBtn.removeEventListener("click",onClickShowOrHideFightMonsterBtn);
         Starling.juggler.removeTweens(_blackGound);
         ObjectUtils.disposeAllChildren(this);
         _killRankView = null;
         _nextWaveMonsterView = null;
         _showOrHideFightMonsterBtn = null;
         ObjectUtils.disposeObject(_blackGound);
         _blackGound = null;
      }
      
      private function onActiveStateChange(param1:Event) : void
      {
         checkShowNextWaveMonsterView();
         checkShowOrHideFightMonsterBtn();
         if(ConsortiaDomainManager.instance.activeState == 1 || ConsortiaDomainManager.instance.activeState == 100)
         {
            ConsortiaDomainManager.instance.getInfoOnEnterScene();
            _blackGound = new Shape();
            _blackGound.graphics.beginFill(0,1);
            _blackGound.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
            _blackGound.graphics.endFill();
            _blackGound.alpha = 0;
            addChild(_blackGound);
            Starling.juggler.tween(_blackGound,0.5,{"alpha":1});
            Starling.juggler.tween(_blackGound,0.5,{
               "delay":0.5,
               "alpha":0,
               "onComplete":onTweenBlackGoundComplete
            });
         }
      }
      
      private function onTweenBlackGoundComplete() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         ObjectUtils.disposeObject(_blackGound);
         if(ConsortiaDomainManager.instance.activeState == 100)
         {
            _loc1_ = ConsortiaDomainManager.instance.model.allBuildInfo[5];
            if(_loc1_ && _loc1_.Blood == 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("consortiadomain.activeEnd");
               ChatManager.Instance.sysChatConsortia(_loc2_);
               MessageTipManager.getInstance().show(_loc2_);
            }
         }
         else if(ConsortiaDomainManager.instance.activeState == 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortiadomain.activeOpenAlert");
            MessageTipManager.getInstance().show(_loc2_);
         }
      }
      
      private function checkShowNextWaveMonsterView() : void
      {
         var _loc1_:int = ConsortiaDomainManager.instance.activeState;
         if(_loc1_ == 100)
         {
            ObjectUtils.disposeObject(_nextWaveMonsterView);
            _nextWaveMonsterView = null;
         }
         else if(_loc1_ == 1 || _loc1_ == -10 || _loc1_ == -5 || _loc1_ == -4 || _loc1_ == -3 || _loc1_ == -2 || _loc1_ == -1)
         {
            if(!_nextWaveMonsterView)
            {
               _nextWaveMonsterView = new NextWaveMonsterView();
               _nextWaveMonsterView.x = StageReferance.stageWidth - _nextWaveMonsterView.width - 2;
               _nextWaveMonsterView.y = 2;
               addChild(_nextWaveMonsterView);
            }
         }
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
   }
}
