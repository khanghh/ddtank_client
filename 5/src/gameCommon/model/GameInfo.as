package gameCommon.model
{
	import flash.events.EventDispatcher;

	import ddt.data.map.MissionInfo;
	import ddt.events.CrazyTankSocketEvent;
	import ddt.events.GameEvent;
	import ddt.loader.MapLoader;
	import ddt.manager.ChatManager;
	import ddt.manager.PlayerManager;

	import gameCommon.GameControl;

	import guardCore.GuardCoreManager;
	import guardCore.data.GuardCoreInfo;

	import road7th.data.DictionaryData;

	import room.RoomManager;
	import room.model.RoomPlayer;

	public class GameInfo extends EventDispatcher
	{

		public static const ADD_ROOM_PLAYER:String = "addRoomPlayer";

		public static const REMOVE_ROOM_PLAYER:String = "removeRoomPlayer";


		private var _mapIndex:int;

		public var roomType:int;

		public var showAllCard:Array;

		public var startEvent:CrazyTankSocketEvent;

		public var GainRiches:int;

		public var PlayerCount:int;

		public var startPlayer:int;

		public var hasNextSession:Boolean;

		public var neededMovies:Array;

		public var neededPetSkillResource:Array;

		private var _selfGamePlayer:LocalPlayer;

		public var roomPlayers:Array;

		public var timeType:int;

		public var maxTime:int;

		public var outBombs:DictionaryData;

		public var outBoxs:DictionaryData;

		public var loaderMap:MapLoader;

		public var livings:DictionaryData;

		private var _teams:DictionaryData;

		public var startTime:Date;

		private var _weatherType:int;

		public var viewers:DictionaryData;

		public var currentLiving:Living;

		public var IsOneOnOne:Boolean;

		private var _gameMode:int;

		private var _resultCard:Array;

		private var _missionInfo:MissionInfo;

		public var missionCount:int;

		public var gameOverNpcMovies:Array;

		private var _wind:Number = 0;

		private var _windRate:Number = 0;

		private var _hasNextMission:Boolean;

		private var _guardCoreEnable:Boolean = true;

		public function GameInfo()
		{
			showAllCard = [];
			neededMovies = [];
			neededPetSkillResource = [];
			roomPlayers = [];
			outBombs = new DictionaryData();
			outBoxs = new DictionaryData();
			livings = new DictionaryData();
			_teams = new DictionaryData();
			viewers = new DictionaryData();
			_resultCard = [];
			gameOverNpcMovies = [];
			super();
		}

		public function get mapIndex() : int
		{
			return _mapIndex;
		}

		public function set mapIndex(param1:int) : void
		{
			_mapIndex = param1;
		}

		public function get isWeather() : Boolean
		{
			return _mapIndex == 1455 || _mapIndex == 1456 || _mapIndex == 1457;
		}

		public function get teams() : DictionaryData
		{
			return _teams;
		}

		public function set teams(param1:DictionaryData) : void
		{
			_teams = param1;
		}

		public function set gameMode(param1:int) : void
		{
			_gameMode = param1;
		}

		public function get gameMode() : int
		{
			return _gameMode;
		}

		public function get resultCard() : Array
		{
			return _resultCard;
		}

		public function set resultCard(param1:Array) : void
		{
			_resultCard = param1;
		}

		public function get missionInfo() : MissionInfo
		{
			return _missionInfo;
		}

		public function set missionInfo(param1:MissionInfo) : void
		{
			_missionInfo = param1;
		}

		public function resetBossCardCnt() : void
		{
			var _loc1_:* = null;
			var _loc4_:int = 0;
			var _loc3_:* = livings;
			for each(var _loc2_ in livings)
			{
				_loc1_ = _loc2_ as Player;
				if(_loc1_)
				{
					_loc1_.BossCardCount = 0;
					_loc1_.GetCardCount = 0;
				}
			}
		}

		public function addGamePlayer(param1:Living) : void
		{
			var _loc2_:Living = livings[param1.LivingID];
			if(_loc2_)
			{
				_loc2_.dispose();
			}
			if(param1 is LocalPlayer)
			{
				_selfGamePlayer = param1 as LocalPlayer;
			}
			livings.add(param1.LivingID,param1);
			addTeamPlayer(param1);
		}

		public function addGameViewer(param1:Living) : void
		{
			var _loc2_:Living = viewers[param1.playerInfo.ID];
			if(_loc2_)
			{
				_loc2_.dispose();
			}
			if(param1 is LocalPlayer)
			{
				_selfGamePlayer = param1 as LocalPlayer;
			}
			viewers.add(param1.playerInfo.ID,param1);
		}

		public function viewerToLiving(param1:int) : void
		{
			var _loc2_:Living = viewers[param1];
			if(_loc2_)
			{
				viewers.remove(param1);
				if(_loc2_ is LocalPlayer)
				{
					_selfGamePlayer = _loc2_ as LocalPlayer;
				}
				livings.add(_loc2_.LivingID,_loc2_);
				addTeamPlayer(_loc2_);
			}
		}

		public function livingToViewer(param1:int, param2:int) : void
		{
			var _loc3_:Living = findLivingByPlayerID(param1,param2);
			if(_loc3_)
			{
				livings.remove(_loc3_.LivingID);
				removeTeamPlayer(_loc3_);
				if(_loc3_ is LocalPlayer)
				{
					_selfGamePlayer = _loc3_ as LocalPlayer;
				}
				viewers.add(param1,_loc3_);
			}
		}

		public function addTeamPlayer(param1:Living) : void
		{
			var _loc2_:DictionaryData = new DictionaryData();
			if(teams[param1.team] == null)
			{
				_loc2_ = new DictionaryData();
				teams[param1.team] = _loc2_;
			}
			else
			{
				_loc2_ = teams[param1.team];
			}
			if(_loc2_[param1.LivingID] == null)
			{
				_loc2_.add(param1.LivingID,param1);
			}
		}

		public function removeTeamPlayer(param1:Living) : void
		{
			var _loc2_:DictionaryData = teams[param1.team];
			if(_loc2_ && _loc2_[param1.LivingID])
			{
				_loc2_.remove(param1.LivingID);
			}
		}

		public function setSelfGamePlayer(param1:Living) : void
		{
			_selfGamePlayer = param1 as LocalPlayer;
		}

		public function removeGamePlayer(param1:int) : Living
		{
			var _loc2_:Living = livings[param1];
			if(_loc2_)
			{
				removeTeamPlayer(_loc2_);
				livings.remove(param1);
				_loc2_.dispose();
			}
			return _loc2_;
		}

		public function removeGamePlayerByPlayerID(param1:int, param2:int) : void
		{
			var _loc6_:int = 0;
			var _loc5_:* = livings;
			for each(var _loc3_ in livings)
			{
				if(_loc3_ is Player && _loc3_.playerInfo)
				{
					if(_loc3_.playerInfo.ZoneID == param1 && _loc3_.playerInfo.ID == param2)
					{
						livings.remove(_loc3_.LivingID);
						_loc3_.dispose();
					}
				}
			}
			var _loc8_:int = 0;
			var _loc7_:* = viewers;
			for each(var _loc4_ in viewers)
			{
				if(_loc4_.playerInfo.ZoneID == param1 && _loc4_.playerInfo.ID == param2)
				{
					viewers.remove(_loc4_.playerInfo.ID);
					_loc4_.dispose();
				}
			}
		}

		public function isAllReady() : Boolean
		{
			var _loc1_:Boolean = true;
			var _loc4_:int = 0;
			var _loc3_:* = livings;
			for each(var _loc2_ in livings)
			{
				if(_loc2_.isReady == false)
				{
					_loc1_ = false;
					break;
				}
			}
			return _loc1_;
		}

		public function findPlayer(param1:int) : Player
		{
			return livings[param1] as Player;
		}

		public function findPlayerByPlayerID(param1:int) : Player
		{
			var _loc4_:int = 0;
			var _loc3_:* = livings;
			for each(var _loc2_ in livings)
			{
				if(_loc2_.isPlayer() && _loc2_.playerInfo.ID == param1)
				{
					return _loc2_ as Player;
				}
			}
			return null;
		}

		public function findGamerbyPlayerId(param1:int) : Player
		{
			var _loc5_:int = 0;
			var _loc4_:* = livings;
			for each(var _loc3_ in livings)
			{
				if(_loc3_.isPlayer() && _loc3_.playerInfo.ID == param1)
				{
					return _loc3_ as Player;
				}
			}
			var _loc7_:int = 0;
			var _loc6_:* = viewers;
			for each(var _loc2_ in viewers)
			{
				if(_loc2_.playerInfo.ID == param1)
				{
					return _loc2_ as Player;
				}
			}
			return null;
		}

		public function get haveAllias() : Boolean
		{
			var _loc3_:int = 0;
			var _loc2_:* = livings;
			for each(var _loc1_ in livings)
			{
				if(_loc1_.isLiving && _loc1_.team == selfGamePlayer.team)
				{
					return true;
				}
			}
			return false;
		}

		public function get allias() : Vector.<Player>
		{
			var _loc4_:int = 0;
			var _loc2_:* = null;
			var _loc1_:* = null;
			var _loc3_:Vector.<Player> = new Vector.<Player>();
			_loc4_ = 0;
			while(_loc4_ < roomPlayers.length)
			{
				_loc2_ = roomPlayers[_loc4_] as RoomPlayer;
				if(_loc2_)
				{
					_loc1_ = findPlayerByPlayerID(_loc2_.playerInfo.ID);
					if(_loc1_ && _loc1_.team == selfGamePlayer.team && _loc1_ != selfGamePlayer && _loc1_.expObj)
					{
						_loc3_.push(_loc1_);
					}
				}
				_loc4_++;
			}
			return _loc3_;
		}

		public function findLiving(param1:int) : Living
		{
			return livings[param1];
		}

		public function findLivingByName(param1:String) : Living
		{
			var _loc4_:int = 0;
			var _loc3_:* = livings;
			for each(var _loc2_ in livings)
			{
				if(_loc2_.isLiving && _loc2_.name == param1)
				{
					return _loc2_;
				}
			}
			return null;
		}

		public function findTeam(param1:int) : DictionaryData
		{
			return teams[param1];
		}

		public function resetWithinTheMap() : void
		{
			var _loc3_:int = 0;
			var _loc2_:* = livings;
			for each(var _loc1_ in livings)
			{
				_loc1_.resetWithinTheMap();
			}
		}

		public function findLivingByPlayerID(param1:int, param2:int) : Player
		{
			var _loc5_:int = 0;
			var _loc4_:* = livings;
			for each(var _loc3_ in livings)
			{
				if(_loc3_ is Player && _loc3_.playerInfo)
				{
					if(_loc3_.playerInfo.ID == param1 && _loc3_.playerInfo.ZoneID == param2)
					{
						return _loc3_ as Player;
					}
				}
			}
			return null;
		}

		public function removeAllMonsters() : void
		{
			var _loc3_:int = 0;
			var _loc2_:* = livings;
			for each(var _loc1_ in livings)
			{
				if(!(_loc1_ is Player))
				{
					livings.remove(_loc1_.LivingID);
					_loc1_.dispose();
				}
			}
		}

		public function removeAllTeam() : void
		{
		}

		public function get selfGamePlayer() : LocalPlayer
		{
			return _selfGamePlayer;
		}

		public function addRoomPlayer(param1:RoomPlayer) : void
		{
			var _loc2_:int = roomPlayers.indexOf(param1);
			if(_loc2_ > -1)
			{
				removeRoomPlayer(param1.playerInfo.ZoneID,param1.playerInfo.ID);
			}
			roomPlayers.push(param1);
		}

		public function removeRoomPlayer(param1:int, param2:int) : void
		{
			var _loc3_:RoomPlayer = findRoomPlayer(param2,param1);
			if(_loc3_)
			{
				roomPlayers.splice(roomPlayers.indexOf(_loc3_),1);
			}
		}

		public function findRoomPlayer(param1:int, param2:int) : RoomPlayer
		{
			var _loc5_:int = 0;
			var _loc4_:* = roomPlayers;
			for each(var _loc3_ in roomPlayers)
			{
				if(_loc3_.playerInfo != null)
				{
					if(_loc3_.playerInfo.ID == param1 && _loc3_.playerInfo.ZoneID == param2)
					{
						return _loc3_;
					}
				}
			}
			return null;
		}

		public function setWind(param1:Number, param2:Boolean = false, param3:Array = null) : void
		{
			_wind = Number(param1.toFixed(1));
			dispatchEvent(new GameEvent("windChanged",{
				"wind":_wind,
				"isSelfTurn":param2,
				"windNumArr":param3
			}));
			var num0:Boolean = Boolean(param3[0]);
			var num1:Number = Number(param3[1]);
            var num2:Number = Number(param3[2]);
            var num3:Number = Number(param3[3]);
			_wind = num1 + num3 / 10;
			if (!num0) _wind = -_wind;
			ChatManager.Instance.sysChatYellow("wind: " + GameControl.Instance.Current.wind.toString());
		}

		public function get wind() : Number
		{
			return _wind;
		}

		public function set windRate(param1:Number) : void
		{
			_windRate = param1;
		}

		public function get windRate() : Number
		{
			return _windRate;
		}

		public function get hasNextMission() : Boolean
		{
			return _hasNextMission;
		}

		public function set hasNextMission(param1:Boolean) : void
		{
			if(_hasNextMission == param1)
			{
				return;
			}
			_hasNextMission = param1;
		}

		public function resetResultCard() : void
		{
			_resultCard = [];
		}

		public function getRoomPlayerByID(param1:int, param2:int) : RoomPlayer
		{
			var _loc5_:int = 0;
			var _loc4_:* = roomPlayers;
			for each(var _loc3_ in roomPlayers)
			{
				if(_loc3_.playerInfo.ID == param1 && _loc3_.playerInfo.ZoneID == param2)
				{
					return _loc3_;
				}
			}
			return null;
		}

		public function getOutBombsIdList() : Array
		{
			var _loc1_:Array = [];
			var _loc4_:int = 0;
			var _loc3_:* = outBombs;
			for each(var _loc2_ in outBombs)
			{
				if(_loc1_.indexOf(_loc2_.Id) == -1)
				{
					_loc1_.push(_loc2_.Id);
				}
			}
			return _loc1_;
		}

		public function get isHasOneDead() : Boolean
		{
			var _loc3_:int = 0;
			var _loc2_:* = livings;
			for each(var _loc1_ in livings)
			{
				if(_loc1_ is Player && _loc1_.team == selfGamePlayer.team && !_loc1_.isLiving)
				{
					return true;
				}
			}
			return false;
		}

		public function getGuardCoreBuffList() : Array
		{
			var _loc2_:* = null;
			var _loc7_:* = null;
			var _loc4_:Boolean = false;
			var _loc6_:int = 0;
			var _loc1_:* = null;
			var _loc3_:Array = [];
			var _loc9_:int = 0;
			var _loc8_:* = livings;
			for each(var _loc5_ in livings)
			{
				_loc2_ = _loc5_ as Player;
				if(_loc2_)
				{
					_loc7_ = GuardCoreManager.instance.getGuardCoreInfoByID(_loc2_.playerInfo.guardCoreID);
					if(_loc7_ && _loc7_.GainGrade <= _loc2_.playerInfo.Grade)
					{
						if(_loc2_.team == selfGamePlayer.team && _loc7_.GroupType == 1 && !_loc2_.isSelf || _loc2_.team != selfGamePlayer.team && _loc7_.GroupType == 2 && !_loc2_.isSelf || _loc2_.isSelf && (_loc7_.GroupType == 0 || _loc7_.GroupType == 1))
						{
							if(_loc7_.KeepTurn == 0 || selfGamePlayer.turnCount <= _loc7_.KeepTurn)
							{
								_loc4_ = false;
								_loc6_ = 0;
								while(_loc6_ < _loc3_.length)
								{
									_loc1_ = _loc3_[_loc6_] as GuardCoreInfo;
									if(_loc1_.Type == _loc7_.Type)
									{
										if(_loc7_.SkillGrade > _loc1_.SkillGrade)
										{
											_loc3_[_loc6_] = _loc7_;
										}
										_loc4_ = true;
										break;
									}
									_loc6_++;
								}
								if(!_loc4_)
								{
									_loc3_.push(_loc7_);
								}
							}
						}
					}
				}
			}
			return _loc3_;
		}

		public function get guardCoreEnable() : Boolean
		{
			return _guardCoreEnable;
		}

		public function set guardCoreEnable(param1:Boolean) : void
		{
			_guardCoreEnable = param1;
		}

		public function dispose() : void
		{
			var _loc4_:int = 0;
			var _loc3_:* = roomPlayers;
			for each(var _loc1_ in roomPlayers)
			{
				if(RoomManager.Instance.current.players.list.indexOf(_loc1_) == -1)
				{
					_loc1_.dispose();
				}
				else
				{
					_loc1_.claerMovie3D();
				}
			}
			if(roomPlayers)
			{
				roomPlayers = null;
			}
			if(livings)
			{
				var _loc6_:int = 0;
				var _loc5_:* = livings;
				for each(var _loc2_ in livings)
				{
					_loc2_.dispose();
					_loc2_ = null;
				}
				livings.clear();
			}
			if(_resultCard)
			{
				_resultCard = [];
			}
			missionInfo = null;
			if(loaderMap)
			{
				loaderMap.dispose();
			}
			if(PlayerManager.Instance.hasTempStyle)
			{
				PlayerManager.Instance.readAllTempStyleEvent();
			}
		}

		public function get weatherType() : int
		{
			return _weatherType;
		}

		public function set weatherType(param1:int) : void
		{
			_weatherType = param1;
		}
	}
}
