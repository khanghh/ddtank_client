package room.view.roomView
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.PkgEvent;
   import ddt.events.RoomEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ChatManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import email.MailManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import hall.event.NewHallEvent;
   import invite.InviteFrame;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.RoomPlayerItem;
   import room.view.RoomRightPropView;
   import room.view.RoomViewerItem;
   import trainer.view.NewHandContainer;
   
   public class BaseRoomView extends Sprite implements Disposeable
   {
      
      protected static const HURRY_UP_TIME:int = 30;
      
      protected static const KICK_TIME:int = 60;
      
      protected static const KICK_TIMEII:int = 300;
      
      protected static const KICK_TIMEIII:int = 1200;
      
      protected static const ACTIVITY_MINGRADE:int = 25;
       
      
      protected var _hostTimer:Timer;
      
      protected var _normalTimer:Timer;
      
      protected var _info:RoomInfo;
      
      protected var _roomPropView:RoomRightPropView;
      
      protected var _btnBg:Bitmap;
      
      protected var _startBtn:MovieClip;
      
      protected var _prepareBtn:MovieClip;
      
      protected var _cancelBtn:SimpleBitmapButton;
      
      protected var _inviteBtn:SimpleBitmapButton;
      
      protected var _inviteFrame:InviteFrame;
      
      protected var _startInvite:Boolean = false;
      
      protected var _playerItems:Array;
      
      protected var _viewerItems:Vector.<RoomViewerItem>;
      
      protected var _emailBtn:MovieImage;
      
      protected var _taskIconBtn:MovieImage;
      
      public function BaseRoomView(param1:RoomInfo)
      {
         super();
         _info = param1;
         initTimer();
         initView();
         initEvents();
      }
      
      protected function initView() : void
      {
         _roomPropView = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.roomPropView");
         addChild(_roomPropView);
         _btnBg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.btnBg");
         addChild(_btnBg);
         PositionUtils.setPos(_btnBg,"asset.ddtroom.btnBgPos");
         _startBtn = ClassUtils.CreatInstance("asset.ddtroom.startMovie") as MovieClip;
         addChild(_startBtn);
         PositionUtils.setPos(_startBtn,"asset.ddtroom.startMoviePos");
         _prepareBtn = ClassUtils.CreatInstance("asset.ddtroom.preparMovie") as MovieClip;
         addChild(_prepareBtn);
         PositionUtils.setPos(_prepareBtn,"asset.ddtroom.startMoviePos");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.cancelButton");
         addChild(_cancelBtn);
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.inviteButton");
         addChild(_inviteBtn);
         if(_info.type != 120)
         {
            _emailBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.mailBtn");
            _emailBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.email");
            _emailBtn.buttonMode = true;
            showEmailEffect(true);
            PositionUtils.setPos(_emailBtn,"hall.playerInfo.mailBtnPos");
            addChild(_emailBtn);
            _taskIconBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.taskIconBtn");
            _taskIconBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.task");
            _taskIconBtn.buttonMode = true;
            showTaskEffect(TaskManager.instance.isTaskHightLight);
            PositionUtils.setPos(_taskIconBtn,"hall.playerInfo.taskIconBtnPos");
            addChild(_taskIconBtn);
         }
         var _loc1_:Boolean = true;
         _prepareBtn.buttonMode = _loc1_;
         _startBtn.buttonMode = _loc1_;
         initTileList();
         initPlayerItems();
         updateButtons();
      }
      
      private function showEmailEffect(param1:Boolean) : void
      {
         if(param1 && MailManager.Instance.Model.hasUnReadEmail())
         {
            _emailBtn.movie.gotoAndStop(2);
            _emailBtn.mouseEnabled = true;
            _emailBtn.mouseChildren = true;
         }
         else
         {
            _emailBtn.movie.gotoAndStop(1);
         }
      }
      
      private function showTaskEffect(param1:Boolean) : void
      {
         if(_info.type != 120)
         {
            if(param1)
            {
               _taskIconBtn.movie.gotoAndStop(2);
               _taskIconBtn.mouseEnabled = true;
               _taskIconBtn.mouseChildren = true;
            }
            else
            {
               _taskIconBtn.movie.gotoAndStop(1);
            }
         }
      }
      
      private function initTimer() : void
      {
         _hostTimer = new Timer(1000);
         _normalTimer = new Timer(1000);
         if(!_info || !_info.selfRoomPlayer)
         {
            return;
         }
         if(!_info.selfRoomPlayer.isHost)
         {
            startNormalTimer();
         }
         else if(_info.isAllReady())
         {
            startHostTimer();
         }
      }
      
      protected function updateButtons() : void
      {
         updateTimer();
         _startBtn.visible = _info.selfRoomPlayer.isHost && !_info.started;
         _prepareBtn.visible = !_info.selfRoomPlayer.isHost && !_info.selfRoomPlayer.isReady;
         _cancelBtn.visible = !!_info.selfRoomPlayer.isHost?_info.started:Boolean(_info.selfRoomPlayer.isReady);
         _cancelBtn.enable = _info.selfRoomPlayer.isHost || !_info.started;
         _inviteBtn.enable = !_info.started;
         if(_info.isAllReady())
         {
            _startBtn.addEventListener("click",__startClick);
            _startBtn.filters = null;
            if(_startBtn && _startBtn.hasOwnProperty("startA"))
            {
               _startBtn["startA"].play();
            }
            _startBtn.buttonMode = true;
         }
         else
         {
            _startBtn.removeEventListener("click",__startClick);
            _startBtn.filters = [ComponentFactory.Instance.model.getSet("grayFilter")];
            if(_startBtn && _startBtn.hasOwnProperty("startA"))
            {
               _startBtn["startA"].gotoAndStop(1);
            }
            _startBtn.buttonMode = false;
         }
         if(_info.selfRoomPlayer.isViewer)
         {
            _prepareBtn.visible = false;
            _cancelBtn.visible = true;
            _cancelBtn.enable = false;
         }
         RoomManager.Instance.isPrepare = _prepareBtn.visible;
      }
      
      protected function initTileList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _playerItems = [];
         if(isViewerRoom)
         {
            _viewerItems = new Vector.<RoomViewerItem>();
            _loc2_ = 8;
            while(_loc2_ < 10)
            {
               if(_info.type == 0 || _info.type == 120 || _info.type == 58)
               {
                  _loc1_ = new RoomViewerItem(_loc2_);
               }
               else
               {
                  _loc1_ = new RoomViewerItem(_loc2_,90);
               }
               _viewerItems.push(_loc1_);
               _loc2_++;
            }
         }
      }
      
      protected function get isViewerRoom() : Boolean
      {
         return _info.type == 1 || _info.type == 0 || _info.type == 120 || _info.type == 4 || _info.type == 11 || _info.type == 21 || _info.type == 23 || _info.type == 123 || _info.type == 58;
      }
      
      protected function initPlayerItems() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _playerItems.length)
         {
            _loc2_ = _playerItems[_loc3_] as RoomPlayerItem;
            _loc2_.info = _info.findPlayerByPlace(_loc3_);
            _loc2_.opened = _info.placesState[_loc3_] != 0;
            _loc3_++;
         }
         if(isViewerRoom)
         {
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               if(_viewerItems && _viewerItems[_loc3_])
               {
                  _loc1_ = _viewerItems[_loc3_] as RoomViewerItem;
                  _loc1_.info = _info.findPlayerByPlace(_loc3_ + 8);
                  _loc1_.opened = _info.placesState[_loc3_ + 8] != 0;
               }
               _loc3_++;
            }
         }
      }
      
      protected function initEvents() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _inviteBtn.addEventListener("click",__inviteClick);
         _info.addEventListener("roomplaceChanged",__updatePlayerItems);
         _info.addEventListener("playerStateChanged",__updateState);
         _info.addEventListener("addPlayer",__addPlayer);
         _info.addEventListener("removePlayer",__removePlayer);
         _info.addEventListener("startedChanged",__startHandler);
         _startBtn.addEventListener("click",__startClick);
         _cancelBtn.addEventListener("click",__cancelClick);
         _prepareBtn.addEventListener("click",__prepareClick);
         addEventListener("addedToStage",__loadWeakGuild);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,25),__changeRoomborden);
         SocketManager.Instance.addEventListener(PkgEvent.format(390,21),__useRoomborden);
         if(isViewerRoom)
         {
            _loc2_ = 0;
            while(_loc2_ < 2)
            {
               if(_viewerItems && _viewerItems[_loc2_])
               {
                  _loc1_ = _viewerItems[_loc2_];
                  _viewerItems[_loc2_].addEventListener("viewerItemInfoSet",__switchClickEnabled);
               }
               _loc2_++;
            }
         }
         if(_info.type != 120)
         {
            if(_emailBtn)
            {
               _emailBtn.addEventListener("click",__onMailClick);
            }
            if(_taskIconBtn)
            {
               _taskIconBtn.addEventListener("click",__onTaskClick);
            }
         }
         MailManager.Instance.Model.addEventListener("initEmail",__updateEmail);
         MailManager.Instance.Model.addEventListener("cancelemailshine",__onSetEmailShine);
         TaskManager.instance.addEventListener("showTaskHightLight",__showTaskHightLight);
         TaskManager.instance.addEventListener("hideTaskHightLight",__hideTaskHightLight);
      }
      
      protected function __changeRoomborden(param1:PkgEvent) : void
      {
         var _loc5_:PackageIn = param1.pkg;
         var _loc6_:int = _loc5_.readInt();
         var _loc3_:int = _loc5_.readInt();
         var _loc2_:int = _loc5_.readInt();
         var _loc7_:RoomInfo = RoomManager.Instance.current;
         _loc7_.findPlayerByPlace(_loc6_).playerInfo.curcentRoomBordenTemplateId = _loc2_;
         var _loc4_:RoomPlayerItem = _playerItems[_loc6_] as RoomPlayerItem;
         _loc4_.info = _info.findPlayerByPlace(_loc6_);
      }
      
      protected function __useRoomborden(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         PlayerManager.Instance.curcentId = _loc4_.readInt();
         var _loc2_:BagInfo = PlayerManager.Instance.Self.getBag(43);
         var _loc9_:int = 0;
         var _loc8_:* = _loc2_.items;
         for(var _loc5_ in _loc2_.items)
         {
            if((_loc2_.items[_loc5_] as InventoryItemInfo).ItemID == PlayerManager.Instance.curcentId)
            {
               (_loc2_.items[_loc5_] as InventoryItemInfo).IsUsed = _loc4_.readBoolean();
               (_loc2_.items[_loc5_] as InventoryItemInfo).BeginDate = _loc4_.readDateString();
               break;
            }
         }
         PlayerManager.Instance.Self.getBag(43).dispatchEvent(new BagEvent("update",null));
         var _loc7_:RoomInfo = RoomManager.Instance.current;
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc3_ = _playerItems[_loc6_] as RoomPlayerItem;
            _loc3_.info = _info.findPlayerByPlace(_loc6_);
            _loc6_++;
         }
      }
      
      protected function __onMailClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         if(PlayerManager.Instance.Self.Grade >= 1)
         {
            MailManager.Instance.switchVisible();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("hall.playerTool.emailLimit"));
         }
      }
      
      protected function __updateEmail(param1:Event) : void
      {
         if(_emailBtn)
         {
            showEmailEffect(true);
         }
      }
      
      protected function __onSetEmailShine(param1:NewHallEvent) : void
      {
         if(_info.type != 120)
         {
            showEmailEffect(false);
         }
      }
      
      protected function __onTaskClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         TaskManager.instance.switchVisible();
      }
      
      protected function __showTaskHightLight(param1:Event) : void
      {
         showTaskEffect(true);
      }
      
      protected function __hideTaskHightLight(param1:Event) : void
      {
         showTaskEffect(false);
      }
      
      private function __switchClickEnabled(param1:RoomEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _playerItems.length)
         {
            _loc2_ = _playerItems[_loc3_] as RoomPlayerItem;
            _loc2_.switchInEnabled = param1.params[0] == 1;
            _loc3_++;
         }
      }
      
      private function __loadWeakGuild(param1:Event) : void
      {
         removeEventListener("addedToStage",__loadWeakGuild);
      }
      
      protected function __inviteClick(param1:MouseEvent) : void
      {
         if(_inviteFrame != null)
         {
            SoundManager.instance.play("008");
            __onInviteComplete(null);
         }
         else
         {
            if(RoomManager.Instance.current.placeCount < 1)
            {
               if(RoomManager.Instance.current.players.length > 1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.roomlist.RoomListIIBGView.room"));
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView2.noplacetoinvite"));
               }
               return;
            }
            startInvite();
         }
      }
      
      protected function startInvite() : void
      {
         if(!_startInvite && _inviteFrame == null)
         {
            _startInvite = true;
            loadInviteRes();
         }
      }
      
      private function loadInviteRes() : void
      {
         AssetModuleLoader.addModelLoader("ddtinvite",6);
         if(RoomManager.Instance.current.type == 58)
         {
            AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamMemeberLoader(),true);
         }
         AssetModuleLoader.startLoader(__onInviteResComplete);
      }
      
      private function __onInviteResComplete() : void
      {
         if(_startInvite && _inviteFrame == null)
         {
            _inviteFrame = ComponentFactory.Instance.creatComponentByStylename("asset.ddtInviteFrame");
            LayerManager.Instance.addToLayer(_inviteFrame,3,true);
            _inviteFrame.addEventListener("complete",__onInviteComplete);
            _startInvite = false;
         }
      }
      
      private function __onInviteComplete(param1:Event) : void
      {
         _inviteFrame.removeEventListener("complete",__onInviteComplete);
         ObjectUtils.disposeObject(_inviteFrame);
         _inviteFrame = null;
      }
      
      private function __onInviteResError(param1:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onInviteResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onInviteResError);
      }
      
      protected function removeEvents() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _info.removeEventListener("roomplaceChanged",__updatePlayerItems);
         _info.removeEventListener("playerStateChanged",__updateState);
         _info.removeEventListener("addPlayer",__addPlayer);
         _info.removeEventListener("removePlayer",__removePlayer);
         _info.removeEventListener("startedChanged",__startHandler);
         _startBtn.removeEventListener("click",__startClick);
         _cancelBtn.removeEventListener("click",__cancelClick);
         _hostTimer.removeEventListener("timer",__onHostTimer);
         _normalTimer.removeEventListener("timer",__onTimerII);
         _prepareBtn.removeEventListener("click",__prepareClick);
         removeEventListener("addedToStage",__loadWeakGuild);
         if(isViewerRoom)
         {
            _loc2_ = 0;
            while(_loc2_ < 2)
            {
               if(_viewerItems && _viewerItems[_loc2_])
               {
                  _loc1_ = _viewerItems[_loc2_];
                  _viewerItems[_loc2_].removeEventListener("viewerItemInfoSet",__switchClickEnabled);
               }
               _loc2_++;
            }
         }
         if(_info.type != 120)
         {
            if(_emailBtn)
            {
               _emailBtn.removeEventListener("click",__onMailClick);
            }
            if(_taskIconBtn)
            {
               _taskIconBtn.removeEventListener("click",__onTaskClick);
            }
         }
         MailManager.Instance.Model.removeEventListener("initEmail",__updateEmail);
         MailManager.Instance.Model.removeEventListener("cancelemailshine",__onSetEmailShine);
         TaskManager.instance.removeEventListener("showTaskHightLight",__showTaskHightLight);
         TaskManager.instance.removeEventListener("hideTaskHightLight",__hideTaskHightLight);
         SocketManager.Instance.removeEventListener(PkgEvent.format(390,25),__changeRoomborden);
         SocketManager.Instance.removeEventListener(PkgEvent.format(390,21),__useRoomborden);
      }
      
      protected function updateTimer() : void
      {
         if(_info.selfRoomPlayer.isHost && _startBtn.buttonMode == !_info.isAllReady())
         {
            resetHostTimer();
         }
         if(!_info.selfRoomPlayer.isHost && _prepareBtn.visible == _info.selfRoomPlayer.isReady)
         {
            resetNormalTimer();
         }
      }
      
      protected function __updatePlayerItems(param1:RoomEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _playerItems.length)
         {
            _loc2_ = _playerItems[_loc3_] as RoomPlayerItem;
            _loc2_.opened = _info.placesState[_loc3_] != 0;
            _loc3_++;
         }
         if(isViewerRoom)
         {
            if(_viewerItems)
            {
               if(_viewerItems[0])
               {
                  _viewerItems[0].opened = _info.placesState[8] != 0;
               }
               if(_viewerItems[1])
               {
                  _viewerItems[1].opened = _info.placesState[9] != 0;
               }
            }
         }
         initPlayerItems();
         updateButtons();
      }
      
      protected function __updateState(param1:RoomEvent) : void
      {
         updateButtons();
         if(_info.selfRoomPlayer.isHost)
         {
            startHostTimer();
            stopNormalTimer();
            if(!_info.isAllReady() && _info.started)
            {
               GameInSocketOut.sendCancelWait();
               _info.started = false;
               SoundManager.instance.stop("007");
            }
            if(_info.started)
            {
               MainToolBar.Instance.setRoomStartState2(true);
            }
            else
            {
               MainToolBar.Instance.enableAll();
            }
         }
         else
         {
            stopHostTimer();
            startNormalTimer();
            if(_info.selfRoomPlayer.isReady)
            {
               MainToolBar.Instance.setRoomStartState();
            }
            else if(!_info.selfRoomPlayer.isViewer)
            {
               MainToolBar.Instance.enableAll();
            }
         }
      }
      
      protected function __addPlayer(param1:RoomEvent) : void
      {
         var _loc2_:RoomPlayer = param1.params[0] as RoomPlayer;
         if(_loc2_.isFirstIn)
         {
            SoundManager.instance.play("158");
         }
         if(_loc2_.place >= 8)
         {
            _viewerItems[_loc2_.place - 8].info = _loc2_;
         }
         else
         {
            _playerItems[_loc2_.place].info = _loc2_;
         }
         updateButtons();
      }
      
      protected function __removePlayer(param1:RoomEvent) : void
      {
         var _loc2_:RoomPlayer = param1.params[0] as RoomPlayer;
         if(_loc2_.place >= 8)
         {
            _viewerItems[_loc2_.place - 8].info = null;
         }
         else
         {
            _playerItems[_loc2_.place].info = null;
         }
         _loc2_.dispose();
         updateButtons();
      }
      
      protected function __startClick(param1:MouseEvent) : void
      {
         if(!_info.isAllReady())
         {
            return;
         }
         SoundManager.instance.play("008");
         CheckWeaponManager.instance.setFunction(this,__startClick,[param1]);
         if(checkCanStartGame())
         {
            startGame();
            _info.started = true;
         }
      }
      
      protected function __prepareClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_info.type != 123)
         {
            CheckWeaponManager.instance.setFunction(this,__prepareClick,[param1]);
            if(CheckWeaponManager.instance.isNoWeapon())
            {
               CheckWeaponManager.instance.showAlert();
               return;
            }
         }
         prepareGame();
      }
      
      protected function prepareGame() : void
      {
         GameInSocketOut.sendPlayerState(1);
      }
      
      protected function startGame() : void
      {
         _startInvite = false;
         GameInSocketOut.sendGameStart();
      }
      
      protected function __cancelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_info.selfRoomPlayer.isHost)
         {
            GameInSocketOut.sendCancelWait();
         }
         else if(_info.started)
         {
            GameInSocketOut.sendCancelWait();
         }
         else
         {
            GameInSocketOut.sendPlayerState(0);
         }
      }
      
      protected function checkCanStartGame() : Boolean
      {
         var _loc1_:Boolean = true;
         if(_info.selfRoomPlayer.isViewer || _info.type == 123)
         {
            return _loc1_;
         }
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            _loc1_ = false;
            CheckWeaponManager.instance.showAlert();
         }
         return _loc1_;
      }
      
      protected function academyDungeonAllow() : Boolean
      {
         var _loc1_:int = 0;
         if(RoomManager.Instance.current.players.length < 2)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.room.roomStart.academy.warning4"));
            return false;
         }
         var _loc5_:int = 0;
         var _loc4_:* = RoomManager.Instance.current.players;
         for each(var _loc3_ in RoomManager.Instance.current.players)
         {
            if(_loc3_.playerInfo.apprenticeshipState == 0 && !_loc3_.isViewer)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.room.roomStart.academy.warning1"));
               return false;
            }
            if((_loc3_.playerInfo.apprenticeshipState == 2 || _loc3_.playerInfo.apprenticeshipState == 3 || _loc3_.playerInfo.apprenticeshipState == 1) && !_loc3_.isViewer)
            {
               _loc1_++;
            }
         }
         if(_loc1_ < 2)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.room.roomStart.academy.warning4"));
            return false;
         }
         _loc1_ = 0;
         var _loc7_:int = 0;
         var _loc6_:* = RoomManager.Instance.current.players;
         for each(var _loc2_ in RoomManager.Instance.current.players)
         {
            if((_loc2_.playerInfo.apprenticeshipState == 2 || _loc2_.playerInfo.apprenticeshipState == 3) && !_loc2_.isViewer)
            {
               _loc1_++;
               if(_loc1_ > 1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.room.roomStart.academy.warning3"));
                  return false;
               }
            }
         }
         if(_loc1_ == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.room.roomStart.academy.warning2"));
            return false;
         }
         return true;
      }
      
      protected function activityDungeonAllow() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = RoomManager.Instance.current.players;
         for each(var _loc1_ in RoomManager.Instance.current.players)
         {
            if(_loc1_.playerInfo.Grade < 25)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.ActivityDungeon.roomPromptInfo",_loc1_.playerInfo.NickName));
               return false;
            }
            if(_loc1_.playerInfo.activityTanabataNum <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.ActivityDungeon.roomPromptNum",_loc1_.playerInfo.NickName));
               return false;
            }
         }
         return true;
      }
      
      protected function __startHandler(param1:RoomEvent) : void
      {
         updateButtons();
         if(_info.started)
         {
            stopHostTimer();
            MainToolBar.Instance.setRoomStartState();
            SoundManager.instance.stop("007");
         }
         else
         {
            if(_info.selfRoomPlayer.isHost && _info.isAllReady())
            {
               startHostTimer();
            }
            if(_info.selfRoomPlayer.isHost)
            {
               MainToolBar.Instance.enableAll();
            }
            else
            {
               if(_info.selfRoomPlayer.isViewer)
               {
                  MainToolBar.Instance.setRoomStartState();
                  MainToolBar.Instance.setReturnEnable(true);
                  return;
               }
               if(_info.selfRoomPlayer.isReady)
               {
                  MainToolBar.Instance.setRoomStartState();
               }
               else
               {
                  MainToolBar.Instance.enableAll();
               }
            }
         }
      }
      
      protected function startHostTimer() : void
      {
         if(!_hostTimer.running)
         {
            _hostTimer.start();
            _hostTimer.addEventListener("timer",__onHostTimer);
         }
      }
      
      protected function startNormalTimer() : void
      {
         if(!_normalTimer.running)
         {
            _normalTimer.start();
            _normalTimer.addEventListener("timer",__onTimerII);
         }
      }
      
      protected function stopHostTimer() : void
      {
         _hostTimer.reset();
         _hostTimer.removeEventListener("timer",__onHostTimer);
         SoundManager.instance.stop("007");
      }
      
      protected function stopNormalTimer() : void
      {
         _normalTimer.reset();
         _normalTimer.removeEventListener("timer",__onTimerII);
         SoundManager.instance.stop("007");
      }
      
      protected function resetHostTimer() : void
      {
         stopHostTimer();
         startHostTimer();
         SoundManager.instance.stop("007");
      }
      
      protected function resetNormalTimer() : void
      {
         stopNormalTimer();
         startNormalTimer();
         SoundManager.instance.stop("007");
      }
      
      protected function __onTimerII(param1:TimerEvent) : void
      {
         if(!_info.selfRoomPlayer.isHost && !_info.selfRoomPlayer.isViewer)
         {
            if(_normalTimer.currentCount >= 30 && !_info.selfRoomPlayer.isReady)
            {
               if(!TaskManager.instance.isShow)
               {
                  if(!SoundManager.instance.isPlaying("007"))
                  {
                     SoundManager.instance.play("007",false,true);
                  }
               }
               else
               {
                  SoundManager.instance.stop("007");
               }
            }
         }
      }
      
      protected function __onHostTimer(param1:TimerEvent) : void
      {
         if(_info.selfRoomPlayer.isHost && !_info.isOpenBoss && !_info.mapId == 12016 && !_info.mapId == 70020)
         {
            if(_hostTimer.currentCount >= 1200 && _info.players.length - _info.currentViewerCnt > 1)
            {
               kickHandler();
            }
            else if(_hostTimer.currentCount >= 300 && _info.players.length - _info.currentViewerCnt == 1)
            {
               kickHandler();
            }
            else if(_hostTimer.currentCount >= 60 && _info.players.length - _info.currentViewerCnt > 1 && _info.currentViewerCnt == 0 && _info.isAllReady())
            {
               kickHandler();
            }
            else if(_hostTimer.currentCount == 1200 - 30 && _info.players.length - _info.currentViewerCnt > 1 || _hostTimer.currentCount == 300 - 30 && _info.players.length - _info.currentViewerCnt == 1 || _hostTimer.currentCount == 60 - 30 && _info.players.length - _info.currentViewerCnt > 1 && _info.currentViewerCnt == 0 && _info.isAllReady())
            {
               ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("BaseRoomView.getout.Timeout"));
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("BaseRoomView.getout.Timeout"));
            }
            else if(_hostTimer.currentCount >= 30 && _info.isAllReady())
            {
               if(!TaskManager.instance.isShow)
               {
                  if(!SoundManager.instance.isPlaying("007"))
                  {
                     SoundManager.instance.play("007",false,true);
                  }
               }
               else
               {
                  SoundManager.instance.stop("007");
               }
            }
         }
      }
      
      protected function kickHandler() : void
      {
         ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("tank.room.RoomIIView2.kick"));
         if(_info.type == 4 || _info.type == 11 || _info.type == 23 || _info.type == 21 || _info.type == 123)
         {
            StateManager.setState("dungeon");
         }
         else
         {
            StateManager.setState("roomlist");
         }
         PlayerManager.Instance.Self.unlockAllBag();
      }
      
      public function dispose() : void
      {
         RoomManager.Instance.isPrepare = false;
         NewHandContainer.Instance.clearArrowByID(16);
         removeEvents();
         if(_roomPropView)
         {
            _roomPropView.dispose();
         }
         _roomPropView = null;
         if(_btnBg)
         {
            ObjectUtils.disposeObject(_btnBg);
            _btnBg = null;
         }
         if(_startBtn.parent)
         {
            _startBtn.parent.removeChild(_startBtn);
         }
         _startBtn.stop();
         _startBtn = null;
         if(_prepareBtn && _prepareBtn.parent)
         {
            _prepareBtn.parent.removeChild(_prepareBtn);
            _prepareBtn.stop();
         }
         if(_cancelBtn)
         {
            _cancelBtn.dispose();
         }
         _cancelBtn = null;
         if(_inviteBtn)
         {
            _inviteBtn.dispose();
         }
         _inviteBtn = null;
         if(_inviteFrame)
         {
            _inviteFrame.dispose();
         }
         _inviteFrame = null;
         if(_viewerItems)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _viewerItems;
            for each(var _loc1_ in _viewerItems)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
         _viewerItems = null;
         var _loc6_:int = 0;
         var _loc5_:* = _playerItems;
         for each(var _loc2_ in _playerItems)
         {
            _loc2_.dispose();
         }
         _playerItems = null;
         if(_hostTimer)
         {
            _hostTimer.stop();
         }
         _hostTimer = null;
         if(_normalTimer)
         {
            _normalTimer.stop();
         }
         _normalTimer = null;
         _info = null;
         SoundManager.instance.stop("007");
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
