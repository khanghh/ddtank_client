package consortionBattle.view
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.display.Sprite;
   import flash.events.Event;
   import gameCommon.GameControl;
   import invite.InviteManager;
   
   public class ConsortiaBattleMainView extends BaseStateView
   {
       
      
      private var _mapView:ConsortiaBattleMapView;
      
      private var _exitBtn:ConsBatExitBtn;
      
      private var _infoView:ConsBatInfoView;
      
      private var _inTimerView:ConsBatInTimer;
      
      private var _twoBtnView:ConsBatTwoBtnView;
      
      private var _hideBtn:ConsBatHideBtn;
      
      private var _helpBtn:ConsBatHelpBtn;
      
      private var _socreView:ConsBatScoreView;
      
      private var _broadcastView:ConsBatChatView;
      
      private var _chatView:Sprite;
      
      public function ConsortiaBattleMainView()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         if(!ConsortiaBattleManager.instance.isOpen)
         {
            closeHandler(null);
            return;
         }
         try
         {
            SocketManager.Instance.out.sendUpdateSysDate();
            InviteManager.Instance.enabled = false;
            CacheSysManager.lock("consortiaBattleInRoom");
            KeyboardShortcutsManager.Instance.forbiddenFull();
            super.enter(prev,data);
            LayerManager.Instance.clearnGameDynamic();
            LayerManager.Instance.clearnStageDynamic();
            MainToolBar.Instance.hide();
            SoundManager.instance.playMusic("12019");
            initView();
            initEvent();
            initData();
            ConsortiaBattleManager.instance.isInMainView = true;
            return;
         }
         catch(err:Error)
         {
            SocketManager.Instance.out.sendConsBatExit();
            closeHandler(null);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortiaBattle.loadResError"));
            throw new Error(err.message);
         }
      }
      
      private function initView() : void
      {
         _mapView = new ConsortiaBattleMapView("tank.consortiaBattle.Map",ConsortiaBattleManager.instance.playerDataList);
         addChild(_mapView);
         _mapView.addSelfPlayer();
         _exitBtn = new ConsBatExitBtn();
         addChild(_exitBtn);
         _infoView = new ConsBatInfoView();
         addChild(_infoView);
         _inTimerView = new ConsBatInTimer();
         addChild(_inTimerView);
         _twoBtnView = new ConsBatTwoBtnView();
         addChild(_twoBtnView);
         _hideBtn = new ConsBatHideBtn();
         addChild(_hideBtn);
         _helpBtn = new ConsBatHelpBtn();
         addChild(_helpBtn);
         _socreView = new ConsBatScoreView();
         addChild(_socreView);
         _broadcastView = new ConsBatChatView();
         addChild(_broadcastView);
         _chatView = ChatManager.Instance.view;
         addChild(_chatView);
         ChatManager.Instance.state = 29;
         ChatManager.Instance.setFocus();
         ChatManager.Instance.lock = true;
      }
      
      private function initEvent() : void
      {
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_1 = true;
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleClose",closeHandler);
      }
      
      private function closeHandler(event:Event) : void
      {
         StateManager.setState("main");
      }
      
      private function initData() : void
      {
      }
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("consortiaBattleInRoom");
         CacheSysManager.getInstance().release("consortiaBattleInRoom");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_8 = true;
         ConsortiaBattleManager.instance.removeEventListener("consortiaBattleClose",closeHandler);
         super.leaving(next);
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
         ObjectUtils.disposeObject(_exitBtn);
         _exitBtn = null;
         ObjectUtils.disposeObject(_infoView);
         _infoView = null;
         ObjectUtils.disposeObject(_inTimerView);
         _inTimerView = null;
         ObjectUtils.disposeObject(_twoBtnView);
         _twoBtnView = null;
         ObjectUtils.disposeObject(_hideBtn);
         _hideBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_socreView);
         _socreView = null;
         ObjectUtils.disposeObject(_broadcastView);
         _broadcastView = null;
         if(_chatView && this.contains(_chatView))
         {
            this.removeChild(_chatView);
         }
         _chatView = null;
         ConsortiaBattleManager.instance.clearPlayerInfo();
         ConsortiaBattleManager.instance.isInMainView = false;
      }
      
      override public function getType() : String
      {
         return "consortiaBattleScene";
      }
      
      override public function dispose() : void
      {
      }
   }
}
