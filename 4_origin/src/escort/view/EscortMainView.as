package escort.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import escort.EscortControl;
   import escort.EscortManager;
   import escort.event.EscortEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import gameCommon.GameControl;
   import invite.InviteManager;
   
   public class EscortMainView extends BaseStateView
   {
       
      
      private var _mapView:EscortMapView;
      
      private var _exitBtn:EscortExitBtn;
      
      private var _threeBtnView:EscortThreeBtnView;
      
      private var _countDownView:EscortCountDownView;
      
      private var _rankView:EscortRankView;
      
      private var _chatView:Sprite;
      
      private var _waitMc:MovieClip;
      
      private var _gameStartCountDownView:EscortStartCountDownView;
      
      private var _helpBtn:EscortHelpBtn;
      
      private var _runPercent:EscortRunPercentView;
      
      private var _sprintCountDownView:EscortSprintCountDownView;
      
      public function EscortMainView()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         if(!EscortManager.instance.isInGame)
         {
            StateManager.setState("main");
            return;
         }
         EscortControl.instance.checkInitData();
         SocketManager.Instance.out.sendUpdateSysDate();
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("sevenDoubleInRoom");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         super.enter(param1,param2);
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         MainToolBar.Instance.hide();
         SoundManager.instance.playMusic("12020");
         EscortManager.instance.loadSound();
         initView();
         initEvent();
         SocketManager.Instance.out.sendEscortReady();
         EscortManager.instance.enterMainViewHandler();
         SocketManager.Instance.out.sendEscortEnterOrLeaveScene(true);
      }
      
      private function initView() : void
      {
         _mapView = new EscortMapView();
         addChild(_mapView);
         _exitBtn = new EscortExitBtn();
         addChild(_exitBtn);
         _threeBtnView = new EscortThreeBtnView();
         _threeBtnView.mouseChildren = false;
         _threeBtnView.mouseEnabled = false;
         addChild(_threeBtnView);
         _countDownView = new EscortCountDownView();
         addChild(_countDownView);
         _runPercent = new EscortRunPercentView();
         addChild(_runPercent);
         _mapView.runPercent = _runPercent;
         _sprintCountDownView = new EscortSprintCountDownView();
         addChild(_sprintCountDownView);
         _rankView = new EscortRankView();
         addChild(_rankView);
         _chatView = ChatManager.Instance.view;
         _chatView.visible = true;
         addChild(_chatView);
         ChatManager.Instance.state = 99;
         _waitMc = ComponentFactory.Instance.creat("asset.escort.waitOtherPlayerPrompt");
         _waitMc.gotoAndStop(1);
         PositionUtils.setPos(_waitMc,"escort.game.waitStartGamePromptPos");
         addChild(_waitMc);
         _helpBtn = new EscortHelpBtn();
         addChild(_helpBtn);
      }
      
      private function initEvent() : void
      {
         EscortManager.instance.addEventListener("escortAllReady",allReadyHandler);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_1 = true;
         EscortManager.instance.addEventListener("escortDestroy",destroyHandler);
         EscortManager.instance.addEventListener("escortArrive",arriveHandler);
      }
      
      private function destroyHandler(param1:Event) : void
      {
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.timeEnd.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",returnMainState,false,0,true);
         _mapView.endGame();
      }
      
      private function arriveHandler(param1:EscortEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Object = param1.data;
         if(_loc2_.zoneId == PlayerManager.Instance.Self.ZoneID && _loc2_.id == PlayerManager.Instance.Self.ID)
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.arrive.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",returnMainState,false,0,true);
            _mapView.runPercent = null;
            _runPercent.refreshView(22780);
            _mapView.endGame();
         }
      }
      
      private function returnMainState(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",returnMainState);
         StateManager.setState("main");
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function allReadyHandler(param1:EscortEvent) : void
      {
         if(_waitMc)
         {
            _waitMc.gotoAndStop(2);
         }
         if(param1.data.isShowStartCountDown)
         {
            _gameStartCountDownView = new EscortStartCountDownView(doStartGame,[param1.data.endTime,param1.data.sprintEndTime]);
            addChild(_gameStartCountDownView);
         }
         else
         {
            doStartGame(param1.data.endTime,param1.data.sprintEndTime);
         }
      }
      
      private function doStartGame(param1:Date, param2:Date) : void
      {
         if(!_mapView)
         {
            return;
         }
         _mapView.startGame();
         _countDownView.setCountDown(param1);
         _sprintCountDownView.setCountDown(param2);
         _threeBtnView.mouseChildren = true;
         _threeBtnView.mouseEnabled = true;
      }
      
      private function removeEvent() : void
      {
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_8 = true;
         EscortManager.instance.removeEventListener("escortAllReady",allReadyHandler);
         EscortManager.instance.removeEventListener("escortDestroy",destroyHandler);
         EscortManager.instance.removeEventListener("escortArrive",arriveHandler);
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("sevenDoubleInRoom");
         CacheSysManager.getInstance().release("sevenDoubleInRoom");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         removeEvent();
         super.leaving(param1);
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
         ObjectUtils.disposeObject(_exitBtn);
         _exitBtn = null;
         ObjectUtils.disposeObject(_threeBtnView);
         _threeBtnView = null;
         ObjectUtils.disposeObject(_countDownView);
         _countDownView = null;
         ObjectUtils.disposeObject(_sprintCountDownView);
         _sprintCountDownView = null;
         ObjectUtils.disposeObject(_runPercent);
         _runPercent = null;
         ObjectUtils.disposeObject(_rankView);
         _rankView = null;
         ObjectUtils.disposeObject(_gameStartCountDownView);
         _gameStartCountDownView = null;
         if(_chatView && this.contains(_chatView))
         {
            this.removeChild(_chatView);
         }
         _chatView = null;
         if(_waitMc)
         {
            _waitMc.gotoAndStop(2);
            if(this.contains(_waitMc))
            {
               this.removeChild(_waitMc);
            }
         }
         _waitMc = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         EscortManager.instance.leaveMainViewHandler();
         SocketManager.Instance.out.sendEscortEnterOrLeaveScene(false);
      }
      
      override public function getType() : String
      {
         return "escort";
      }
   }
}
