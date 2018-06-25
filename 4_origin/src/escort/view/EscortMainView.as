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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
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
         super.enter(prev,data);
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
      
      private function destroyHandler(e:Event) : void
      {
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.timeEnd.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",returnMainState,false,0,true);
         _mapView.endGame();
      }
      
      private function arriveHandler(event:EscortEvent) : void
      {
         var confirmFrame:* = null;
         var tmpData:Object = event.data;
         if(tmpData.zoneId == PlayerManager.Instance.Self.ZoneID && tmpData.id == PlayerManager.Instance.Self.ID)
         {
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("escort.arrive.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",returnMainState,false,0,true);
            _mapView.runPercent = null;
            _runPercent.refreshView(22780);
            _mapView.endGame();
         }
      }
      
      private function returnMainState(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",returnMainState);
         StateManager.setState("main");
      }
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function allReadyHandler(event:EscortEvent) : void
      {
         if(_waitMc)
         {
            _waitMc.gotoAndStop(2);
         }
         if(event.data.isShowStartCountDown)
         {
            _gameStartCountDownView = new EscortStartCountDownView(doStartGame,[event.data.endTime,event.data.sprintEndTime]);
            addChild(_gameStartCountDownView);
         }
         else
         {
            doStartGame(event.data.endTime,event.data.sprintEndTime);
         }
      }
      
      private function doStartGame(endTime:Date, sprintEndTime:Date) : void
      {
         if(!_mapView)
         {
            return;
         }
         _mapView.startGame();
         _countDownView.setCountDown(endTime);
         _sprintCountDownView.setCountDown(sprintEndTime);
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
      
      override public function leaving(next:BaseStateView) : void
      {
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("sevenDoubleInRoom");
         CacheSysManager.getInstance().release("sevenDoubleInRoom");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         removeEvent();
         super.leaving(next);
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
