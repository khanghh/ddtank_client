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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
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
         super.enter(param1,param2);
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
      
      private function destroyHandler(param1:Event) : void
      {
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("floatParade.timeEnd.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",returnMainState,false,0,true);
         _mapView.endGame();
      }
      
      private function arriveHandler(param1:FloatParadeEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Object = param1.data;
         if(_loc2_.zoneId == PlayerManager.Instance.Self.ZoneID && _loc2_.id == PlayerManager.Instance.Self.ID)
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("floatParade.arrive.tipTxt"),LanguageMgr.GetTranslation("ok"),"",true,false,false,1);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",returnMainState,false,0,true);
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
      
      private function allReadyHandler(param1:FloatParadeEvent) : void
      {
         if(_waitMc)
         {
            _waitMc.gotoAndStop(2);
         }
         if(param1.data.isShowStartCountDown)
         {
            _gameStartCountDownView = new FloatParadeStartCountDown(doStartGame,[param1.data.endTime,param1.data.sprintEndTime]);
            addChild(_gameStartCountDownView);
            _mapView.npcChat(LanguageMgr.GetTranslation("floatParade.npc.start"));
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
         _mapView.npcArriveTime = param2;
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
