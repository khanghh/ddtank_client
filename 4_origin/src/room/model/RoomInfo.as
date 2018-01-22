package room.model
{
   import ddt.events.RoomEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class RoomInfo extends EventDispatcher
   {
      
      public static const MATCH_ROOM:int = 0;
      
      public static const CHALLENGE_ROOM:int = 1;
      
      public static const DUNGEON_ROOM:int = 4;
      
      public static const FIGHT_LIB_ROOM:int = 5;
      
      public static const FRESHMAN_ROOM:int = 10;
      
      public static const ACADEMY_DUNGEON_ROOM:int = 11;
      
      public static const LEAGE_ROOM:int = 12;
      
      public static const GUILD_LEAGE_MODE:int = 13;
      
      public static const SCORE_ROOM:int = 12;
      
      public static const RANK_ROOM:int = 13;
      
      public static const WORLD_BOSS_FIGHT:int = 14;
      
      public static const LANBYRINTH_ROOM:int = 15;
      
      public static const ENCOUNTER_ROOM:int = 16;
      
      public static const FIGHTGROUND_ROOM:int = 18;
      
      public static const CONSORTIA_BOSS:int = 17;
      
      public static const CONSORTIA_BATTLE:int = 19;
      
      public static const CAMPBATTLE_BATTLE:int = 20;
      
      public static const ACTIVITY_DUNGEON_ROOM:int = 21;
      
      public static const SPECIAL_ACTIVITY_DUNGEON:int = 23;
      
      public static const RING_STATION:int = 24;
      
      public static const SEVEN_DOUBLE:int = 31;
      
      public static const SINGLE_BATTLE:int = 25;
      
      public static const CATCH_BEAST:int = 26;
      
      public static const BOMB_KING:int = 27;
      
      public static const FARM_BOSS:int = 28;
      
      public static const RESCUE:int = 29;
      
      public static const CHRISTMAS_ROOM:int = 40;
      
      public static const ENTERTAINMENT_ROOM:int = 41;
      
      public static const ENTERTAINMENT_ROOM_PK:int = 42;
      
      public static const CRYPTBOSS_ROOM:int = 51;
      
      public static const CATCH_INSECT_ROOM:int = 52;
      
      public static const RENSHEN_ROOM:int = 67;
      
      public static const POLARREGION:int = 68;
      
      public static const SURVIVALMODE:int = 121;
      
      public static const STONEEXPLORE_ROOM:int = 56;
      
      public static const CONSORTIA_MATCH_SCORE:int = 43;
      
      public static const CONSORTIA_MATCH_RANK:int = 44;
      
      public static const CONSORTIA_MATCH_SCORE_WHOLE:int = 45;
      
      public static const CONSORTIA_MATCH_RANK_WHOLE:int = 46;
      
      public static const BATTLE_ROOM:int = 120;
      
      public static const DEMON_CHI_YOU_ROOM:int = 48;
      
      public static const NEW_DUNGEON_1:int = 47;
      
      public static const NEW_DUNGEON_2:int = 48;
      
      public static const HERO_AUTO:int = 49;
      
      public static const CONSORTIA_DOMAIN_ROOM:int = 150;
      
      public static const TEAM_ROOM:int = 58;
      
      public static const DUNGEON_TESTMODE:int = 120;
      
      public static const CONSORTIA_GUARD_ROOM:int = 151;
      
      public static const DEFEND_ISLAND:int = 155;
      
      public static const BATTLE_DUNGEON_ROOM:int = 123;
      
      public static const FREE_MODE:int = 0;
      
      public static const GUILD_MODE:int = 1;
      
      public static const BOTH_MODE:int = 4;
      
      public static const MATCH_NPC:int = 9;
      
      public static const EASY:int = 0;
      
      public static const NORMAL:int = 1;
      
      public static const HARD:int = 2;
      
      public static const HERO:int = 3;
      
      public static const EPIC:int = 5;
      
      public static const NIGHTMARE:int = 4;
      
      public static const DUNGEONTYPE_NO:int = 1;
      
      public static const DUNGEONTYPE_SP:int = 2;
      
      public static const DUNGEONTYPE_AC:int = 3;
      
      public static const DUNGEONTYPE_NI:int = 4;
      
      public static const DUNGEONTYPE_SI:int = 5;
      
      public static const NULL_ROOM:int = -100;
       
      
      public var ID:int;
      
      public var Name:String;
      
      public var maxViewerCnt:int = 2;
      
      public var isWithinLeageTime:Boolean;
      
      private var _type:int;
      
      private var _players:DictionaryData;
      
      private var _gameMode:int;
      
      private var _mapId:int;
      
      private var _timeType:int = -1;
      
      private var _hardLevel:int;
      
      private var _levelLimits:int;
      
      private var _totalPlayer:int;
      
      private var _viewerCnt:int;
      
      private var _placeCount:int;
      
      public var isLocked:Boolean;
      
      private var _started:Boolean;
      
      private var _isCrossZone:Boolean;
      
      private var _isPlaying:Boolean;
      
      private var _isLocked:Boolean;
      
      private var _changedCount:int;
      
      private var _isOpenBoss:Boolean;
      
      private var _pic:String;
      
      private var _roomPass:String = "";
      
      private var _dungeonType:int;
      
      private var _dungeonMode:int;
      
      private var _placesState:Array;
      
      private var _defyInfo:Array;
      
      public function RoomInfo()
      {
         _placesState = [-1,-1,-1,-1,-1,-1,-1,-1];
         super();
         _players = new DictionaryData();
      }
      
      public function get pic() : String
      {
         return _pic;
      }
      
      public function set pic(param1:String) : void
      {
         _pic = param1;
      }
      
      public function get isOpenBoss() : Boolean
      {
         return _isOpenBoss;
      }
      
      public function set isOpenBoss(param1:Boolean) : void
      {
         if(_isOpenBoss == param1)
         {
            return;
         }
         _isOpenBoss = param1;
         dispatchEvent(new RoomEvent("openBossChange",_isOpenBoss));
      }
      
      public function get roomPass() : String
      {
         return _roomPass;
      }
      
      public function set roomPass(param1:String) : void
      {
         if(_roomPass == param1)
         {
            return;
         }
         _roomPass = param1;
      }
      
      public function get roomName() : String
      {
         return Name;
      }
      
      public function set roomName(param1:String) : void
      {
         if(Name == param1)
         {
            return;
         }
         Name = param1;
         dispatchEvent(new RoomEvent("roomNameChanged"));
      }
      
      public function get defyInfo() : Array
      {
         return _defyInfo;
      }
      
      public function set defyInfo(param1:Array) : void
      {
         _defyInfo = param1;
      }
      
      public function get placesState() : Array
      {
         return _placesState;
      }
      
      public function updatePlaceState(param1:Array) : void
      {
         var _loc10_:Boolean = false;
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = type == 1?8:4;
         var _loc2_:* = -100;
         _loc9_ = 0;
         while(_loc9_ < 10)
         {
            if(_placesState[_loc9_] != param1[_loc9_])
            {
               if(_loc9_ >= 8)
               {
                  if(param1[_loc9_] != -1)
                  {
                     _loc3_ = findPlayerByID(param1[_loc9_]);
                     if(_loc3_ != null)
                     {
                        _loc3_.place = _loc9_;
                     }
                  }
                  else if(_placesState[_loc9_] != -1)
                  {
                     _loc3_ = findPlayerByID(_placesState[_loc9_]);
                     if(_loc3_ != null)
                     {
                        if(_loc2_ != -100)
                        {
                           _loc3_.place = _loc2_;
                        }
                     }
                  }
               }
               _loc2_ = _loc9_;
               _loc10_ = true;
            }
            _loc9_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            if(param1[_loc7_] == -1)
            {
               _loc4_++;
            }
            _loc7_++;
         }
         var _loc6_:int = 0;
         var _loc11_:* = _type;
         if(120 !== _loc11_)
         {
            if(0 !== _loc11_)
            {
               if(49 !== _loc11_)
               {
                  if(1 !== _loc11_)
                  {
                     if(4 !== _loc11_)
                     {
                        if(11 !== _loc11_)
                        {
                           if(21 !== _loc11_)
                           {
                              if(56 !== _loc11_)
                              {
                                 if(23 !== _loc11_)
                                 {
                                    if(47 !== _loc11_)
                                    {
                                       if(48 !== _loc11_)
                                       {
                                          if(123 !== _loc11_)
                                          {
                                          }
                                       }
                                       addr119:
                                       _loc6_ = 10;
                                    }
                                    addr118:
                                    §§goto(addr119);
                                 }
                                 addr117:
                                 §§goto(addr118);
                              }
                              addr116:
                              §§goto(addr117);
                           }
                           addr115:
                           §§goto(addr116);
                        }
                        addr114:
                        §§goto(addr115);
                     }
                     addr113:
                     §§goto(addr114);
                  }
                  §§goto(addr113);
               }
               addr159:
               _loc8_ = 8;
               while(_loc8_ < _loc6_)
               {
                  if(param1[_loc8_] == -1)
                  {
                     _loc4_++;
                  }
                  _loc8_++;
               }
               placeCount = _loc4_;
               if(_loc10_)
               {
                  _placesState = param1;
                  dispatchEvent(new RoomEvent("roomplaceChanged"));
               }
               return;
            }
            addr107:
            _loc6_ = 9;
            §§goto(addr159);
         }
         §§goto(addr107);
      }
      
      public function updatePlayerState(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = players;
         for each(var _loc2_ in players)
         {
            _loc2_.isReady = param1[_loc2_.place] == 1;
            _loc2_.isHost = param1[_loc2_.place] == 2;
         }
         dispatchEvent(new RoomEvent("playerStateChanged"));
      }
      
      public function setPlayerReadyState(param1:int, param2:Boolean) : void
      {
         findPlayerByID(param1).isReady = param2;
         dispatchEvent(new RoomEvent("playerStateChanged"));
      }
      
      public function updatePlayerTeam(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:RoomPlayer = _players[param1];
         if(_loc4_)
         {
            _loc4_.team = param2;
            _loc4_.place = param3;
         }
         dispatchEvent(new RoomEvent("roomplaceChanged"));
      }
      
      public function addPlayer(param1:RoomPlayer) : void
      {
         _players.add(param1.playerInfo.ID,param1);
         dispatchEvent(new RoomEvent("addPlayer",param1));
      }
      
      public function removePlayer(param1:int, param2:int) : RoomPlayer
      {
         if(param1 != PlayerManager.Instance.Self.ZoneID)
         {
            return null;
         }
         var _loc3_:RoomPlayer = players[param2];
         if(_loc3_)
         {
            _players.remove(param2);
            dispatchEvent(new RoomEvent("removePlayer",_loc3_));
         }
         return _loc3_;
      }
      
      public function findPlayerByID(param1:int, param2:int = -1) : RoomPlayer
      {
         if(param2 == -1)
         {
            if(_players[param1] && _players[param1].playerInfo)
            {
               return _players[param1] as RoomPlayer;
            }
            return null;
         }
         if(_players[param1] && _players[param1].playerInfo && _players[param1].playerInfo.ZoneID == param2)
         {
            return _players[param1] as RoomPlayer;
         }
         return null;
      }
      
      public function findPlayerByPlace(param1:int) : RoomPlayer
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = players;
         for each(var _loc3_ in players)
         {
            if(_loc3_.place == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _players;
         for each(var _loc1_ in _players)
         {
            _loc1_.dispose();
         }
         _players.clear();
         _players = null;
         _type = -100;
      }
      
      public function get players() : DictionaryData
      {
         return _players;
      }
      
      public function startPickup() : void
      {
         started = true;
      }
      
      public function cancelPickup() : void
      {
         started = false;
      }
      
      public function pickupFailed() : void
      {
         started = false;
      }
      
      public function get selfRoomPlayer() : RoomPlayer
      {
         return findPlayerByID(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.ZoneID);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         if(_type == param1)
         {
            return;
         }
         _type = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function isYellowBg() : Boolean
      {
         return _type == 4 || _type == 0 || _type == 11 || _type == 21 || _type == 23 || _type == 12 || _type == 13 || _type == 28 || _type == 120 || _type == 68 || _type == 123 || _type == 58;
      }
      
      public function canShowTitle() : Boolean
      {
         return _type >= 2 && _type != 12 && _type != 13 && _type != 25 && _type != 40;
      }
      
      public function get gameMode() : int
      {
         return _gameMode;
      }
      
      public function set gameMode(param1:int) : void
      {
         if(_gameMode == param1)
         {
            return;
         }
         _gameMode = param1;
         dispatchEvent(new RoomEvent("gameModeChange"));
      }
      
      public function canPlayGuidMode() : Boolean
      {
         var _loc4_:int = 0;
         if(_players.length - currentViewerCnt <= 1)
         {
            return false;
         }
         if(selfRoomPlayer.isViewer)
         {
            var _loc6_:int = 0;
            var _loc5_:* = players;
            for each(var _loc3_ in players)
            {
               if(_loc3_ != selfRoomPlayer)
               {
                  _loc4_ = _loc3_.playerInfo.ConsortiaID;
                  break;
               }
            }
         }
         else
         {
            _loc4_ = selfRoomPlayer.playerInfo.ConsortiaID;
         }
         if(_loc4_ <= 0)
         {
            return false;
         }
         var _loc1_:Boolean = true;
         var _loc8_:int = 0;
         var _loc7_:* = players;
         for each(var _loc2_ in players)
         {
            if(!_loc2_.isViewer)
            {
               if(_loc2_.playerInfo.ConsortiaID != _loc4_)
               {
                  _loc1_ = false;
                  break;
               }
            }
         }
         return _loc1_;
      }
      
      public function isAllReady() : Boolean
      {
         var _loc1_:Boolean = true;
         if(type == 1)
         {
            if(_players.length == 1)
            {
               return false;
            }
         }
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var _loc2_ in _players)
         {
            if(!_loc2_.isReady && !_loc2_.isHost && !_loc2_.isViewer)
            {
               _loc1_ = false;
               break;
            }
         }
         return _loc1_;
      }
      
      public function getDifficulty(param1:int) : String
      {
         switch(int(param1))
         {
            case 0:
               if(_type == 5)
               {
                  return LanguageMgr.GetTranslation("tank.fightLib.GameOver.Title.Easy");
               }
               return LanguageMgr.GetTranslation("tank.room.difficulty.simple");
            case 1:
               if(_type == 5)
               {
                  return LanguageMgr.GetTranslation("tank.fightLib.GameOver.Title.Nomal");
               }
               return LanguageMgr.GetTranslation("tank.room.difficulty.normal");
            case 2:
               if(_type == 5)
               {
                  return LanguageMgr.GetTranslation("tank.fightLib.GameOver.Title.Difficult");
               }
               return LanguageMgr.GetTranslation("tank.room.difficulty.hard");
            case 3:
               return LanguageMgr.GetTranslation("tank.room.difficulty.hero");
            case 4:
               return LanguageMgr.GetTranslation("tank.room.difficulty.nightmare");
         }
      }
      
      public function get mapId() : int
      {
         return _mapId;
      }
      
      public function set mapId(param1:int) : void
      {
         if(_mapId == param1)
         {
            return;
         }
         _mapId = param1;
         dispatchEvent(new RoomEvent("mapChanged"));
      }
      
      public function get timeType() : int
      {
         return _timeType;
      }
      
      public function set timeType(param1:int) : void
      {
         if(_timeType == param1)
         {
            return;
         }
         _timeType = param1;
         dispatchEvent(new RoomEvent("mapTimeChanged"));
      }
      
      public function get hardLevel() : int
      {
         return _hardLevel;
      }
      
      public function set hardLevel(param1:int) : void
      {
         if(_hardLevel == param1)
         {
            return;
         }
         _hardLevel = param1;
         dispatchEvent(new RoomEvent("hardLevelChanged"));
      }
      
      public function get levelLimits() : int
      {
         return _levelLimits;
      }
      
      public function set levelLimits(param1:int) : void
      {
         _levelLimits = param1;
      }
      
      public function get totalPlayer() : int
      {
         return _totalPlayer;
      }
      
      public function set totalPlayer(param1:int) : void
      {
         if(_totalPlayer == param1)
         {
            return;
         }
         _totalPlayer = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function get currentViewerCnt() : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var _loc1_ in _players)
         {
            if(_loc1_.isViewer)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function get currentPlayerCount() : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var _loc1_ in _players)
         {
            if(!_loc1_.isViewer)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function get currentPlayers() : Array
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var _loc1_ in _players)
         {
            if(!_loc1_.isViewer)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function get viewerCnt() : int
      {
         return _viewerCnt;
      }
      
      public function set viewerCnt(param1:int) : void
      {
         if(_viewerCnt == param1)
         {
            return;
         }
         _viewerCnt = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function get placeCount() : int
      {
         return _placeCount;
      }
      
      public function set placeCount(param1:int) : void
      {
         if(_placeCount == param1)
         {
            return;
         }
         _placeCount = param1;
         dispatchEvent(new RoomEvent("placeCountChanged"));
      }
      
      public function get started() : Boolean
      {
         return _started;
      }
      
      public function set started(param1:Boolean) : void
      {
         if(_started == param1)
         {
            return;
         }
         _started = param1;
         dispatchEvent(new RoomEvent("startedChanged"));
      }
      
      public function get isCrossZone() : Boolean
      {
         return _isCrossZone;
      }
      
      public function set isCrossZone(param1:Boolean) : void
      {
         if(_isCrossZone == param1)
         {
            return;
         }
         _isCrossZone = param1;
         dispatchEvent(new RoomEvent("allowCrossChange"));
      }
      
      public function resetStates() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _players;
         for each(var _loc1_ in _players)
         {
            _loc1_.isReady = false;
         }
         _started = false;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         _isPlaying = param1;
      }
      
      public function get IsLocked() : Boolean
      {
         return _isLocked;
      }
      
      public function set IsLocked(param1:Boolean) : void
      {
         _isLocked = param1;
      }
      
      public function get dungeonType() : int
      {
         return _dungeonType;
      }
      
      public function set dungeonType(param1:int) : void
      {
         if(_dungeonType == param1)
         {
            return;
         }
         _dungeonType = param1;
      }
      
      public function get isDungeonType() : Boolean
      {
         return 4 == _type || 11 == _type || 15 == _type || 123 == _type;
      }
      
      public function get isLeagueRoom() : Boolean
      {
         return 13 == _gameMode || 12 == _gameMode;
      }
      
      public function get dungeonMode() : int
      {
         return _dungeonMode;
      }
      
      public function set dungeonMode(param1:int) : void
      {
         if(_dungeonMode == param1)
         {
            return;
         }
         _dungeonMode = param1;
      }
   }
}
