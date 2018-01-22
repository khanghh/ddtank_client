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
      
      public function MissionRoomView(param1:RoomInfo){super(null);}
      
      override protected function initView() : void{}
      
      private function initMapView() : void{}
      
      private function __onMapChangedHandler(param1:Event) : void{}
      
      private function clearRoomProView() : void{}
      
      private function createPVEBattleProView() : void{}
      
      private function createRoomProView() : void{}
      
      private function __switchProViewHandler(param1:int) : void{}
      
      override protected function initEvents() : void{}
      
      override protected function checkCanStartGame() : Boolean{return false;}
      
      override protected function removeEvents() : void{}
      
      protected function initPanel() : void{}
      
      override protected function initTileList() : void{}
      
      override protected function __onHostTimer(param1:TimerEvent) : void{}
      
      override protected function kickHandler() : void{}
      
      override protected function __cancelClick(param1:MouseEvent) : void{}
      
      override protected function startGame() : void{}
      
      override protected function __startClick(param1:MouseEvent) : void{}
      
      override protected function prepareGame() : void{}
      
      private function checkSendCheckEnergy() : void{}
      
      private function doStart() : void{}
      
      private function doPrepareGame() : void{}
      
      private function doSendStartOrPreGame() : void{}
      
      protected function notEnoughEnergyBuy(param1:CrazyTankSocketEvent) : void{}
      
      protected function __alertBuyEnergy(param1:FrameEvent) : void{}
      
      protected function isPreOrGame() : Boolean{return false;}
      
      protected function __changeMoneyBuyConfirm(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
