package room.view.roomView
{
   import LimitAward.LimitAwardButton;
   import bagAndInfo.energyData.EnergyData;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.bossbox.SmallBoxButton;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import quest.TaskManager;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.PVEBattleRoomRightPropView;
   import room.view.RoomNotEnoughEnergyAlert;
   import room.view.RoomPlayerItem;
   import room.view.bigMapInfoPanel.MissionRoomBigMapInfoPanel;
   import room.view.smallMapInfoPanel.MissionRoomSmallMapInfoPanel;
   
   public class MissionRoomView extends BaseRoomView
   {
      
      private static const BATTLE:int = 1;
      
      private static const OTHER:int = 2;
       
      
      private var _bigMapInfoPanel:MissionRoomBigMapInfoPanel;
      
      private var _smallMapInfoPanel:MissionRoomSmallMapInfoPanel;
      
      private var _rightBg:MovieClip;
      
      private var _itemListBg:MovieClip;
      
      private var _playerItemContainer:SimpleTileList;
      
      private var _boxButton:SmallBoxButton;
      
      private var _limitAwardButton:LimitAwardButton;
      
      private var _btnSwitchTeam:BaseButton;
      
      private var _clickDate:Number = 0;
      
      private var _curSelectType:int;
      
      public function MissionRoomView(param1:RoomInfo)
      {
         super(param1);
         _info.started = false;
      }
      
      override protected function initView() : void
      {
         _rightBg = ClassUtils.CreatInstance("asset.background.room.right") as MovieClip;
         PositionUtils.setPos(_rightBg,"asset.ddtmatchroom.bgPos");
         addChild(_rightBg);
         initPanel();
         _itemListBg = ClassUtils.CreatInstance("asset.ddtroom.playerItemlist.bg") as MovieClip;
         PositionUtils.setPos(_itemListBg,"asset.ddtroom.playerItemlist.bgPos");
         addChild(_itemListBg);
         _btnSwitchTeam = ComponentFactory.Instance.creatComponentByStylename("asset.ddtChallengeRoom.switchTeamBtn");
         addChild(_btnSwitchTeam);
         _btnSwitchTeam.enable = false;
         if(BossBoxManager.instance.isShowBoxButton())
         {
            _boxButton = new SmallBoxButton(1);
            addChild(_boxButton);
         }
         super.initView();
         PVEBattleRoomRightPropView;
         initMapView();
      }
      
      private function initMapView() : void
      {
         __onMapChangedHandler(null);
      }
      
      private function __onMapChangedHandler(param1:Event) : void
      {
         var _loc2_:int = -1;
         if(RoomManager.Instance.current.type == 123)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = 2;
         }
         __switchProViewHandler(_loc2_);
      }
      
      private function clearRoomProView() : void
      {
         ObjectUtils.disposeObject(_roomPropView);
         _roomPropView = null;
      }
      
      private function createPVEBattleProView() : void
      {
         _roomPropView = ComponentFactory.Instance.creatCustomObject("ddtroom.roomPropView.pveBattleProView");
         PositionUtils.setPos(_viewerItems[0],"asset.ddtchallengeroom.testModeViewerItemPos_0");
         PositionUtils.setPos(_viewerItems[1],"asset.ddtchallengeroom.testModeViewerItemPos_1");
      }
      
      private function createRoomProView() : void
      {
         _roomPropView = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.roomPropView");
         PositionUtils.setPos(_viewerItems[0],"asset.ddtchallengeroom.ViewerItemPos_0");
         PositionUtils.setPos(_viewerItems[1],"asset.ddtchallengeroom.ViewerItemPos_1");
      }
      
      private function __switchProViewHandler(param1:int) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = param1 == _curSelectType?false:true;
         if(!_loc2_)
         {
            return;
         }
         _curSelectType = param1;
         if(_curSelectType == 1 && !(_roomPropView is PVEBattleRoomRightPropView))
         {
            clearRoomProView();
            createPVEBattleProView();
            GameInSocketOut.sendGetBattleSkillInfo();
         }
         else if(_curSelectType == 2 && _roomPropView is PVEBattleRoomRightPropView)
         {
            clearRoomProView();
            createRoomProView();
         }
         addChild(_roomPropView);
         if(_viewerItems[0])
         {
            setChildIndex(_roomPropView,getChildIndex(_viewerItems[0]) - 1);
         }
      }
      
      override protected function initEvents() : void
      {
         super.initEvents();
         SocketManager.Instance.addEventListener("gameEnergyNotEnough",notEnoughEnergyBuy);
      }
      
      override protected function checkCanStartGame() : Boolean
      {
         var _loc3_:DungeonInfo = MapManager.getDungeonInfo(_info.mapId);
         if(super.checkCanStartGame())
         {
            if(_info.mapId == 12)
            {
               var _loc5_:int = 0;
               var _loc4_:* = _info.players;
               for each(var _loc1_ in _info.players)
               {
                  if(_loc1_.playerInfo.Grade < 18)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView2.playerGradeNotEnough",18));
                     return false;
                  }
               }
            }
            else if(_info.hardLevel == 4)
            {
               var _loc7_:int = 0;
               var _loc6_:* = _info.players;
               for each(var _loc2_ in _info.players)
               {
                  if(_loc2_.playerInfo.Grade < 45)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView2.playerGradeNotEnough",45));
                     return false;
                  }
               }
            }
            else if(!PlayerManager.Instance.Self.isDungeonGuideFinish(130) && _info.mapId == 2)
            {
               NoviceDataManager.instance.saveNoviceData(1080,PathManager.userName(),PathManager.solveRequestPath());
            }
            if(_loc3_.Type == 6 && !super.academyDungeonAllow())
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         SocketManager.Instance.removeEventListener("gameEnergyNotEnough",notEnoughEnergyBuy);
      }
      
      protected function initPanel() : void
      {
         _bigMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddt.room.missionBigMapInfoPanel");
         addChild(_bigMapInfoPanel);
         _smallMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddt.room.missionSmallMapInfoPanel");
         _smallMapInfoPanel.info = _info;
         addChild(_smallMapInfoPanel);
      }
      
      override protected function initTileList() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         super.initTileList();
         _playerItemContainer = new SimpleTileList(2);
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.matchRoom.listSpace");
         _playerItemContainer.hSpace = _loc3_.x;
         _playerItemContainer.vSpace = _loc3_.y;
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerListPos");
         _playerItemContainer.x = _rightBg.x + _loc2_.x;
         _playerItemContainer.y = _rightBg.y + _loc2_.y;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc1_ = new RoomPlayerItem(_loc4_);
            _playerItemContainer.addChild(_loc1_);
            _playerItems.push(_loc1_);
            _loc4_++;
         }
         addChild(_playerItemContainer);
         PositionUtils.setPos(_viewerItems[0],"asset.ddtchallengeroom.ViewerItemPos_0");
         PositionUtils.setPos(_viewerItems[1],"asset.ddtchallengeroom.ViewerItemPos_1");
         addChild(_viewerItems[0]);
         addChild(_viewerItems[1]);
      }
      
      override protected function __onHostTimer(param1:TimerEvent) : void
      {
         if(_info.selfRoomPlayer.isHost)
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
      
      override protected function kickHandler() : void
      {
      }
      
      override protected function __cancelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!RoomManager.Instance.current.selfRoomPlayer.isHost)
         {
            GameInSocketOut.sendGameMissionPrepare(_info.selfRoomPlayer.place,false);
            GameInSocketOut.sendPlayerState(0);
         }
      }
      
      override protected function startGame() : void
      {
         if(new Date().time - _clickDate > 1000)
         {
            _clickDate = new Date().time;
            GameInSocketOut.sendGameMissionStart(true);
         }
      }
      
      override protected function __startClick(param1:MouseEvent) : void
      {
         if(!_info.isAllReady())
         {
            return;
         }
         SoundManager.instance.play("008");
         CheckWeaponManager.instance.setFunction(this,__startClick,[param1]);
         if(checkCanStartGame())
         {
            checkSendCheckEnergy();
         }
      }
      
      override protected function prepareGame() : void
      {
         checkSendCheckEnergy();
      }
      
      private function checkSendCheckEnergy() : void
      {
         if(RoomManager.Instance.isNotAlertEnergyNotEnough && isPreOrGame())
         {
            doSendStartOrPreGame();
         }
         else
         {
            GameInSocketOut.sendStartOrPreCheckEnergy();
         }
      }
      
      private function doStart() : void
      {
         startGame();
         _info.started = true;
      }
      
      private function doPrepareGame() : void
      {
         GameInSocketOut.sendGameMissionPrepare(_info.selfRoomPlayer.place,true);
         GameInSocketOut.sendPlayerState(1);
      }
      
      private function doSendStartOrPreGame() : void
      {
         if(_info.selfRoomPlayer.isHost)
         {
            doStart();
         }
         else
         {
            doPrepareGame();
         }
      }
      
      protected function notEnoughEnergyBuy(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(!_loc2_)
         {
            doSendStartOrPreGame();
         }
         else if(RoomManager.Instance.isNotAlertEnergyNotEnough)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.energyNotEnoughMsg"));
         }
         else
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.view.energy.takeCardOutBuyPromptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"RoomNotEnoughEnergyAlert",60,false,1);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",__alertBuyEnergy);
         }
      }
      
      protected function __alertBuyEnergy(param1:FrameEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc2_:RoomNotEnoughEnergyAlert = param1.currentTarget as RoomNotEnoughEnergyAlert;
         _loc2_.removeEventListener("response",__alertBuyEnergy);
         RoomManager.Instance.isNotAlertEnergyNotEnough = _loc2_.isNoPrompt;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               ObjectUtils.disposeObject(_loc2_);
               return;
            }
            _loc4_ = PlayerManager.Instance.energyData[PlayerManager.Instance.Self.buyEnergyCount + 1];
            if(!_loc4_)
            {
               ObjectUtils.disposeObject(_loc2_);
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.energy.cannotbuyEnergy"));
               return;
            }
            if(_loc2_.isBand && PlayerManager.Instance.Self.BandMoney < _loc4_.Money)
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.energy.changeMoneyCostTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc3_.moveEnable = false;
               _loc3_.addEventListener("response",__changeMoneyBuyConfirm,false,0,true);
            }
            else if(!_loc2_.isBand && PlayerManager.Instance.Self.Money < _loc4_.Money)
            {
               LeavePageManager.showFillFrame();
            }
            else
            {
               SocketManager.Instance.out.sendBuyEnergy(_loc2_.isBand);
            }
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            if(isPreOrGame())
            {
               doSendStartOrPreGame();
            }
         }
         ObjectUtils.disposeObject(_loc2_);
      }
      
      protected function isPreOrGame() : Boolean
      {
         if(MapManager.Instance.activeDoubleIds.indexOf(_info.mapId) != -1 || MapManager.Instance.singleDoubleIds.indexOf(_info.mapId) != -1 || _info.hardLevel == 4)
         {
            return false;
         }
         return true;
      }
      
      protected function __changeMoneyBuyConfirm(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__changeMoneyBuyConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = PlayerManager.Instance.energyData[PlayerManager.Instance.Self.buyEnergyCount + 1];
            if(PlayerManager.Instance.Self.Money < _loc2_.Money)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendBuyEnergy(false);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bigMapInfoPanel)
         {
            ObjectUtils.disposeObject(_bigMapInfoPanel);
         }
         _bigMapInfoPanel = null;
         if(_smallMapInfoPanel)
         {
            ObjectUtils.disposeObject(_smallMapInfoPanel);
         }
         _smallMapInfoPanel = null;
         if(_rightBg)
         {
            ObjectUtils.disposeObject(_rightBg);
         }
         _rightBg = null;
         if(_itemListBg)
         {
            ObjectUtils.disposeObject(_itemListBg);
         }
         _itemListBg = null;
         if(_playerItemContainer)
         {
            ObjectUtils.disposeObject(_playerItemContainer);
         }
         _playerItemContainer = null;
         if(_limitAwardButton)
         {
            ObjectUtils.disposeObject(_limitAwardButton);
         }
         _limitAwardButton = null;
         if(_btnSwitchTeam)
         {
            ObjectUtils.disposeObject(_btnSwitchTeam);
         }
         _btnSwitchTeam = null;
         if(_boxButton)
         {
            BossBoxManager.instance.deleteBoxButton();
            ObjectUtils.disposeObject(_boxButton);
         }
         _boxButton = null;
      }
   }
}
