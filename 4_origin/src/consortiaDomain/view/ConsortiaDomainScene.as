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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
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
         var chatView:ChatView = ChatManager.Instance.view;
         chatView.visible = true;
         addChild(chatView);
         _returnBtn = ComponentFactory.Instance.creatCustomObject("asset.simpleReturnBar.Button");
         _returnBtn.returnCall = ConsortiaDomainManager.instance.leaveScene;
         addChild(_returnBtn);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         ConsortiaDomainManager.instance.addEventListener("event_active_state_change",onActiveStateChange);
      }
      
      private function initView() : void
      {
         var activeState:int = ConsortiaDomainManager.instance.activeState;
         _killRankView = new KillRankView();
         _killRankView.setOpen(activeState == 1);
         _buildStateView = new BuildsStateView();
         _buildStateView.x = 2;
         _buildStateView.y = 2;
         addChild(_buildStateView);
         checkShowOrHideFightMonsterBtn();
         checkShowNextWaveMonsterView();
      }
      
      private function checkShowOrHideFightMonsterBtn() : void
      {
         var activeState:int = ConsortiaDomainManager.instance.activeState;
         if(activeState == 100)
         {
            ObjectUtils.disposeObject(_showOrHideFightMonsterBtn);
            _showOrHideFightMonsterBtn = null;
         }
         else if(activeState == 1)
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
      
      private function onClickShowOrHideFightMonsterBtn(event:MouseEvent) : void
      {
         ConsortiaDomainManager.instance.isShowFightMonster = !ConsortiaDomainManager.instance.isShowFightMonster;
         setShowOrHideFightMonsterBtnBackStyle();
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         super.leaving(next);
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
      
      private function onActiveStateChange(event:Event) : void
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
         var msg:* = null;
         var cityEachBuildInfo:* = null;
         ObjectUtils.disposeObject(_blackGound);
         if(ConsortiaDomainManager.instance.activeState == 100)
         {
            cityEachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[5];
            if(cityEachBuildInfo && cityEachBuildInfo.Blood == 0)
            {
               msg = LanguageMgr.GetTranslation("consortiadomain.activeEnd");
               ChatManager.Instance.sysChatConsortia(msg);
               MessageTipManager.getInstance().show(msg);
            }
         }
         else if(ConsortiaDomainManager.instance.activeState == 1)
         {
            msg = LanguageMgr.GetTranslation("consortiadomain.activeOpenAlert");
            MessageTipManager.getInstance().show(msg);
         }
      }
      
      private function checkShowNextWaveMonsterView() : void
      {
         var activeState:int = ConsortiaDomainManager.instance.activeState;
         if(activeState == 100)
         {
            ObjectUtils.disposeObject(_nextWaveMonsterView);
            _nextWaveMonsterView = null;
         }
         else if(activeState == 1 || activeState == -10 || activeState == -5 || activeState == -4 || activeState == -3 || activeState == -2 || activeState == -1)
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
