package gameCommon.model
{
   import ddt.data.map.MissionInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.GameEvent;
   import ddt.loader.MapLoader;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
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
      
      public var exitTimes:int;
      
      public var exitTimeLimit:int;
      
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
      
      public function set mapIndex(value:int) : void
      {
         _mapIndex = value;
      }
      
      public function get isWeather() : Boolean
      {
         return _mapIndex == 1455 || _mapIndex == 1456 || _mapIndex == 1457;
      }
      
      public function get teams() : DictionaryData
      {
         return _teams;
      }
      
      public function set teams(value:DictionaryData) : void
      {
         _teams = value;
      }
      
      public function set gameMode(value:int) : void
      {
         _gameMode = value;
      }
      
      public function get gameMode() : int
      {
         return _gameMode;
      }
      
      public function get resultCard() : Array
      {
         return _resultCard;
      }
      
      public function set resultCard(arr:Array) : void
      {
         _resultCard = arr;
      }
      
      public function get missionInfo() : MissionInfo
      {
         return _missionInfo;
      }
      
      public function set missionInfo(value:MissionInfo) : void
      {
         _missionInfo = value;
      }
      
      public function resetBossCardCnt() : void
      {
         var player:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = livings;
         for each(var living in livings)
         {
            player = living as Player;
            if(player)
            {
               player.BossCardCount = 0;
               player.GetCardCount = 0;
            }
         }
      }
      
      public function addGamePlayer(info:Living) : void
      {
         var p:Living = livings[info.LivingID];
         if(p)
         {
            p.dispose();
         }
         if(info is LocalPlayer)
         {
            _selfGamePlayer = info as LocalPlayer;
         }
         livings.add(info.LivingID,info);
         addTeamPlayer(info);
      }
      
      public function addGameViewer(info:Living) : void
      {
         var p:Living = viewers[info.playerInfo.ID];
         if(p)
         {
            p.dispose();
         }
         if(info is LocalPlayer)
         {
            _selfGamePlayer = info as LocalPlayer;
         }
         viewers.add(info.playerInfo.ID,info);
      }
      
      public function viewerToLiving(playerID:int) : void
      {
         var player:Living = viewers[playerID];
         if(player)
         {
            viewers.remove(playerID);
            if(player is LocalPlayer)
            {
               _selfGamePlayer = player as LocalPlayer;
            }
            livings.add(player.LivingID,player);
            addTeamPlayer(player);
         }
      }
      
      public function livingToViewer(playerID:int, zoneID:int) : void
      {
         var player:Living = findLivingByPlayerID(playerID,zoneID);
         if(player)
         {
            livings.remove(player.LivingID);
            removeTeamPlayer(player);
            if(player is LocalPlayer)
            {
               _selfGamePlayer = player as LocalPlayer;
            }
            viewers.add(playerID,player);
         }
      }
      
      public function addTeamPlayer(info:Living) : void
      {
         var team:DictionaryData = new DictionaryData();
         if(teams[info.team] == null)
         {
            team = new DictionaryData();
            teams[info.team] = team;
         }
         else
         {
            team = teams[info.team];
         }
         if(team[info.LivingID] == null)
         {
            team.add(info.LivingID,info);
         }
      }
      
      public function removeTeamPlayer(info:Living) : void
      {
         var team:DictionaryData = teams[info.team];
         if(team && team[info.LivingID])
         {
            team.remove(info.LivingID);
         }
      }
      
      public function setSelfGamePlayer(info:Living) : void
      {
         _selfGamePlayer = info as LocalPlayer;
      }
      
      public function removeGamePlayer(livingID:int) : Living
      {
         var info:Living = livings[livingID];
         if(info)
         {
            removeTeamPlayer(info);
            livings.remove(livingID);
            info.dispose();
         }
         return info;
      }
      
      public function removeGamePlayerByPlayerID(zoneID:int, playerID:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = livings;
         for each(var living in livings)
         {
            if(living is Player && living.playerInfo)
            {
               if(living.playerInfo.ZoneID == zoneID && living.playerInfo.ID == playerID)
               {
                  livings.remove(living.LivingID);
                  living.dispose();
               }
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = viewers;
         for each(var viewer in viewers)
         {
            if(viewer.playerInfo.ZoneID == zoneID && viewer.playerInfo.ID == playerID)
            {
               viewers.remove(viewer.playerInfo.ID);
               viewer.dispose();
            }
         }
      }
      
      public function isAllReady() : Boolean
      {
         var allReady:Boolean = true;
         var _loc4_:int = 0;
         var _loc3_:* = livings;
         for each(var info in livings)
         {
            if(info.isReady == false)
            {
               allReady = false;
               break;
            }
         }
         return allReady;
      }
      
      public function findPlayer(livingID:int) : Player
      {
         return livings[livingID] as Player;
      }
      
      public function findPlayerByPlayerID(playerid:int) : Player
      {
         var _loc4_:int = 0;
         var _loc3_:* = livings;
         for each(var i in livings)
         {
            if(i.isPlayer() && i.playerInfo.ID == playerid)
            {
               return i as Player;
            }
         }
         return null;
      }
      
      public function findGamerbyPlayerId(playerid:int) : Player
      {
         var _loc5_:int = 0;
         var _loc4_:* = livings;
         for each(var i in livings)
         {
            if(i.isPlayer() && i.playerInfo.ID == playerid)
            {
               return i as Player;
            }
         }
         var _loc7_:int = 0;
         var _loc6_:* = viewers;
         for each(var v in viewers)
         {
            if(v.playerInfo.ID == playerid)
            {
               return v as Player;
            }
         }
         return null;
      }
      
      public function get haveAllias() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = livings;
         for each(var info in livings)
         {
            if(info.isLiving && info.team == selfGamePlayer.team)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get allias() : Vector.<Player>
      {
         var i:int = 0;
         var item:* = null;
         var item1:* = null;
         var players:Vector.<Player> = new Vector.<Player>();
         for(i = 0; i < roomPlayers.length; )
         {
            item = roomPlayers[i] as RoomPlayer;
            if(item)
            {
               item1 = findPlayerByPlayerID(item.playerInfo.ID);
               if(item1 && item1.team == selfGamePlayer.team && item1 != selfGamePlayer && item1.expObj)
               {
                  players.push(item1);
               }
            }
            i++;
         }
         return players;
      }
      
      public function findLiving(livingID:int) : Living
      {
         return livings[livingID];
      }
      
      public function findLivingByName(name:String) : Living
      {
         var _loc4_:int = 0;
         var _loc3_:* = livings;
         for each(var info in livings)
         {
            if(info.isLiving && info.name == name)
            {
               return info;
            }
         }
         return null;
      }
      
      public function findTeam(id:int) : DictionaryData
      {
         return teams[id];
      }
      
      public function resetWithinTheMap() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = livings;
         for each(var living in livings)
         {
            living.resetWithinTheMap();
         }
      }
      
      public function findLivingByPlayerID(playerID:int, zoneID:int) : Player
      {
         var _loc5_:int = 0;
         var _loc4_:* = livings;
         for each(var living in livings)
         {
            if(living is Player && living.playerInfo)
            {
               if(living.playerInfo.ID == playerID && living.playerInfo.ZoneID == zoneID)
               {
                  return living as Player;
               }
            }
         }
         return null;
      }
      
      public function removeAllMonsters() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = livings;
         for each(var living in livings)
         {
            if(!(living is Player))
            {
               livings.remove(living.LivingID);
               living.dispose();
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
      
      public function addRoomPlayer(info:RoomPlayer) : void
      {
         var index:int = roomPlayers.indexOf(info);
         if(index > -1)
         {
            removeRoomPlayer(info.playerInfo.ZoneID,info.playerInfo.ID);
         }
         roomPlayers.push(info);
      }
      
      public function removeRoomPlayer(zoneID:int, playerID:int) : void
      {
         var info:RoomPlayer = findRoomPlayer(playerID,zoneID);
         if(info)
         {
            roomPlayers.splice(roomPlayers.indexOf(info),1);
         }
      }
      
      public function findRoomPlayer(userID:int, zoneID:int) : RoomPlayer
      {
         var _loc5_:int = 0;
         var _loc4_:* = roomPlayers;
         for each(var rp in roomPlayers)
         {
            if(rp.playerInfo != null)
            {
               if(rp.playerInfo.ID == userID && rp.playerInfo.ZoneID == zoneID)
               {
                  return rp;
               }
            }
         }
         return null;
      }
      
      public function setWind(value:Number, isSelfTurn:Boolean = false, arr:Array = null) : void
      {
         _wind = Number(value.toFixed(1));
         dispatchEvent(new GameEvent("windChanged",{
            "wind":_wind,
            "isSelfTurn":isSelfTurn,
            "windNumArr":arr
         }));
      }
      
      public function get wind() : Number
      {
         return _wind;
      }
      
      public function set windRate(value:Number) : void
      {
         _windRate = value;
      }
      
      public function get windRate() : Number
      {
         return _windRate;
      }
      
      public function get hasNextMission() : Boolean
      {
         return _hasNextMission;
      }
      
      public function set hasNextMission(value:Boolean) : void
      {
         if(_hasNextMission == value)
         {
            return;
         }
         _hasNextMission = value;
      }
      
      public function resetResultCard() : void
      {
         _resultCard = [];
      }
      
      public function getRoomPlayerByID(id:int, zoneID:int) : RoomPlayer
      {
         var _loc5_:int = 0;
         var _loc4_:* = roomPlayers;
         for each(var p in roomPlayers)
         {
            if(p.playerInfo.ID == id && p.playerInfo.ZoneID == zoneID)
            {
               return p;
            }
         }
         return null;
      }
      
      public function getOutBombsIdList() : Array
      {
         var arr:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = outBombs;
         for each(var item in outBombs)
         {
            if(arr.indexOf(item.Id) == -1)
            {
               arr.push(item.Id);
            }
         }
         return arr;
      }
      
      public function get isHasOneDead() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = livings;
         for each(var living in livings)
         {
            if(living is Player && living.team == selfGamePlayer.team && !living.isLiving)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getGuardCoreBuffList() : Array
      {
         var player:* = null;
         var info:* = null;
         var isCheck:Boolean = false;
         var i:int = 0;
         var listInfo:* = null;
         var list:Array = [];
         var _loc9_:int = 0;
         var _loc8_:* = livings;
         for each(var living in livings)
         {
            player = living as Player;
            if(player)
            {
               info = GuardCoreManager.instance.getGuardCoreInfoByID(player.playerInfo.guardCoreID);
               if(info && info.GainGrade <= player.playerInfo.Grade)
               {
                  if(player.team == selfGamePlayer.team && info.GroupType == 1 && !player.isSelf || player.team != selfGamePlayer.team && info.GroupType == 2 && !player.isSelf || player.isSelf && (info.GroupType == 0 || info.GroupType == 1))
                  {
                     if(info.KeepTurn == 0 || selfGamePlayer.turnCount <= info.KeepTurn)
                     {
                        isCheck = false;
                        for(i = 0; i < list.length; )
                        {
                           listInfo = list[i] as GuardCoreInfo;
                           if(listInfo.Type == info.Type)
                           {
                              if(info.SkillGrade > listInfo.SkillGrade)
                              {
                                 list[i] = info;
                              }
                              isCheck = true;
                              break;
                           }
                           i++;
                        }
                        if(!isCheck)
                        {
                           list.push(info);
                        }
                     }
                  }
               }
            }
         }
         return list;
      }
      
      public function get guardCoreEnable() : Boolean
      {
         return _guardCoreEnable;
      }
      
      public function set guardCoreEnable(value:Boolean) : void
      {
         _guardCoreEnable = value;
      }
      
      public function dispose() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = roomPlayers;
         for each(var player in roomPlayers)
         {
            if(RoomManager.Instance.current.players.list.indexOf(player) == -1)
            {
               player.dispose();
            }
            else
            {
               player.claerMovie3D();
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
            for each(var i in livings)
            {
               i.dispose();
               i = null;
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
      
      public function get togetherShoot() : Boolean
      {
         if(_mapIndex == 1618 || roomType == 21)
         {
            return true;
         }
         return false;
      }
      
      public function get weatherType() : int
      {
         return _weatherType;
      }
      
      public function set weatherType(value:int) : void
      {
         _weatherType = value;
      }
   }
}
