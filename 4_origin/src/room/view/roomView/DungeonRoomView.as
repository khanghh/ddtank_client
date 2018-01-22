package room.view.roomView
{
   import LimitAward.LimitAwardButton;
   import bagAndInfo.energyData.EnergyData;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.map.DungeonInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.RoomEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MapManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.bossbox.SmallBoxButton;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.PVEBattleRoomRightPropView;
   import room.view.RoomDupSimpleTipFram;
   import room.view.RoomNotEnoughEnergyAlert;
   import room.view.RoomPlayerItem;
   import room.view.bigMapInfoPanel.DungeonBigMapInfoPanel;
   import room.view.chooseMap.DungeonChooseMapFrame;
   import room.view.smallMapInfoPanel.DungeonSmallMapInfoPanel;
   import trainer.controller.WeakGuildManager;
   import trainer.view.NewHandContainer;
   import trainer.view.VaneTipView;
   
   public class DungeonRoomView extends BaseRoomView
   {
      
      private static const TESTMAP:int = 64;
      
      private static const BATTLE:int = 1;
      
      private static const OTHER:int = 2;
       
      
      private var _bigMapInfoPanel:DungeonBigMapInfoPanel;
      
      private var _smallMapInfoPanel:DungeonSmallMapInfoPanel;
      
      private var _rightBg:MovieClip;
      
      private var _itemListBg:MovieClip;
      
      private var _playerItemContainer:SimpleTileList;
      
      private var _btnSwitchTeam:BaseButton;
      
      private var _boxButton:SmallBoxButton;
      
      private var _limitAwardButton:LimitAwardButton;
      
      private var _curSelectType:int;
      
      private var _singleAlsert:BaseAlerFrame;
      
      public function DungeonRoomView(param1:RoomInfo)
      {
         super(param1);
      }
      
      override protected function initView() : void
      {
         _rightBg = ClassUtils.CreatInstance("asset.background.room.right") as MovieClip;
         PositionUtils.setPos(_rightBg,"asset.ddtmatchroom.bgPos");
         addChild(_rightBg);
         _bigMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddt.dungeonRoom.BigMapInfoPanel");
         addChild(_bigMapInfoPanel);
         _smallMapInfoPanel = ComponentFactory.Instance.creatCustomObject("ddt.dungeonRoom.SmallMapInfoPanel");
         _smallMapInfoPanel.info = _info;
         addChild(_smallMapInfoPanel);
         _itemListBg = ClassUtils.CreatInstance("asset.ddtroom.playerItemlist.bg") as MovieClip;
         PositionUtils.setPos(_itemListBg,"asset.ddtroom.playerItemlist.bgPos");
         addChild(_itemListBg);
         _btnSwitchTeam = ComponentFactory.Instance.creatComponentByStylename("asset.ddtChallengeRoom.switchTeamBtn");
         addChild(_btnSwitchTeam);
         _btnSwitchTeam.enable = false;
         super.initView();
         if(BossBoxManager.instance.isShowBoxButton())
         {
            _boxButton = new SmallBoxButton(2);
            addChild(_boxButton);
         }
         PVEBattleRoomRightPropView;
         initMapView();
      }
      
      override protected function initEvents() : void
      {
         super.initEvents();
         addEventListener("addedToStage",__loadWeakGuild);
         if(_info)
         {
            _info.addEventListener("change",__onMapChangedHandler);
         }
         SocketManager.Instance.addEventListener("gameEnergyNotEnough",notEnoughEnergyBuy);
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
         if(_viewerItems && _viewerItems.length > 0 && _viewerItems[0])
         {
            setChildIndex(_roomPropView,getChildIndex(_viewerItems[0]) - 1);
         }
      }
      
      override protected function __prepareClick(param1:MouseEvent) : void
      {
         super.__prepareClick(param1);
         if(PlayerManager.Instance.Self.dungeonFlag[_info.mapId] && PlayerManager.Instance.Self.dungeonFlag[_info.mapId] == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.reduceGains"));
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("tank.room.RoomIIController.reduceGains"));
         }
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         removeEventListener("addedToStage",__loadWeakGuild);
         if(_info)
         {
            _info.removeEventListener("change",__onMapChangedHandler);
         }
         SocketManager.Instance.removeEventListener("gameEnergyNotEnough",notEnoughEnergyBuy);
      }
      
      private function __loadWeakGuild(param1:Event) : void
      {
         var _loc2_:* = null;
         removeEventListener("addedToStage",__loadWeakGuild);
         if(!WeakGuildManager.Instance.switchUserGuide)
         {
            return;
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(39) && PlayerManager.Instance.Self.IsWeakGuildFinish(9))
         {
            _loc2_ = ComponentFactory.Instance.creat("trainer.vane.mainFrame");
            _loc2_.show();
         }
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
         if(isViewerRoom)
         {
            PositionUtils.setPos(_viewerItems[0],"asset.ddtchallengeroom.ViewerItemPos_0");
            PositionUtils.setPos(_viewerItems[1],"asset.ddtchallengeroom.ViewerItemPos_1");
            addChild(_viewerItems[0]);
            addChild(_viewerItems[1]);
         }
      }
      
      override protected function checkCanStartGame() : Boolean
      {
         var _loc6_:Number = NaN;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc4_:DungeonInfo = MapManager.getDungeonInfo(_info.mapId);
         if(super.checkCanStartGame())
         {
            if(_info.type == 10 || _info.type == 28)
            {
               return true;
            }
            if(_info.mapId == 12)
            {
               var _loc8_:int = 0;
               var _loc7_:* = _info.players;
               for each(var _loc1_ in _info.players)
               {
                  if(_loc1_.playerInfo.Grade < 18)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView2.playerGradeNotEnough",18));
                     return false;
                  }
               }
            }
            if(_info.hardLevel == 4)
            {
               var _loc10_:int = 0;
               var _loc9_:* = _info.players;
               for each(var _loc3_ in _info.players)
               {
                  if(_loc3_.playerInfo.Grade < 45)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView2.playerGradeNotEnough",45));
                     return false;
                  }
               }
            }
            _loc6_ = TimeManager.Instance.Now().time;
            if(MapManager.Instance.activeDoubleIds.indexOf(_info.mapId) != -1)
            {
               _loc5_ = MapManager.Instance.activeDoubleDic[_info.mapId];
               if(_loc5_ == null || _loc6_ < _loc5_.startDate.time || _loc6_ >= _loc5_.endDate.time)
               {
                  showDungeonChooseMapFrame();
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.dungeonRoomView.dungeonEndMsg"));
                  return false;
               }
            }
            else if(MapManager.Instance.singleDoubleIds.indexOf(_info.mapId) != -1)
            {
               _loc2_ = MapManager.Instance.singleDoubleDic[_info.mapId];
               if(_loc2_ == null || _loc6_ < _loc2_.startDate.time || _loc6_ >= _loc2_.endDate.time)
               {
                  showDungeonChooseMapFrame();
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.dungeonRoomView.dungeonEndMsg"));
                  return false;
               }
            }
            if(_info.mapId == 0 || _info.mapId == 10000)
            {
               showDungeonChooseMapFrame();
               return false;
            }
            if(MapManager.Instance.singleDoubleIds.indexOf(_info.mapId) == -1 && !RoomManager.Instance.showSingleAlert && RoomManager.Instance.current.players.length - RoomManager.Instance.current.currentViewerCnt == 1 && (_loc4_.Type != 6 || _info.mapId == 1405))
            {
               _singleAlsert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.clewContent"),"",LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _singleAlsert.moveEnable = false;
               _singleAlsert.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
               _singleAlsert.addEventListener("response",__onResponse);
               _singleAlsert.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
               _singleAlsert.selectedCheckButton.x = 55;
               if(!PlayerManager.Instance.Self.isDungeonGuideFinish(123))
               {
                  NewHandContainer.Instance.showArrow(130,0,"guide.dungeon.step7ArrowPos","","",LayerManager.Instance.getLayerByType(0));
               }
               return false;
            }
            if(_loc4_.Type == 6 && !super.academyDungeonAllow())
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function showDungeonChooseMapFrame() : void
      {
         var _loc1_:DungeonChooseMapFrame = new DungeonChooseMapFrame();
         _loc1_.show();
         dispatchEvent(new RoomEvent("openDungeonChooser"));
      }
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            trace(RoomManager.Instance.current.type);
            RoomManager.Instance.showSingleAlert = _singleAlsert.selectedCheckButton.selected;
            if(RoomManager.Instance.current.type == 21 && PlayerManager.Instance.Self.activityTanabataNum < 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.ActivityDungeon.roomPromptDes"));
               return;
            }
            checkSendCheckEnergy();
         }
         else if(!PlayerManager.Instance.Self.isDungeonGuideFinish(123))
         {
            NewHandContainer.Instance.showArrow(130,-45,"trainer.startGameArrowPos","asset.trainer.startGameTipAsset","trainer.startGameTipPos",LayerManager.Instance.getLayerByType(2));
         }
         _singleAlsert.removeEventListener("response",__onResponse);
         _singleAlsert.selectedCheckButton.removeEventListener("click",__onSelectCheckClick);
         _singleAlsert.dispose();
         _singleAlsert = null;
      }
      
      override protected function kickHandler() : void
      {
         GameInSocketOut.sendGameRoomSetUp(10000,4,false,_info.roomPass,_info.roomName,1,0,0,false,0);
         super.kickHandler();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_itemListBg)
         {
            ObjectUtils.disposeObject(_itemListBg);
            _itemListBg = null;
         }
         if(_boxButton)
         {
            BossBoxManager.instance.deleteBoxButton();
            ObjectUtils.disposeObject(_boxButton);
         }
         if(_limitAwardButton)
         {
            ObjectUtils.disposeObject(_limitAwardButton);
         }
         _limitAwardButton = null;
         if(_singleAlsert)
         {
            _singleAlsert.removeEventListener("response",__onResponse);
            _singleAlsert.dispose();
            _singleAlsert = null;
         }
         _boxButton = null;
         _bigMapInfoPanel.dispose();
         _bigMapInfoPanel = null;
         _smallMapInfoPanel.dispose();
         _smallMapInfoPanel = null;
         removeChild(_rightBg);
         _rightBg = null;
         _playerItemContainer.dispose();
         _playerItemContainer = null;
         _btnSwitchTeam.dispose();
         _btnSwitchTeam = null;
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
         if(!PlayerManager.Instance.Self.isDungeonGuideFinish(123))
         {
            NewHandContainer.Instance.clearArrowByID(130);
         }
      }
      
      private function doPrepareGame() : void
      {
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
      
      private function _showBoGuTip() : void
      {
         var _loc1_:* = null;
         if(PlayerManager.Instance.Self._isDupSimpleTip)
         {
            PlayerManager.Instance.Self._isDupSimpleTip = false;
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("room.RoomDupSimpleTipFram");
            _loc1_.show();
         }
      }
   }
}
