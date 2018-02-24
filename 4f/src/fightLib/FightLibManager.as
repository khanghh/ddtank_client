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
      
      public function FightLibManager(param1:SingletonFocer){super();}
      
      public static function get Instance() : FightLibManager{return null;}
      
      public function set isWork(param1:Boolean) : void{}
      
      public function get isWork() : Boolean{return false;}
      
      public function get lastWin() : Boolean{return false;}
      
      public function set lastWin(param1:Boolean) : void{}
      
      private function addEvent() : void{}
      
      private function __infoChange(param1:CrazyTankSocketEvent) : void{}
      
      private function findDungInfoByID(param1:int) : DungeonInfo{return null;}
      
      public function getFightLibInfoByID(param1:int) : FightLibInfo{return null;}
      
      public function get currentInfo() : FightLibInfo{return null;}
      
      public function set currentInfo(param1:FightLibInfo) : void{}
      
      public function set currentInfoID(param1:int) : void{}
      
      public function get reAnswerNum() : int{return 0;}
      
      public function set reAnswerNum(param1:int) : void{}
      
      public function getFightLibAwardInfoByID(param1:int) : FightLibAwardInfo{return null;}
      
      public function setup() : void{}
      
      private function createInitAwardLoader(param1:Function) : BaseLoader{return null;}
      
      private function __onLoadError(param1:LoaderEvent) : void{}
      
      private function initAwardInfo(param1:FightLibAwardAnalyzer) : void{}
      
      public function gainAward(param1:FightLibInfo) : void{}
   }
}

class SingletonFocer
{
    
   
   function SingletonFocer(){super();}
}
