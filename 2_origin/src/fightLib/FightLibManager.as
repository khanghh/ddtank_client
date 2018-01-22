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
      
      public function FightLibManager(param1:SingletonFocer)
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
      
      public function set isWork(param1:Boolean) : void
      {
         _isWork = param1;
      }
      
      public function get isWork() : Boolean
      {
         return _isWork;
      }
      
      public function get lastWin() : Boolean
      {
         return _lastWin;
      }
      
      public function set lastWin(param1:Boolean) : void
      {
         _lastWin = param1;
      }
      
      private function addEvent() : void
      {
         SocketManager.Instance.addEventListener("fightLibInfoChange",__infoChange);
      }
      
      private function __infoChange(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         var _loc4_:int = _loc3_.readInt();
         currentInfoID = _loc2_;
         currentInfo.beginChange();
         currentInfo.difficulty = _loc4_;
         var _loc5_:DungeonInfo = findDungInfoByID(_loc2_);
         currentInfo.commitChange();
      }
      
      private function findDungInfoByID(param1:int) : DungeonInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = MapManager.getFightLibList();
         for each(var _loc2_ in MapManager.getFightLibList())
         {
            if(_loc2_.ID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getFightLibInfoByID(param1:int) : FightLibInfo
      {
         var _loc2_:* = null;
         var _loc3_:DungeonInfo = findDungInfoByID(param1);
         if(_loc3_)
         {
            _loc2_ = new FightLibInfo();
            _loc2_.beginChange();
            _loc2_.id = _loc3_.ID;
            _loc2_.description = _loc3_.Description;
            _loc2_.name = _loc3_.Name;
            _loc2_.difficulty = -1;
            _loc2_.requiedLevel = _loc3_.LevelLimits;
            _loc2_.mapID = int(_loc3_.Pic);
            _loc2_.commitChange();
            return _loc2_;
         }
         return null;
      }
      
      public function get currentInfo() : FightLibInfo
      {
         return _currentInfo;
      }
      
      public function set currentInfo(param1:FightLibInfo) : void
      {
         _currentInfo = param1;
         dispatchEvent(new Event("change"));
      }
      
      public function set currentInfoID(param1:int) : void
      {
         var _loc2_:* = null;
         if(currentInfo && currentInfo.id == param1)
         {
            return;
         }
         var _loc3_:DungeonInfo = findDungInfoByID(param1);
         if(_loc3_)
         {
            _loc2_ = new FightLibInfo();
            _loc2_.beginChange();
            _loc2_.id = _loc3_.ID;
            _loc2_.description = _loc3_.Description;
            _loc2_.name = _loc3_.Name;
            _loc2_.difficulty = -1;
            _loc2_.requiedLevel = _loc3_.LevelLimits;
            _loc2_.mapID = int(_loc3_.Pic);
            _loc2_.commitChange();
            currentInfo = _loc2_;
         }
      }
      
      public function get reAnswerNum() : int
      {
         return _reAnswerNum;
      }
      
      public function set reAnswerNum(param1:int) : void
      {
         _reAnswerNum = param1;
      }
      
      public function getFightLibAwardInfoByID(param1:int) : FightLibAwardInfo
      {
         var _loc4_:int = 0;
         var _loc3_:* = _awardList;
         for each(var _loc2_ in _awardList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function setup() : void
      {
         createInitAwardLoader(initAwardInfo);
      }
      
      private function createInitAwardLoader(param1:Function) : BaseLoader
      {
         var _loc3_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("FightLabDropItemList.xml"),5,_loc3_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("tank.fightLib.LoaderAwardInfoError");
         _loc2_.analyzer = new FightLibAwardAnalyzer(param1);
         LoadResourceManager.Instance.startLoad(_loc2_);
         return _loc2_;
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
      }
      
      private function initAwardInfo(param1:FightLibAwardAnalyzer) : void
      {
         _awardList = param1.list;
      }
      
      public function gainAward(param1:FightLibInfo) : void
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
