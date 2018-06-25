package floatParade.views
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
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import floatParade.FloatParadeEvent;
   import floatParade.FloatParadeManager;
   import gameCommon.GameControl;
   import invite.InviteManager;
   
   public class FloatParadeMainView extends BaseStateView
   {
       
      
      private var _mapView:FloatParadeMapView;
      
      private var _exitBtn:FloatParadeExitBtn;
      
      private var _threeBtnView:FloatParadeThreeBtnView;
      
      private var _countDownView:FloatParadeCountDown;
      
      private var _rankView:FloatParadeRankView;
      
      private var _chatView:Sprite;
      
      private var _waitMc:MovieClip;
      
      private var _gameStartCountDownView:FloatParadeStartCountDown;
      
      private var _helpBtn:FloatParadeHelpBtn;
      
      private var _arriveCountDown:FloatParadeArriveCountDown;
      
      public function FloatParadeMainView()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         if(!FloatParadeManager.instance.isInGame)
         {
            StateManager.setState("main");
            return;
         }
         SocketManager.Instance.out.sendUpdateSysDate();
         InviteManager.Instance.enabled = false;
         CacheSysManager.lock("sevenDoubleInRoom");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         super.enter(prev,data);
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         MainToolBar.Instance.hide();
         SoundManager.instance.playMusic("12020");
         FloatParadeManager.instance.loadSound();
         initView();
         initEvent();
         SocketManager.Instance.out.sendEscortReady();
         SocketManager.Instance.out.sendEscortEnterOrLeaveScene(true);
      }
      
      private function initView() : void
      {
         _mapView = new FloatParadeMapView();
         addChild(_mapView);
         _exitBtn = new FloatParadeExitBtn();
         addChild(_exitBtn);
         _threeBtnView = new FloatParadeThreeBtnView();
         _threeBtnView.mouseChildren = false;
         _threeBtnView.mouseEnabled = false;
         addChild(_threeBtnView);
         _countDownView = new FloatParadeCountDown();
         addChild(_countDownView);
         _arriveCountDown = new FloatParadeArriveCountDown();
         addChild(_arriveCountDown);
         _mapView.arriveCountDown = _arriveCountDown;
         _rankView = new FloatParadeRankView();
         addChild(_rankView);
         _chatView = ChatManager.Instance.view;
         _chatView.visible = true;
         addChild(_chatView);
         ChatManager.Instance.state = 99;
         _waitMc = ComponentFactory.Instance.creat("floatParade.waitOtherPlayerPrompt");
         _waitMc.gotoAndStop(1);
         PositionUtils.setPos(_waitMc,"floatParade.game.waitStartGamePromptPos");
         addChild(_waitMc);
         _helpBtn = new FloatParadeHelpBtn();
         addChild(_helpBtn);
      }
      
      private function initEvent() : void
      {
         FloatParadeManager.instance.addEventListener("floatParadeAllReady",allReadyHandler);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_1 = true;
         FloatParadeManager.instance.addEventListener("floatParadeDestroy",destroyHandler);
         FloatParadeManager.instance.addEventListener("floatParadeArrive",arriveHandler);
      }
      
      private function destroyHandler(e:Event) : void
      {
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("floatParade.timeEnd.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",returnMainState,false,0,true);
         _mapView.endGame();
      }
      
      private function arriveHandler(event:FloatParadeEvent) : void
      {
         var confirmFrame:* = null;
         var tmpData:Object = event.data;
         if(tmpData.zoneId == PlayerManager.Instance.Self.ZoneID && tmpData.id == PlayerManager.Instance.Self.ID)
         {
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("floatParade.arrive.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",returnMainState,false,0,true);
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
      
      private function allReadyHandler(event:FloatParadeEvent) : void
      {
         if(_waitMc)
         {
            _waitMc.gotoAndStop(2);
         }
         if(event.data.isShowStartCountDown)
         {
            _gameStartCountDownView = new FloatParadeStartCountDown(doStartGame,[event.data.endTime,event.data.sprintEndTime]);
            addChild(_gameStartCountDownView);
            _mapView.npcChat(LanguageMgr.GetTranslation("floatParade.npc.start"));
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
         _mapView.npcArriveTime = sprintEndTime;
         _threeBtnView.mouseChildren = true;
         _threeBtnView.mouseEnabled = true;
      }
      
      private function removeEvent() : void
      {
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_8 = true;
         FloatParadeManager.instance.removeEventListener("floatParadeAllReady",allReadyHandler);
         FloatParadeManager.instance.removeEventListener("floatParadeDestroy",destroyHandler);
         FloatParadeManager.instance.removeEventListener("floatParadeArrive",arriveHandler);
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
         if(_mapView)
         {
            _mapView.arriveCountDown = null;
         }
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
         ObjectUtils.disposeObject(_exitBtn);
         _exitBtn = null;
         ObjectUtils.disposeObject(_threeBtnView);
         _threeBtnView = null;
         ObjectUtils.disposeObject(_countDownView);
         _countDownView = null;
         ObjectUtils.disposeObject(_rankView);
         _rankView = null;
         ObjectUtils.disposeObject(_gameStartCountDownView);
         _gameStartCountDownView = null;
         ObjectUtils.disposeObject(_arriveCountDown);
         _arriveCountDown = null;
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
         FloatParadeManager.instance.leaveMainViewHandler();
         SocketManager.Instance.out.sendEscortEnterOrLeaveScene(false);
      }
      
      override public function getType() : String
      {
         return "floatparade";
      }
   }
}
