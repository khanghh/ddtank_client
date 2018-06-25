package drgnBoat.views
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
   import drgnBoat.DrgnBoatManager;
   import drgnBoat.event.DrgnBoatEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   import gameCommon.GameControl;
   import invite.InviteManager;
   
   public class DrgnBoatMainView extends BaseStateView
   {
       
      
      private var _mapView:DrgnBoatMapView;
      
      private var _exitBtn:DrgnBoatExitBtn;
      
      private var _threeBtnView:DrgnBoatThreeBtnView;
      
      private var _countDownView:DrgnBoatCountDown;
      
      private var _rankView:DrgnBoatRankView;
      
      private var _chatView:Sprite;
      
      private var _waitMc:MovieClip;
      
      private var _gameStartCountDownView:DrgnBoatStartCountDown;
      
      private var _helpBtn:DrgnBoatHelpBtn;
      
      private var _arriveCountDown:DrgnBoatArriveCountDown;
      
      public function DrgnBoatMainView()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         if(!DrgnBoatManager.instance.isInGame)
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
         DrgnBoatManager.instance.loadSound();
         initView();
         initEvent();
         SocketManager.Instance.out.sendEscortReady();
         DrgnBoatManager.instance.enterMainViewHandler();
         SocketManager.Instance.out.sendEscortEnterOrLeaveScene(true);
      }
      
      private function initView() : void
      {
         _mapView = new DrgnBoatMapView();
         addChild(_mapView);
         _exitBtn = new DrgnBoatExitBtn();
         addChild(_exitBtn);
         _threeBtnView = new DrgnBoatThreeBtnView();
         _threeBtnView.mouseChildren = false;
         _threeBtnView.mouseEnabled = false;
         addChild(_threeBtnView);
         _countDownView = new DrgnBoatCountDown();
         addChild(_countDownView);
         _arriveCountDown = new DrgnBoatArriveCountDown();
         addChild(_arriveCountDown);
         _mapView.arriveCountDown = _arriveCountDown;
         _rankView = new DrgnBoatRankView();
         addChild(_rankView);
         _chatView = ChatManager.Instance.view;
         _chatView.visible = true;
         addChild(_chatView);
         ChatManager.Instance.state = 99;
         _waitMc = ComponentFactory.Instance.creat("drgnBoat.waitOtherPlayerPrompt");
         _waitMc.gotoAndStop(1);
         PositionUtils.setPos(_waitMc,"drgnBoat.game.waitStartGamePromptPos");
         addChild(_waitMc);
         _helpBtn = new DrgnBoatHelpBtn();
         addChild(_helpBtn);
      }
      
      private function initEvent() : void
      {
         DrgnBoatManager.instance.addEventListener("drgnBoatAllReady",allReadyHandler);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_1 = true;
         DrgnBoatManager.instance.addEventListener("drgnBoatDestroy",destroyHandler);
         DrgnBoatManager.instance.addEventListener("drgnBoatArrive",arriveHandler);
      }
      
      private function destroyHandler(e:Event) : void
      {
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("drgnBoat.timeEnd.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",returnMainState,false,0,true);
         _mapView.endGame();
      }
      
      private function arriveHandler(event:DrgnBoatEvent) : void
      {
         var confirmFrame:* = null;
         var tmpData:Object = event.data;
         if(tmpData.zoneId == PlayerManager.Instance.Self.ZoneID && tmpData.id == PlayerManager.Instance.Self.ID)
         {
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("drgnBoat.arrive.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
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
         var gameControl:* = getDefinitionByName("gameCommon.GameControl");
         if(gameControl)
         {
            StateManager.setState("roomLoading",gameControl.instance.Current);
            StateManager.getInGame_Step_7 = true;
         }
      }
      
      private function allReadyHandler(event:DrgnBoatEvent) : void
      {
         if(_waitMc)
         {
            _waitMc.gotoAndStop(2);
         }
         if(event.data.isShowStartCountDown)
         {
            _gameStartCountDownView = new DrgnBoatStartCountDown(doStartGame,[event.data.endTime,event.data.sprintEndTime]);
            addChild(_gameStartCountDownView);
            _mapView.npcChat(LanguageMgr.GetTranslation("drgnBoat.npc.start"));
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
         DrgnBoatManager.instance.removeEventListener("drgnBoatAllReady",allReadyHandler);
         DrgnBoatManager.instance.removeEventListener("drgnBoatDestroy",destroyHandler);
         DrgnBoatManager.instance.removeEventListener("drgnBoatArrive",arriveHandler);
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
         _mapView.arriveCountDown = null;
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
         DrgnBoatManager.instance.leaveMainViewHandler();
         SocketManager.Instance.out.sendEscortEnterOrLeaveScene(false);
      }
      
      override public function getType() : String
      {
         return "drgnBoat";
      }
   }
}
