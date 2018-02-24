package gameCommon
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ddt.events.CrazyTankSocketEvent;
	import ddt.events.LivingEvent;
	import ddt.events.RoomEvent;
	import ddt.manager.ChatManager;
	import ddt.manager.GameInSocketOut;
	import ddt.manager.SocketManager;
	import ddt.manager.StateManager;
	import ddt.states.BaseStateView;
	
	import game.view.map.MapView;
	
	import gameCommon.model.GameInfo;
	import gameCommon.model.LocalPlayer;
	
	import org.aswing.KeyboardManager;
	
	import room.RoomManager;
	import room.model.RoomInfo;
	import room.view.states.MatchRoomState;

	public class PVPAutoControl extends EventDispatcher
	{
		private var _isAuto:Boolean = false;
		private var _shootTime:uint = 0;
		private static var _instance:PVPAutoControl;
		private var _isStarted:Boolean = false;
		
		
		public function PVPAutoControl()
		{
		}
		
		public static function get Instance() : PVPAutoControl
		{
			if (_instance == null)
			{
				_instance = new PVPAutoControl();
			}
			return _instance;
		}
		
		private function get selfPlayer() : LocalPlayer
		{
			if(GameControl.Instance.Current)
			{
				return GameControl.Instance.Current.selfGamePlayer;
			}
			return null;
		}
		
		private function get matchRoom() : MatchRoomState
		{
			return MatchRoomState(StateManager.getState("matchRoom"));
		}
		
		private function get map() : MapView
		{
			return selfPlayer.currentMap;
		}
		
		private function get gameInfo() : GameInfo
		{
			return GameControl.Instance.Current;
		}
		
		private function get roomInfo() : RoomInfo
		{
			return RoomManager.Instance.current;
		}
		
		public function setAutoState(param1:Boolean) : void
		{
//			if(matchRoom != null)
//			{
//				if(_isAuto != param1)
//				{
//					_isAuto = param1;
//					if (_isAuto)
//					{
//						initEvent();
//					}
//					else
//					{
//						removeEvent();
//					}
//					ChatManager.Instance.sysChatYellow("_isAuto: " + _isAuto.toString());
//				}
//			}
//			else
//			{
//				ChatManager.Instance.sysChatYellow("Chưa vào phòng game !")
//			}
		}
		
		private function initEvent() : void
		{
//			if (roomInfo.selfRoomPlayer.isViewer) return;
//			ChatManager.Instance.sysChatYellow("initEvent");
//			_startGameTimer.addEventListener("timer", __retryStartGame);
//			roomInfo.addEventListener("startedChanged",__startHandler);
//			roomInfo.selfRoomPlayer.addEventListener("readyChange", __readyChange);
//			SocketManager.Instance.addEventListener("gameCreate",__gameCreate);
//			if (gameInfo != null)
//			{
//				selfPlayer.removeEventListener("attackingChanged",__autoShootHandler);
//			}
//			else
//			{
//				_startGameTimer.start();
//				ChatManager.Instance.sysChatYellow("_startGameTimer.start");
//			}
		}		
		
		private function removeEvent() : void
		{
//			_startGameTimer.stop();
//			_startGameTimer.removeEventListener("timer", __retryStartGame);
//			roomInfo.removeEventListener("startedChanged",__startHandler);
//			roomInfo.selfRoomPlayer.removeEventListener("readyChange", __readyChange);
//			SocketManager.Instance.removeEventListener("gameCreate",__gameCreate);
		}
		
		protected function __gameCreate(event:CrazyTankSocketEvent):void
		{
			removeEvent();

		}
		
		protected function __matchRoomLeaving(event:Event):void
		{
			ChatManager.Instance.sysChatYellow("__matchRoomLeave");
			if (_isAuto)
			{
				removeEvent();
			}
		}
		
		protected function __matchRoomEnter(event:Event):void
		{
			ChatManager.Instance.sysChatYellow("__matchRoomEnter");
			if (_isAuto)
			{
				initEvent();
			}
		}

		protected function __retryStartGame(event:TimerEvent):void
		{
			ChatManager.Instance.sysChatYellow("__retryStartGame");
			if (roomInfo.selfRoomPlayer.isHost && roomInfo.isAllReady())
			{
				roomInfo.started = true;
				GameInSocketOut.sendGameStart();
			}
			else
			{
				GameInSocketOut.sendPlayerState(1);
			}
		}

		protected function __startHandler(event:RoomEvent):void
		{
//			ChatManager.Instance.sysChatYellow("__startHandler");
//			ChatManager.Instance.sysChatYellow("roomInfo.started: " + roomInfo.started.toString());
//			if (roomInfo.started)
//			{
//				_startGameTimer.stop();
//			}
//			else
//			{
//				ChatManager.Instance.sysChatYellow("_startGameTimer.running: " + _startGameTimer.running.toString());
//				if(!_startGameTimer.running && _isAuto)
//					_startGameTimer.start();
//			}
		}
		
		protected function __readyChange(event:Event):void
		{
//			ChatManager.Instance.sysChatYellow("__readyChange");
//			ChatManager.Instance.sysChatYellow("roomInfo.selfRoomPlayer.isReady: " + roomInfo.selfRoomPlayer.isReady.toString());
//			if (!roomInfo.selfRoomPlayer.isHost && roomInfo.selfRoomPlayer.isReady)
//			{
//				_startGameTimer.stop();
//			}
//			else
//			{
//				if(!_startGameTimer.running && _isAuto)
//					_startGameTimer.start();
//			}
		}	
		
		private function __autoShootHandler(param1:LivingEvent) : void
		{
			ChatManager.Instance.sysChatYellow("__autoShootHandler");
			//if(RoomManager.Instance.current.type == 49 && selfPlayer.isAttacking)
			//{
			//	setKeyEventDisenable(true);
			//	if(_shootTime != 0)
			//	{
			//		clearTimeout(_shootTime);
			//	}
			//	_shootTime = setTimeout(shoot,1000);
			//}
		}
		
		private function shoot():void
		{
			
		}
		
		private function setKeyEventDisenable(param1:Boolean) : void
		{
			KeyboardManager.getInstance().isStopDispatching = param1;
		}
	}
}