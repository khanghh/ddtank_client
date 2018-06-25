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
      
      public function DungeonRoomView(info:RoomInfo)
      {
         super(info);
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
      
      private function __onMapChangedHandler(evt:Event) : void
      {
         var proType:int = -1;
         if(RoomManager.Instance.current.type == 123)
         {
            proType = 1;
         }
         else
         {
            proType = 2;
         }
         __switchProViewHandler(proType);
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
      
      private function __switchProViewHandler(proType:int) : void
      {
         var isSwitch:Boolean = false;
         isSwitch = proType == _curSelectType?false:true;
         if(!isSwitch)
         {
            return;
         }
         _curSelectType = proType;
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
      
      override protected function __prepareClick(evt:MouseEvent) : void
      {
         super.__prepareClick(evt);
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
      
      private function __loadWeakGuild(evt:Event) : void
      {
         var vane:* = null;
         removeEventListener("addedToStage",__loadWeakGuild);
         if(!WeakGuildManager.Instance.switchUserGuide)
         {
            return;
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(39) && PlayerManager.Instance.Self.IsWeakGuildFinish(9))
         {
            vane = ComponentFactory.Instance.creat("trainer.vane.mainFrame");
            vane.show();
         }
      }
      
      override protected function initTileList() : void
      {
         var i:int = 0;
         var item:* = null;
         super.initTileList();
         _playerItemContainer = new SimpleTileList(2);
         var space:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.matchRoom.listSpace");
         _playerItemContainer.hSpace = space.x;
         _playerItemContainer.vSpace = space.y;
         var p:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.playerListPos");
         _playerItemContainer.x = _rightBg.x + p.x;
         _playerItemContainer.y = _rightBg.y + p.y;
         for(i = 0; i < 4; )
         {
            item = new RoomPlayerItem(i);
            _playerItemContainer.addChild(item);
            _playerItems.push(item);
            i++;
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
         var nowTime:Number = NaN;
         var obj:* = null;
         var obj2:* = null;
         var dungeon:DungeonInfo = MapManager.getDungeonInfo(_info.mapId);
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
               for each(var player in _info.players)
               {
                  if(player.playerInfo.Grade < 18)
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
               for each(var players in _info.players)
               {
                  if(players.playerInfo.Grade < 45)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIView2.playerGradeNotEnough",45));
                     return false;
                  }
               }
            }
            nowTime = TimeManager.Instance.Now().time;
            if(MapManager.Instance.activeDoubleIds.indexOf(_info.mapId) != -1)
            {
               obj = MapManager.Instance.activeDoubleDic[_info.mapId];
               if(obj == null || nowTime < obj.startDate.time || nowTime >= obj.endDate.time)
               {
                  showDungeonChooseMapFrame();
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.dungeonRoomView.dungeonEndMsg"));
                  return false;
               }
            }
            else if(MapManager.Instance.singleDoubleIds.indexOf(_info.mapId) != -1)
            {
               obj2 = MapManager.Instance.singleDoubleDic[_info.mapId];
               if(obj2 == null || nowTime < obj2.startDate.time || nowTime >= obj2.endDate.time)
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
            if(MapManager.Instance.singleDoubleIds.indexOf(_info.mapId) == -1 && !RoomManager.Instance.showSingleAlert && RoomManager.Instance.current.players.length - RoomManager.Instance.current.currentViewerCnt == 1 && (dungeon.Type != 6 || _info.mapId == 1405))
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
            if(dungeon.Type == 6 && !super.academyDungeonAllow())
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function showDungeonChooseMapFrame() : void
      {
         var mapChooser:DungeonChooseMapFrame = new DungeonChooseMapFrame();
         mapChooser.show();
         dispatchEvent(new RoomEvent("openDungeonChooser"));
      }
      
      protected function __onSelectCheckClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         if(evt.responseCode == 2 || evt.responseCode == 3)
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
      
      override protected function __startClick(evt:MouseEvent) : void
      {
         if(!_info.isAllReady())
         {
            return;
         }
         SoundManager.instance.play("008");
         CheckWeaponManager.instance.setFunction(this,__startClick,[evt]);
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
      
      protected function notEnoughEnergyBuy(e:CrazyTankSocketEvent) : void
      {
         var alertAsk:* = null;
         var isAlert:Boolean = e.pkg.readBoolean();
         if(!isAlert)
         {
            doSendStartOrPreGame();
         }
         else if(RoomManager.Instance.isNotAlertEnergyNotEnough)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.energyNotEnoughMsg"));
         }
         else
         {
            alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.view.energy.takeCardOutBuyPromptTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"RoomNotEnoughEnergyAlert",60,false,1);
            alertAsk.moveEnable = false;
            alertAsk.addEventListener("response",__alertBuyEnergy);
         }
      }
      
      protected function __alertBuyEnergy(event:FrameEvent) : void
      {
         var energyData:* = null;
         var confirmFrame2:* = null;
         SoundManager.instance.play("008");
         var frame:RoomNotEnoughEnergyAlert = event.currentTarget as RoomNotEnoughEnergyAlert;
         frame.removeEventListener("response",__alertBuyEnergy);
         RoomManager.Instance.isNotAlertEnergyNotEnough = frame.isNoPrompt;
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               ObjectUtils.disposeObject(frame);
               return;
            }
            energyData = PlayerManager.Instance.energyData[PlayerManager.Instance.Self.buyEnergyCount + 1];
            if(!energyData)
            {
               ObjectUtils.disposeObject(frame);
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.energy.cannotbuyEnergy"));
               return;
            }
            if(frame.isBand && PlayerManager.Instance.Self.BandMoney < energyData.Money)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.energy.changeMoneyCostTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",__changeMoneyBuyConfirm,false,0,true);
            }
            else if(!frame.isBand && PlayerManager.Instance.Self.Money < energyData.Money)
            {
               LeavePageManager.showFillFrame();
            }
            else
            {
               SocketManager.Instance.out.sendBuyEnergy(frame.isBand);
            }
         }
         else if(event.responseCode == 4 || event.responseCode == 0 || event.responseCode == 1)
         {
            if(isPreOrGame())
            {
               doSendStartOrPreGame();
            }
         }
         ObjectUtils.disposeObject(frame);
      }
      
      protected function isPreOrGame() : Boolean
      {
         if(MapManager.Instance.activeDoubleIds.indexOf(_info.mapId) != -1 || MapManager.Instance.singleDoubleIds.indexOf(_info.mapId) != -1 || _info.hardLevel == 4)
         {
            return false;
         }
         return true;
      }
      
      protected function __changeMoneyBuyConfirm(evt:FrameEvent) : void
      {
         var energyData:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__changeMoneyBuyConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            energyData = PlayerManager.Instance.energyData[PlayerManager.Instance.Self.buyEnergyCount + 1];
            if(PlayerManager.Instance.Self.Money < energyData.Money)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.sendBuyEnergy(false);
         }
      }
      
      private function _showBoGuTip() : void
      {
         var boGu:* = null;
         if(PlayerManager.Instance.Self._isDupSimpleTip)
         {
            PlayerManager.Instance.Self._isDupSimpleTip = false;
            boGu = ComponentFactory.Instance.creatComponentByStylename("room.RoomDupSimpleTipFram");
            boGu.show();
         }
      }
   }
}
