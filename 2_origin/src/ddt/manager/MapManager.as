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
      
      public static function getListByType(param1:int = 0) : *
      {
         if(param1 == 1)
         {
            return _list;
         }
         if(param1 == 5)
         {
            return _pveList;
         }
         if(param1 == 4)
         {
            return _pveLinkList;
         }
         if(param1 == 3)
         {
            return _pveBossList;
         }
         if(param1 == 2)
         {
            return _pveExplrolList;
         }
         if(param1 == 0)
         {
            return _pvpComplectiList;
         }
         if(param1 == 6)
         {
            return _pvpList;
         }
         if(param1 == 5)
         {
            return _fightLibList;
         }
         if(param1 == 6)
         {
            return _pveAcademyList;
         }
         if(param1 == 21 || param1 == 23 || param1 == 47 || param1 == 48 || param1 == 24)
         {
            return _pveActivityList;
         }
         if(param1 == 14)
         {
            return _pveSingleLinkList;
         }
         if(param1 == 22)
         {
            return _pveBraveDoorList;
         }
         if(param1 == 25)
         {
            return _list2;
         }
         return null;
      }
      
      public static function getAdvancedList() : Array
      {
         return _pveAdvancedList;
      }
      
      public static function setupMapInfo(param1:MapAnalyzer) : void
      {
         _list2 = new DictionaryData();
         createRandomMapInfo();
         _list = param1.list;
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
      
      public static function setupDungeonInfo(param1:DungeonAnalyzer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _defaultDungeon = new DungeonInfo();
         _defaultDungeon.ID = 10000;
         _defaultDungeon.Description = LanguageMgr.GetTranslation("tank.manager.selectDuplicate");
         _defaultDungeon.isOpen = true;
         _defaultDungeon.Name = LanguageMgr.GetTranslation("tank.manager.selectDuplicate");
         _defaultDungeon.Type = 4;
         _defaultDungeon.Ordering = -1;
         _pveList = param1.list;
         _pveLinkList = [];
         _pveAdvancedList = [];
         _pveBossList = new Vector.<DungeonInfo>();
         _pveExplrolList = new Vector.<DungeonInfo>();
         _fightLibList = new Vector.<DungeonInfo>();
         _pveAcademyList = new Vector.<DungeonInfo>();
         _pveActivityList = new Vector.<DungeonInfo>();
         _pveSingleLinkList = new Vector.<DungeonInfo>();
         _pveBraveDoorList = new Vector.<DungeonInfo>();
         _loc3_ = 0;
         while(_loc3_ < _pveList.length)
         {
            _loc2_ = _pveList[_loc3_];
            if(MapManager.PVE_ADVANCED_MAP.indexOf(_loc2_.ID) != -1 || PathManager.footballEnable && _loc2_.ID == 14)
            {
               _pveAdvancedList.push(_loc2_);
            }
            else if(_loc2_.Type == 4)
            {
               _pveLinkList.push(_loc2_);
            }
            else if(_loc2_.Type == 3)
            {
               _pveBossList.push(_loc2_);
            }
            else if(_loc2_.Type == 2)
            {
               _pveExplrolList.push(_loc2_);
            }
            else if(_loc2_.Type == 5)
            {
               _fightLibList.push(_loc2_);
            }
            else if(_loc2_.Type == 6)
            {
               _pveAcademyList.push(_loc2_);
            }
            else if(_loc2_.Type == 21 || _loc2_.Type == 23 || _loc2_.Type == 47 || _loc2_.Type == 48 || _loc2_.Type == 24)
            {
               _pveActivityList.push(_loc2_);
            }
            else if(_loc2_.Type == 14)
            {
               _pveSingleLinkList.push(_loc2_);
            }
            else if(_loc2_.Type == 22)
            {
               _pveBraveDoorList.push(_loc2_);
            }
            _loc3_++;
         }
         _pveLinkList.unshift(_defaultDungeon);
         _pveAdvancedList.unshift(_defaultDungeon);
         _pveBossList.unshift(_defaultDungeon);
      }
      
      public static function setupOpenMapInfo(param1:WeekOpenMapAnalyze) : void
      {
         _openList = param1.list;
         buildMap();
      }
      
      public static function buildMap() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = 0;
         if(_openList == null || _list == null || ServerManager.Instance.current == null)
         {
            return;
         }
         _loc4_ = uint(0);
         while(_loc4_ < _openList.length)
         {
            if(_openList[_loc4_].serverID == ServerManager.Instance.current.ID)
            {
               _loc1_ = _openList[_loc4_].maps;
            }
            else if(_openList[_loc4_].serverID == -2)
            {
               _loc2_ = _openList[_loc4_].maps;
            }
            _loc4_++;
         }
         _list2.add(0,new Vector.<MapInfo>());
         _list2.add(1,new Vector.<MapInfo>());
         _list2.add(2,new Vector.<MapInfo>());
         if(_openList && _list && _loc1_)
         {
            _list.splice(_list.indexOf(_randomMapInfo3),1);
            _list.splice(_list.indexOf(_randomMapInfo1),1);
            var _loc6_:int = 0;
            var _loc5_:* = _list;
            for each(var _loc3_ in _list)
            {
               _loc3_.isOpen = _loc1_.indexOf(String(_loc3_.ID)) > -1;
               if(_loc3_.isOpen)
               {
                  _list2[0].push(_loc3_);
               }
               if(_loc2_.indexOf(String(_loc3_.ID)) > -1)
               {
                  _list2[1].push(_loc3_);
               }
            }
            _list2[0].unshift(_randomMapInfo1);
            _list2[2].unshift(_randomMapInfo3);
            _list.unshift(_randomMapInfo3);
            _list.unshift(_randomMapInfo1);
         }
      }
      
      public static function isMapOpen(param1:int) : Boolean
      {
         return getMapInfo(param1).isOpen;
      }
      
      public static function getMapInfo(param1:Number) : MapInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var _loc2_ in _list)
         {
            if(_loc2_.ID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getDungeonInfo(param1:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveList;
         for each(var _loc2_ in _pveList)
         {
            if(_loc2_.ID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getByOrderingDungeonInfo(param1:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveLinkList;
         for each(var _loc2_ in _pveLinkList)
         {
            if(_loc2_.Ordering == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getByOrderingAdvancedDungeonInfo(param1:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveAdvancedList;
         for each(var _loc2_ in _pveAdvancedList)
         {
            if(_loc2_.Ordering == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getByOrderingAcademyDungeonInfo(param1:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveAcademyList;
         for each(var _loc2_ in _pveAcademyList)
         {
            if(_loc2_.Ordering == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getByOrderingActivityDungeonInfo(param1:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveActivityList;
         for each(var _loc2_ in _pveActivityList)
         {
            if(_loc2_.Ordering == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getByOrderingNightmareDungeonInfo(param1:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveLinkList;
         for each(var _loc2_ in _pveLinkList)
         {
            if(_loc2_.Ordering == param1 && _loc2_.NightmareTemplateIds)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getByOrderingSingleDungeonInfo(param1:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveSingleLinkList;
         for each(var _loc2_ in _pveSingleLinkList)
         {
            if(_loc2_.Ordering == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getBraveDoorDuplicateInfo(param1:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _pveBraveDoorList;
         for each(var _loc2_ in _pveBraveDoorList)
         {
            if(_loc2_.ID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getFightLibList() : Vector.<DungeonInfo>
      {
         return _fightLibList;
      }
      
      public static function getMapName(param1:int) : String
      {
         var _loc3_:DungeonInfo = getDungeonInfo(param1);
         if(_loc3_)
         {
            return _loc3_.Name;
         }
         var _loc2_:MapInfo = getMapInfo(param1);
         if(_loc2_)
         {
            return _loc2_.Name;
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
      
      private function onActivePveInfo(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc9_:Boolean = false;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc3_:Boolean = false;
         var _loc4_:PackageIn = param1.pkg;
         var _loc7_:Number = TimeManager.Instance.Now().time;
         _activeDoubleDic = new Dictionary();
         _loc8_ = 0;
         while(_loc8_ < _activeDoubleIds.length)
         {
            _loc10_ = _activeDoubleIds[_loc8_];
            _loc2_ = _loc4_.readDate();
            _loc5_ = _loc4_.readDate();
            _loc9_ = _loc4_.readBoolean();
            if(_loc7_ >= _loc2_.time && _loc7_ < _loc5_.time)
            {
               trace("open activeDungeon id: " + _loc10_);
               _activeDoubleDic[_loc10_] = {
                  "startDate":_loc2_,
                  "endDate":_loc5_,
                  "isDouble":_loc9_
               };
            }
            _loc8_++;
         }
         _singleDoubleDic = new Dictionary();
         _loc6_ = 0;
         while(_loc6_ < _singleDoubleIds.length)
         {
            _loc11_ = _singleDoubleIds[_loc6_];
            _loc12_ = _loc4_.readDate();
            _loc13_ = _loc4_.readDate();
            _loc3_ = _loc4_.readBoolean();
            if(_loc7_ >= _loc12_.time && _loc7_ < _loc13_.time)
            {
               trace("open singleDungeon id: " + _loc11_);
               _singleDoubleDic[_loc11_] = {
                  "startDate":_loc12_,
                  "endDate":_loc13_,
                  "isDouble":_loc3_
               };
            }
            _loc6_++;
         }
         dispatchEvent(new CEvent("updateActivePveInfo"));
      }
      
      public function checkActiveAndSigleDic(param1:Dictionary, param2:Number) : Boolean
      {
         var _loc6_:Boolean = false;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for(var _loc7_ in param1)
         {
            _loc5_ = param1[_loc7_];
            _loc3_ = _loc5_.startDate;
            _loc4_ = _loc5_.endDate;
            if(param2 < _loc3_.time || param2 >= _loc4_.time)
            {
               _loc6_ = true;
               delete param1[_loc7_];
            }
         }
         return _loc6_;
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
