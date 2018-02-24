package room.view.roomView
{
   import LimitAward.LimitAwardButton;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.events.RoomEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.bossbox.SmallBoxButton;
   import ddt.view.chat.ChatData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import league.LeagueManager;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.RoomPlayerItem;
   import room.view.bigMapInfoPanel.MatchRoomBigMapInfoPanel;
   import room.view.smallMapInfoPanel.MatchRoomSmallMapInfoPanel;
   import trainer.controller.WeakGuildManager;
   import trainer.view.NewHandContainer;
   import trainer.view.VaneTipView;
   
   public class MatchRoomView extends BaseRoomView
   {
      
      private static const MATCH_NPC:int = 40;
      
      private static const BOTH_MODE_ALERT_TIME:int = 60;
      
      private static const DISABLE_RETURN:int = 20;
      
      private static const MATCH_NPC_ENABLE:Boolean = false;
       
      
      private var _bg:MovieClip;
      
      private var _itemListBg:MovieClip;
      
      private var _bigMapInfoPanel:MatchRoomBigMapInfoPanel;
      
      private var _smallMapInfoPanel:MatchRoomSmallMapInfoPanel;
      
      private var _playerItemContainer:SimpleTileList;
      
      protected var _crossZoneBtn:SelectedButton;
      
      private var _boxButton:SmallBoxButton;
      
      private var _limitAwardButton:LimitAwardButton;
      
      private var _timerII:Timer;
      
      protected var _leagueTxt:FilterFrameText;
      
      private var _roomIdTxt:FilterFrameText;
      
      private var _roomDesbit:MovieClip;
      
      private var _alert1:BaseAlerFrame;
      
      private var _alert2:BaseAlerFrame;
      
      public function MatchRoomView(param1:RoomInfo){super(null);}
      
      override protected function initEvents() : void{}
      
      override protected function removeEvents() : void{}
      
      private function __loadWeakGuild(param1:Event) : void{}
      
      private function showStart() : void{}
      
      private function showWait() : void{}
      
      private function userGuideAlert(param1:int, param2:String) : void{}
      
      private function __responseTip(param1:FrameEvent) : void{}
      
      private function __crossZoneChangeHandler(param1:RoomEvent) : void{}
      
      private function __onTweentySec(param1:RoomEvent) : void{}
      
      private function __onTimer(param1:TimerEvent) : void{}
      
      private function showMatchNpc() : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      override protected function __startHandler(param1:RoomEvent) : void{}
      
      private function showBothMode() : void{}
      
      private function __onResponseII(param1:FrameEvent) : void{}
      
      private function __crossZoneClick(param1:MouseEvent) : void{}
      
      private function __onFightNpc(param1:PkgEvent) : void{}
      
      override protected function updateButtons() : void{}
      
      override protected function initView() : void{}
      
      override protected function initTileList() : void{}
      
      override protected function __addPlayer(param1:RoomEvent) : void{}
      
      override protected function __removePlayer(param1:RoomEvent) : void{}
      
      override public function dispose() : void{}
   }
}
