package fightLib
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import ddt.data.analyze.FightLibAwardAnalyzer;
   import ddt.data.fightLib.FightLibAwardInfo;
   import ddt.data.fightLib.FightLibInfo;
   import ddt.data.map.DungeonInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.utils.RequestVairableCreater;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import road7th.comm.PackageIn;
   
   public class FightLibManager extends EventDispatcher
   {
      
      private static const PATH:String = "FightLabDropItemList.xml";
      
      public static const GAINAWARD:String = "gainAward";
      
      private static var _ins:FightLibManager;
       
      
      private var _currentInfo:FightLibInfo;
      
      public var lastInfo:FightLibInfo;
      
      private var _lastWin:Boolean = false;
      
      private var _awardList:Array;
      
      private var _reAnswerNum:int;
      
      private var _isWork:Boolean;
      
      public function FightLibManager(singletonFocer:SingletonFocer)
      {
         super();
         addEvent();
      }
      
      public static function get Instance() : FightLibManager
      {
         if(_ins == null)
         {
            _ins = new FightLibManager(new SingletonFocer());
         }
         return _ins;
      }
      
      public function set isWork(value:Boolean) : void
      {
         _isWork = value;
      }
      
      public function get isWork() : Boolean
      {
         return _isWork;
      }
      
      public function get lastWin() : Boolean
      {
         return _lastWin;
      }
      
      public function set lastWin(val:Boolean) : void
      {
         _lastWin = val;
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener("fightLibInfoChange",__infoChange);
      }
      
      private function __infoChange(evt:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var id:int = pkg.readInt();
         var difficulty:int = pkg.readInt();
         currentInfoID = id;
         currentInfo.beginChange();
         currentInfo.difficulty = difficulty;
         var info:DungeonInfo = findDungInfoByID(id);
         currentInfo.commitChange();
      }
      
      private function findDungInfoByID(id:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = MapManager.getFightLibList();
         for each(var info in MapManager.getFightLibList())
         {
            if(info.ID == id)
            {
               return info;
            }
         }
         return null;
      }
      
      public function getFightLibInfoByID(id:int) : FightLibInfo
      {
         var fightInfo:* = null;
         var info:DungeonInfo = findDungInfoByID(id);
         if(info)
         {
            fightInfo = new FightLibInfo();
            fightInfo.beginChange();
            fightInfo.id = info.ID;
            fightInfo.description = info.Description;
            fightInfo.name = info.Name;
            fightInfo.difficulty = -1;
            fightInfo.requiedLevel = info.LevelLimits;
            fightInfo.mapID = int(info.Pic);
            fightInfo.commitChange();
            return fightInfo;
         }
         return null;
      }
      
      public function get currentInfo() : FightLibInfo
      {
         return _currentInfo;
      }
      
      public function set currentInfo(value:FightLibInfo) : void
      {
         _currentInfo = value;
         dispatchEvent(new Event("change"));
      }
      
      public function set currentInfoID(value:int) : void
      {
         var fightInfo:* = null;
         if(currentInfo && currentInfo.id == value)
         {
            return;
         }
         var info:DungeonInfo = findDungInfoByID(value);
         if(info)
         {
            fightInfo = new FightLibInfo();
            fightInfo.beginChange();
            fightInfo.id = info.ID;
            fightInfo.description = info.Description;
            fightInfo.name = info.Name;
            fightInfo.difficulty = -1;
            fightInfo.requiedLevel = info.LevelLimits;
            fightInfo.mapID = int(info.Pic);
            fightInfo.commitChange();
            currentInfo = fightInfo;
         }
      }
      
      public function get reAnswerNum() : int
      {
         return _reAnswerNum;
      }
      
      public function set reAnswerNum(value:int) : void
      {
         _reAnswerNum = value;
      }
      
      public function getFightLibAwardInfoByID(id:int) : FightLibAwardInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _awardList;
         for each(var awardItem in _awardList)
         {
            if(awardItem.id == id)
            {
               return awardItem;
            }
         }
         return null;
      }
      
      public function setup() : void
      {
         createInitAwardLoader(initAwardInfo);
      }
      
      private function createInitAwardLoader(callBack:Function) : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FightLabDropItemList.xml"),5,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("tank.fightLib.LoaderAwardInfoError");
         loader.analyzer = new FightLibAwardAnalyzer(callBack);
         LoadResourceManager.Instance.startLoad(loader);
         return loader;
      }
      
      private function __onLoadError(evt:LoaderEvent) : void
      {
      }
      
      private function initAwardInfo(analyzer:FightLibAwardAnalyzer) : void
      {
         _awardList = analyzer.list;
      }
      
      public function gainAward(info:FightLibInfo) : void
      {
         dispatchEvent(new Event("gainAward"));
      }
   }
}

class SingletonFocer
{
    
   
   function SingletonFocer()
   {
      super();
   }
}
