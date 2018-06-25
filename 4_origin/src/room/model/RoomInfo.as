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
      
      public static const DREAM_LAND:int = 70;
      
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
      
      public function set pic(value:String) : void
      {
         _pic = value;
      }
      
      public function get isOpenBoss() : Boolean
      {
         return _isOpenBoss;
      }
      
      public function set isOpenBoss(value:Boolean) : void
      {
         if(_isOpenBoss == value)
         {
            return;
         }
         _isOpenBoss = value;
         dispatchEvent(new RoomEvent("openBossChange",_isOpenBoss));
      }
      
      public function get roomPass() : String
      {
         return _roomPass;
      }
      
      public function set roomPass(value:String) : void
      {
         if(_roomPass == value)
         {
            return;
         }
         _roomPass = value;
      }
      
      public function get roomName() : String
      {
         return Name;
      }
      
      public function set roomName(value:String) : void
      {
         if(Name == value)
         {
            return;
         }
         Name = value;
         dispatchEvent(new RoomEvent("roomNameChanged"));
      }
      
      public function get defyInfo() : Array
      {
         return _defyInfo;
      }
      
      public function set defyInfo(value:Array) : void
      {
         _defyInfo = value;
      }
      
      public function get placesState() : Array
      {
         return _placesState;
      }
      
      public function updatePlaceState(states:Array) : void
      {
         var changed:Boolean = false;
         var i:int = 0;
         var player:* = null;
         var j:int = 0;
         var k:int = 0;
         var temp:int = 0;
         var l:int = type == 1?8:4;
         var changedIdx:* = -100;
         for(i = 0; i < 10; )
         {
            if(_placesState[i] != states[i])
            {
               if(i >= 8)
               {
                  if(states[i] != -1)
                  {
                     player = findPlayerByID(states[i]);
                     if(player != null)
                     {
                        player.place = i;
                     }
                  }
                  else if(_placesState[i] != -1)
                  {
                     player = findPlayerByID(_placesState[i]);
                     if(player != null)
                     {
                        if(changedIdx != -100)
                        {
                           player.place = changedIdx;
                        }
                     }
                  }
               }
               changedIdx = i;
               changed = true;
            }
            i++;
         }
         for(j = 0; j < l; )
         {
            if(states[j] == -1)
            {
               temp++;
            }
            j++;
         }
         var len:int = 0;
         var _loc11_:* = _type;
         if(120 !== _loc11_)
         {
            if(0 !== _loc11_)
            {
               if(49 !== _loc11_)
               {
                  if(70 !== _loc11_)
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
                                          addr162:
                                          len = 10;
                                       }
                                       addr161:
                                       §§goto(addr162);
                                    }
                                    addr160:
                                    §§goto(addr161);
                                 }
                                 addr159:
                                 §§goto(addr160);
                              }
                              addr158:
                              §§goto(addr159);
                           }
                           addr157:
                           §§goto(addr158);
                        }
                        addr156:
                        §§goto(addr157);
                     }
                     §§goto(addr156);
                  }
                  addr220:
                  for(k = 8; k < len; )
                  {
                     if(states[k] == -1)
                     {
                        temp++;
                     }
                     k++;
                  }
                  placeCount = temp;
                  if(changed)
                  {
                     _placesState = states;
                     dispatchEvent(new RoomEvent("roomplaceChanged"));
                  }
                  return;
               }
               addr149:
               len = 9;
               §§goto(addr220);
            }
            addr148:
            §§goto(addr149);
         }
         §§goto(addr148);
      }
      
      public function updatePlayerState(states:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = players;
         for each(var p in players)
         {
            p.isReady = states[p.place] == 1;
            p.isHost = states[p.place] == 2;
         }
         dispatchEvent(new RoomEvent("playerStateChanged"));
      }
      
      public function setPlayerReadyState(id:int, isReady:Boolean) : void
      {
         findPlayerByID(id).isReady = isReady;
         dispatchEvent(new RoomEvent("playerStateChanged"));
      }
      
      public function updatePlayerTeam(id:int, team:int, place:int) : void
      {
         var p:RoomPlayer = _players[id];
         if(p)
         {
            p.team = team;
            p.place = place;
         }
         dispatchEvent(new RoomEvent("roomplaceChanged"));
      }
      
      public function addPlayer(player:RoomPlayer) : void
      {
         _players.add(player.playerInfo.ID,player);
         dispatchEvent(new RoomEvent("addPlayer",player));
      }
      
      public function removePlayer(zoneID:int, id:int) : RoomPlayer
      {
         if(zoneID != PlayerManager.Instance.Self.ZoneID)
         {
            return null;
         }
         var info:RoomPlayer = players[id];
         if(info)
         {
            _players.remove(id);
            dispatchEvent(new RoomEvent("removePlayer",info));
         }
         return info;
      }
      
      public function findPlayerByID(id:int, zoneID:int = -1) : RoomPlayer
      {
         if(zoneID == -1)
         {
            if(_players[id] && _players[id].playerInfo)
            {
               return _players[id] as RoomPlayer;
            }
            return null;
         }
         if(_players[id] && _players[id].playerInfo && _players[id].playerInfo.ZoneID == zoneID)
         {
            return _players[id] as RoomPlayer;
         }
         return null;
      }
      
      public function findPlayerByPlace(place:int) : RoomPlayer
      {
         var result:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = players;
         for each(var player in players)
         {
            if(player.place == place)
            {
               result = player;
               break;
            }
         }
         return result;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _players;
         for each(var player in _players)
         {
            player.dispose();
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
      
      public function set type(value:int) : void
      {
         if(_type == value)
         {
            return;
         }
         _type = value;
         dispatchEvent(new Event("change"));
      }
      
      public function isYellowBg() : Boolean
      {
         return _type == 4 || _type == 0 || _type == 11 || _type == 21 || _type == 23 || _type == 12 || _type == 13 || _type == 28 || _type == 120 || _type == 68 || _type == 123 || _type == 70 || _type == 58;
      }
      
      public function canShowTitle() : Boolean
      {
         return _type >= 2 && _type != 12 && _type != 13 && _type != 25 && _type != 40;
      }
      
      public function get gameMode() : int
      {
         return _gameMode;
      }
      
      public function set gameMode(value:int) : void
      {
         if(_gameMode == value)
         {
            return;
         }
         _gameMode = value;
         dispatchEvent(new RoomEvent("gameModeChange"));
      }
      
      public function canPlayGuidMode() : Boolean
      {
         var guildID:int = 0;
         if(_players.length - currentViewerCnt <= 1)
         {
            return false;
         }
         if(selfRoomPlayer.isViewer)
         {
            var _loc6_:int = 0;
            var _loc5_:* = players;
            for each(var p in players)
            {
               if(p != selfRoomPlayer)
               {
                  guildID = p.playerInfo.ConsortiaID;
                  break;
               }
            }
         }
         else
         {
            guildID = selfRoomPlayer.playerInfo.ConsortiaID;
         }
         if(guildID <= 0)
         {
            return false;
         }
         var result:Boolean = true;
         var _loc8_:int = 0;
         var _loc7_:* = players;
         for each(var player in players)
         {
            if(!player.isViewer)
            {
               if(player.playerInfo.ConsortiaID != guildID)
               {
                  result = false;
                  break;
               }
            }
         }
         return result;
      }
      
      public function isAllReady() : Boolean
      {
         var result:Boolean = true;
         if(type == 1)
         {
            if(_players.length == 1)
            {
               return false;
            }
         }
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var player in _players)
         {
            if(!player.isReady && !player.isHost && !player.isViewer)
            {
               result = false;
               break;
            }
         }
         return result;
      }
      
      public function getDifficulty(hardlevel:int) : String
      {
         switch(int(hardlevel))
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
      
      public function set mapId(value:int) : void
      {
         if(_mapId == value)
         {
            return;
         }
         _mapId = value;
         dispatchEvent(new RoomEvent("mapChanged"));
      }
      
      public function get timeType() : int
      {
         return _timeType;
      }
      
      public function set timeType(value:int) : void
      {
         if(_timeType == value)
         {
            return;
         }
         _timeType = value;
         dispatchEvent(new RoomEvent("mapTimeChanged"));
      }
      
      public function get hardLevel() : int
      {
         return _hardLevel;
      }
      
      public function set hardLevel(value:int) : void
      {
         if(_hardLevel == value)
         {
            return;
         }
         _hardLevel = value;
         dispatchEvent(new RoomEvent("hardLevelChanged"));
      }
      
      public function get levelLimits() : int
      {
         return _levelLimits;
      }
      
      public function set levelLimits(value:int) : void
      {
         _levelLimits = value;
      }
      
      public function get totalPlayer() : int
      {
         return _totalPlayer;
      }
      
      public function set totalPlayer(value:int) : void
      {
         if(_totalPlayer == value)
         {
            return;
         }
         _totalPlayer = value;
         dispatchEvent(new Event("change"));
      }
      
      public function get currentViewerCnt() : int
      {
         var cnt:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var rp in _players)
         {
            if(rp.isViewer)
            {
               cnt++;
            }
         }
         return cnt;
      }
      
      public function get currentPlayerCount() : int
      {
         var cnt:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var rp in _players)
         {
            if(!rp.isViewer)
            {
               cnt++;
            }
         }
         return cnt;
      }
      
      public function get currentPlayers() : Array
      {
         var players:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _players;
         for each(var rp in _players)
         {
            if(!rp.isViewer)
            {
               players.push(rp);
            }
         }
         return players;
      }
      
      public function get viewerCnt() : int
      {
         return _viewerCnt;
      }
      
      public function set viewerCnt(value:int) : void
      {
         if(_viewerCnt == value)
         {
            return;
         }
         _viewerCnt = value;
         dispatchEvent(new Event("change"));
      }
      
      public function get placeCount() : int
      {
         return _placeCount;
      }
      
      public function set placeCount(value:int) : void
      {
         if(_placeCount == value)
         {
            return;
         }
         _placeCount = value;
         dispatchEvent(new RoomEvent("placeCountChanged"));
      }
      
      public function get started() : Boolean
      {
         return _started;
      }
      
      public function set started(value:Boolean) : void
      {
         if(_started == value)
         {
            return;
         }
         _started = value;
         dispatchEvent(new RoomEvent("startedChanged"));
      }
      
      public function get isCrossZone() : Boolean
      {
         return _isCrossZone;
      }
      
      public function set isCrossZone(value:Boolean) : void
      {
         if(_isCrossZone == value)
         {
            return;
         }
         _isCrossZone = value;
         dispatchEvent(new RoomEvent("allowCrossChange"));
      }
      
      public function resetStates() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _players;
         for each(var player in _players)
         {
            player.isReady = false;
         }
         _started = false;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function set isPlaying(value:Boolean) : void
      {
         _isPlaying = value;
      }
      
      public function get IsLocked() : Boolean
      {
         return _isLocked;
      }
      
      public function set IsLocked(value:Boolean) : void
      {
         _isLocked = value;
      }
      
      public function get dungeonType() : int
      {
         return _dungeonType;
      }
      
      public function set dungeonType(value:int) : void
      {
         if(_dungeonType == value)
         {
            return;
         }
         _dungeonType = value;
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
      
      public function set dungeonMode(value:int) : void
      {
         if(_dungeonMode == value)
         {
            return;
         }
         _dungeonMode = value;
      }
   }
}
