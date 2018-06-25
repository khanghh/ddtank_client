package ddt.manager
{
   import ddt.data.analyze.DungeonAnalyzer;
   import ddt.data.analyze.MapAnalyzer;
   import ddt.data.analyze.WeekOpenMapAnalyze;
   import ddt.data.map.DungeonInfo;
   import ddt.data.map.MapInfo;
   import ddt.data.map.OpenMapInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class MapManager extends EventDispatcher
   {
      
      public static const UPDATE_ACTIVE_PVE_INFO:String = "updateActivePveInfo";
      
      private static var _list:Vector.<MapInfo>;
      
      private static var _list2:DictionaryData;
      
      private static var _openList:Vector.<OpenMapInfo>;
      
      private static var _defaultDungeon:DungeonInfo;
      
      private static var _randomMapInfo1:MapInfo;
      
      private static var _randomMapInfo2:MapInfo;
      
      private static var _randomMapInfo3:MapInfo;
      
      private static var _pveList:Vector.<DungeonInfo>;
      
      private static var _pvpList:Vector.<MapInfo>;
      
      private static var _pveLinkList:Array;
      
      private static var _pveAdvancedList:Array;
      
      private static var _pveBossList:Vector.<DungeonInfo>;
      
      private static var _pveExplrolList:Vector.<DungeonInfo>;
      
      private static var _pvpComplectiList:Vector.<MapInfo>;
      
      private static var _fightLibList:Vector.<DungeonInfo>;
      
      private static var _pveAcademyList:Vector.<DungeonInfo>;
      
      private static var _pveActivityList:Vector.<DungeonInfo>;
      
      private static var _pveSingleLinkList:Vector.<DungeonInfo>;
      
      private static var _pveBraveDoorList:Vector.<DungeonInfo>;
      
      private static var _pveDreamLandList:Vector.<DungeonInfo>;
      
      public static const PVP_TRAIN_MAP:int = 1;
      
      public static const PVP_TRAIN_MAP2:int = 25;
      
      public static const PVP_COMPECTI_MAP:int = 0;
      
      public static const PVE_EXPROL_MAP:int = 2;
      
      public static const PVE_BOSS_MAP:int = 3;
      
      public static const PVE_LINK_MAP:int = 4;
      
      public static const FIGHT_LIB:int = 5;
      
      public static const PVE_ACADEMY_MAP:int = 6;
      
      public static const PVE_ACTIVITY_MAP:int = 21;
      
      public static const PVE_SINGLELINK_MAP:int = 14;
      
      public static const PVE_BRAVEDOOR_MAP:int = 22;
      
      public static const PVE_BATTLE_MAP:int = 24;
      
      public static const PVE_ADVANCED_MAP:Array = [13];
      
      private static const PROVING_ROUNDID:int = -2;
      
      public static const PVE_DREAMLAND_MAP:int = 70;
      
      public static const PVE_SPECIAL_MAP:int = 23;
      
      public static const DOUBLE_SPECIAL1:int = 47;
      
      public static const DOUBLE_SPECIAL2:int = 48;
      
      public static const PVE_MAP:int = 5;
      
      public static const PVP_MAP:int = 6;
      
      private static var _instance:MapManager;
       
      
      public var curMapCardLabelType:int = 0;
      
      private var _activeDoubleIds:Array;
      
      private var _activeDoubleDic:Dictionary;
      
      private var _singleDoubleIds:Array;
      
      private var _singleDoubleDic:Dictionary;
      
      public function MapManager()
      {
         _activeDoubleIds = [19,20,21,22,23,24,29];
         _activeDoubleDic = new Dictionary();
         _singleDoubleIds = [15,16,17,18,25,26,28];
         _singleDoubleDic = new Dictionary();
         super();
      }
      
      public static function getListByType(type:int = 0) : *
      {
         if(type == 1)
         {
            return _list;
         }
         if(type == 5)
         {
            return _pveList;
         }
         if(type == 4)
         {
            return _pveLinkList;
         }
         if(type == 3)
         {
            return _pveBossList;
         }
         if(type == 2)
         {
            return _pveExplrolList;
         }
         if(type == 0)
         {
            return _pvpComplectiList;
         }
         if(type == 6)
         {
            return _pvpList;
         }
         if(type == 5)
         {
            return _fightLibList;
         }
         if(type == 6)
         {
            return _pveAcademyList;
         }
         if(type == 21 || type == 23 || type == 47 || type == 48 || type == 24)
         {
            return _pveActivityList;
         }
         if(type == 14)
         {
            return _pveSingleLinkList;
         }
         if(type == 22)
         {
            return _pveBraveDoorList;
         }
         if(type == 25)
         {
            return _list2;
         }
         if(type == 70)
         {
            return _pveDreamLandList;
         }
         return null;
      }
      
      public static function getAdvancedList() : Array
      {
         return _pveAdvancedList;
      }
      
      public static function setupMapInfo(analyzer:MapAnalyzer) : void
      {
         _list2 = new DictionaryData();
         createRandomMapInfo();
         _list = analyzer.list;
         _pvpList = _list.slice();
         _list.unshift(_randomMapInfo3);
         _list.unshift(_randomMapInfo1);
         _pvpComplectiList = new Vector.<MapInfo>();
         _pvpComplectiList.push(_randomMapInfo1);
         _pvpComplectiList.push(_randomMapInfo3);
      }
      
      private static function createRandomMapInfo() : void
      {
         _randomMapInfo1 = new MapInfo();
         _randomMapInfo1.ID = 0;
         _randomMapInfo1.isOpen = true;
         _randomMapInfo1.canSelect = true;
         _randomMapInfo1.Name = LanguageMgr.GetTranslation("tank.manager.MapManager.random");
         _randomMapInfo1.Description = LanguageMgr.GetTranslation("tank.manager.MapManager.random");
         _randomMapInfo3 = new MapInfo();
         _randomMapInfo3.ID = 6001;
         _randomMapInfo3.isOpen = true;
         _randomMapInfo3.canSelect = true;
         _randomMapInfo3.Name = LanguageMgr.GetTranslation("tank.manager.MapManager.randomEscape");
         _randomMapInfo3.Description = LanguageMgr.GetTranslation("tank.manager.MapManager.randomEscape");
      }
      
      public static function setupDungeonInfo(analyzer:DungeonAnalyzer) : void
      {
         var i:int = 0;
         var info:* = null;
         _defaultDungeon = new DungeonInfo();
         _defaultDungeon.ID = 10000;
         _defaultDungeon.Description = LanguageMgr.GetTranslation("tank.manager.selectDuplicate");
         _defaultDungeon.isOpen = true;
         _defaultDungeon.Name = LanguageMgr.GetTranslation("tank.manager.selectDuplicate");
         _defaultDungeon.Type = 4;
         _defaultDungeon.Ordering = -1;
         _pveList = analyzer.list;
         _pveLinkList = [];
         _pveAdvancedList = [];
         _pveBossList = new Vector.<DungeonInfo>();
         _pveExplrolList = new Vector.<DungeonInfo>();
         _fightLibList = new Vector.<DungeonInfo>();
         _pveAcademyList = new Vector.<DungeonInfo>();
         _pveActivityList = new Vector.<DungeonInfo>();
         _pveSingleLinkList = new Vector.<DungeonInfo>();
         _pveBraveDoorList = new Vector.<DungeonInfo>();
         _pveDreamLandList = new Vector.<DungeonInfo>();
         for(i = 0; i < _pveList.length; )
         {
            info = _pveList[i];
            if(MapManager.PVE_ADVANCED_MAP.indexOf(info.ID) != -1 || PathManager.footballEnable && info.ID == 14)
            {
               _pveAdvancedList.push(info);
            }
            else if(info.Type == 4)
            {
               _pveLinkList.push(info);
            }
            else if(info.Type == 3)
            {
               _pveBossList.push(info);
            }
            else if(info.Type == 2)
            {
               _pveExplrolList.push(info);
            }
            else if(info.Type == 5)
            {
               _fightLibList.push(info);
            }
            else if(info.Type == 6)
            {
               _pveAcademyList.push(info);
            }
            else if(info.Type == 21 || info.Type == 23 || info.Type == 47 || info.Type == 48 || info.Type == 24)
            {
               _pveActivityList.push(info);
            }
            else if(info.Type == 14)
            {
               _pveSingleLinkList.push(info);
            }
            else if(info.Type == 22)
            {
               _pveBraveDoorList.push(info);
            }
            else if(info.Type == 70)
            {
               _pveDreamLandList.push(info);
            }
            i++;
         }
         _pveLinkList.unshift(_defaultDungeon);
         _pveAdvancedList.unshift(_defaultDungeon);
         _pveBossList.unshift(_defaultDungeon);
      }
      
      public static function setupOpenMapInfo(analyzer:WeekOpenMapAnalyze) : void
      {
         _openList = analyzer.list;
         buildMap();
      }
      
      public static function buildMap() : void
      {
         var currentMaps:* = null;
         var provingGroundsMaps:* = null;
         var i:* = 0;
         if(_openList == null || _list == null || ServerManager.Instance.current == null)
         {
            return;
         }
         i = uint(0);
         while(i < _openList.length)
         {
            if(_openList[i].serverID == ServerManager.Instance.current.ID)
            {
               currentMaps = _openList[i].maps;
            }
            else if(_openList[i].serverID == -2)
            {
               provingGroundsMaps = _openList[i].maps;
            }
            i++;
         }
         _list2.add(0,new Vector.<MapInfo>());
         _list2.add(1,new Vector.<MapInfo>());
         _list2.add(2,new Vector.<MapInfo>());
         if(_openList && _list && currentMaps)
         {
            _list.splice(_list.indexOf(_randomMapInfo3),1);
            _list.splice(_list.indexOf(_randomMapInfo1),1);
            var _loc6_:int = 0;
            var _loc5_:* = _list;
            for each(var info in _list)
            {
               info.isOpen = currentMaps.indexOf(String(info.ID)) > -1;
               if(info.isOpen)
               {
                  _list2[0].push(info);
               }
               if(provingGroundsMaps.indexOf(String(info.ID)) > -1)
               {
                  _list2[1].push(info);
               }
            }
            _list2[0].unshift(_randomMapInfo1);
            _list2[2].unshift(_randomMapInfo3);
            _list.unshift(_randomMapInfo3);
            _list.unshift(_randomMapInfo1);
         }
      }
      
      public static function isMapOpen(id:int) : Boolean
      {
         return getMapInfo(id).isOpen;
      }
      
      public static function getMapInfo(id:Number) : MapInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var info in _list)
         {
            if(info.ID == id)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getDungeonInfo(id:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveList;
         for each(var info in _pveList)
         {
            if(info.ID == id)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getDreamLandDupInfoByOrder(ordering:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveDreamLandList;
         for each(var info in _pveDreamLandList)
         {
            if(info.Ordering == ordering)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getByOrderingDungeonInfo(ordering:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveLinkList;
         for each(var info in _pveLinkList)
         {
            if(info.Ordering == ordering)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getByOrderingAdvancedDungeonInfo(ordering:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveAdvancedList;
         for each(var info in _pveAdvancedList)
         {
            if(info.Ordering == ordering)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getDreamLandDupInfoById(id:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveDreamLandList;
         for each(var info in _pveDreamLandList)
         {
            if(info.ID == id)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getByOrderingAcademyDungeonInfo(ordering:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveAcademyList;
         for each(var info in _pveAcademyList)
         {
            if(info.Ordering == ordering)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getByOrderingActivityDungeonInfo(ordering:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveActivityList;
         for each(var info in _pveActivityList)
         {
            if(info.Ordering == ordering)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getByOrderingNightmareDungeonInfo(ordering:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveLinkList;
         for each(var info in _pveLinkList)
         {
            if(info.Ordering == ordering && info.NightmareTemplateIds)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getByOrderingSingleDungeonInfo(ordering:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveSingleLinkList;
         for each(var info in _pveSingleLinkList)
         {
            if(info.Ordering == ordering)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getBraveDoorDuplicateInfo(id:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveBraveDoorList;
         for each(var info in _pveBraveDoorList)
         {
            if(info.ID == id)
            {
               return info;
            }
         }
         return null;
      }
      
      public static function getFightLibList() : Vector.<DungeonInfo>
      {
         return _fightLibList;
      }
      
      public static function getMapName(id:int) : String
      {
         var info:DungeonInfo = getDungeonInfo(id);
         if(info)
         {
            return info.Name;
         }
         var m_info:MapInfo = getMapInfo(id);
         if(m_info)
         {
            return m_info.Name;
         }
         return "";
      }
      
      public static function get Instance() : MapManager
      {
         if(_instance == null)
         {
            _instance = new MapManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(342),onActivePveInfo);
      }
      
      private function onActivePveInfo(evt:PkgEvent) : void
      {
         var i:int = 0;
         var dungeonId:int = 0;
         var startDate:* = null;
         var endDate:* = null;
         var isDouble:Boolean = false;
         var j:int = 0;
         var dungeonId2:int = 0;
         var startDate2:* = null;
         var endDate2:* = null;
         var isDouble2:Boolean = false;
         var pkg:PackageIn = evt.pkg;
         var nowTime:Number = TimeManager.Instance.Now().time;
         _activeDoubleDic = new Dictionary();
         for(i = 0; i < _activeDoubleIds.length; )
         {
            dungeonId = _activeDoubleIds[i];
            startDate = pkg.readDate();
            endDate = pkg.readDate();
            isDouble = pkg.readBoolean();
            if(nowTime >= startDate.time && nowTime < endDate.time)
            {
               trace("open activeDungeon id: " + dungeonId);
               _activeDoubleDic[dungeonId] = {
                  "startDate":startDate,
                  "endDate":endDate,
                  "isDouble":isDouble
               };
            }
            i++;
         }
         _singleDoubleDic = new Dictionary();
         for(j = 0; j < _singleDoubleIds.length; )
         {
            dungeonId2 = _singleDoubleIds[j];
            startDate2 = pkg.readDate();
            endDate2 = pkg.readDate();
            isDouble2 = pkg.readBoolean();
            if(nowTime >= startDate2.time && nowTime < endDate2.time)
            {
               trace("open singleDungeon id: " + dungeonId2);
               _singleDoubleDic[dungeonId2] = {
                  "startDate":startDate2,
                  "endDate":endDate2,
                  "isDouble":isDouble2
               };
            }
            j++;
         }
         dispatchEvent(new CEvent("updateActivePveInfo"));
      }
      
      public function checkActiveAndSigleDic(dic:Dictionary, nowTime:Number) : Boolean
      {
         var bool:Boolean = false;
         var obj:* = null;
         var startDate:* = null;
         var endDate:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = dic;
         for(var key in dic)
         {
            obj = dic[key];
            startDate = obj.startDate;
            endDate = obj.endDate;
            if(nowTime < startDate.time || nowTime >= endDate.time)
            {
               bool = true;
               delete dic[key];
            }
         }
         return bool;
      }
      
      public function get activeDoubleDic() : Dictionary
      {
         return _activeDoubleDic;
      }
      
      public function get singleDoubleDic() : Dictionary
      {
         return _singleDoubleDic;
      }
      
      public function get activeDoubleIds() : Array
      {
         return _activeDoubleIds;
      }
      
      public function get singleDoubleIds() : Array
      {
         return _singleDoubleIds;
      }
   }
}
