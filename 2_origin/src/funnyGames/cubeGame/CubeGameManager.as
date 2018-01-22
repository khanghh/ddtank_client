package funnyGames.cubeGame
{
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import funnyGames.FunnyGamesManager;
   import funnyGames.cubeGame.data.CubeData;
   import funnyGames.cubeGame.data.CubeGameInfo;
   import funnyGames.cubeGame.data.CubeGameRankData;
   import funnyGames.cubeGame.event.CubeGameEvent;
   import road7th.comm.PackageOut;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class CubeGameManager extends CoreManager
   {
      
      private static var _instance:CubeGameManager;
      
      public static var DEBUG:Boolean = false;
      
      private static const EXIT_OPERATION_TYPE:uint = 0;
      
      private static const RESTART_OPERATION_TYPE:uint = 1;
       
      
      private var _gameInfo:CubeGameInfo;
      
      private var _todayRankDataList:Vector.<CubeGameRankData>;
      
      private var _totalRankDataList:Vector.<CubeGameRankData>;
      
      private var _status:Boolean = false;
      
      private var _lastCubeId:uint = 0;
      
      public var lock:Boolean = false;
      
      public function CubeGameManager(param1:SingleTon)
      {
         super();
         if(!param1)
         {
            throw new Error("this is a single instance");
         }
      }
      
      public static function getInstance() : CubeGameManager
      {
         if(!_instance)
         {
            _instance = new CubeGameManager(new SingleTon());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         this.initData();
         this.initListeners();
      }
      
      private function initData() : void
      {
         this._gameInfo = new CubeGameInfo();
         _todayRankDataList = new Vector.<CubeGameRankData>();
         _totalRankDataList = new Vector.<CubeGameRankData>();
      }
      
      private function initListeners() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(372,9),__onResponseStartCubeGame);
         SocketManager.Instance.addEventListener(PkgEvent.format(372,10),__onResponseDeleteCube);
         SocketManager.Instance.addEventListener(PkgEvent.format(372,11),__onResponseGenerateCube);
         SocketManager.Instance.addEventListener(PkgEvent.format(372,12),__onResponseRandomCube);
         SocketManager.Instance.addEventListener(PkgEvent.format(372,13),__onResponseGameResult);
         SocketManager.Instance.addEventListener(PkgEvent.format(372,14),__onResponseGameExit);
      }
      
      public function get gameInfo() : CubeGameInfo
      {
         return this._gameInfo;
      }
      
      public function startGame() : void
      {
         _gameInfo.row = ServerConfigManager.instance.cubeGameRow;
         _gameInfo.column = ServerConfigManager.instance.cubeGameColumn;
         _gameInfo.strongDestroyScore = ServerConfigManager.instance.strongDestroyScore;
         _gameInfo.extraDestroyScore = ServerConfigManager.instance.extraDestroyScore;
         _gameInfo.emptyColumnScore = ServerConfigManager.instance.emptyColumnScore;
         _gameInfo.costEnergy = ServerConfigManager.instance.cubeGameCostEnergy;
         if(!this._gameInfo.aviliable)
         {
            new HelperUIModuleLoad().loadUIModule(["cubeGame"],enterGame);
            return;
         }
         enterGame();
      }
      
      public function checkEnergyEnough() : Boolean
      {
         if(PlayerManager.Instance.Self.energy < _gameInfo.costEnergy)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.funnyGame.cubeGame.energyLackTxt"));
            return false;
         }
         return true;
      }
      
      public function endGame() : void
      {
         FunnyGamesManager.getInstance().exitFunnyGames();
         CubeGameManager.getInstance().requestExitCubeGame();
         HappyLittleGameManager.instance.bombManager.clearRankDataByType(3);
         FunnyGamesManager.getInstance().requestRankInfo(3,2);
         FunnyGamesManager.getInstance().requestRankInfo(3,1);
      }
      
      private function enterGame() : void
      {
         this._gameInfo.aviliable = true;
         FunnyGamesManager.getInstance().enterFunnyGames();
         StateManager.setState("minGameCubes");
      }
      
      public function get status() : Boolean
      {
         return _status;
      }
      
      public function addTotalRankData(param1:CubeGameRankData) : void
      {
         _totalRankDataList.push(param1);
      }
      
      public function addTodayRankData(param1:CubeGameRankData) : void
      {
         _todayRankDataList.push(param1);
      }
      
      public function clearTotalRankData() : void
      {
         while(_totalRankDataList.length > 0)
         {
            _totalRankDataList.pop();
         }
      }
      
      public function clearTodayRankData() : void
      {
         while(_todayRankDataList.length > 0)
         {
            _todayRankDataList.pop();
         }
      }
      
      public function getRankDataList(param1:int = 0, param2:int = 16777215, param3:Boolean = false) : Vector.<CubeGameRankData>
      {
         var _loc4_:Vector.<CubeGameRankData> = !!param3?_totalRankDataList:_todayRankDataList;
         param2 = param2 > _loc4_.length?_loc4_.length:param2;
         return _loc4_.slice(param1,param2);
      }
      
      public function getSelfRank(param1:Boolean = false) : int
      {
         var _loc3_:* = 0;
         var _loc2_:Vector.<CubeGameRankData> = !!param1?_totalRankDataList:_todayRankDataList;
         _loc3_ = uint(0);
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].name == PlayerManager.Instance.Self.NickName)
            {
               return _loc2_[_loc3_].rank;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function checkNeedRequestRankInfo() : Boolean
      {
         if(_gameInfo.historyHgihScore < _gameInfo.curScore)
         {
            return true;
         }
         return false;
      }
      
      public function requestStartCubeGame() : void
      {
         var _loc1_:PackageOut = new PackageOut(372);
         _loc1_.writeByte(9);
         SocketManager.Instance.out.sendPackage(_loc1_);
      }
      
      private function __onResponseStartCubeGame(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         _status = true;
         lock = false;
         this._gameInfo.curWaveNum = 1;
         this._gameInfo.level = param1.pkg.readInt();
         this._gameInfo.totalWaveNum = param1.pkg.readInt();
         this._gameInfo.dailyHighScore = param1.pkg.readInt();
         this._gameInfo.historyHgihScore = param1.pkg.readInt();
         var _loc6_:int = param1.pkg.readInt();
         var _loc4_:Vector.<CubeData> = new Vector.<CubeData>();
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc2_ = param1.pkg.readInt();
            _loc8_ = param1.pkg.readInt();
            _loc3_ = param1.pkg.readInt();
            _loc7_ = param1.pkg.readInt();
            _loc5_ = new CubeData(_loc2_,_loc8_);
            _loc4_.push(_loc5_);
            _loc9_++;
         }
         this.dispatchEvent(new CubeGameEvent("gameStart",_loc4_));
      }
      
      public function resquestDeleteCube(param1:int) : void
      {
         if(_lastCubeId == param1)
         {
            return;
         }
         _lastCubeId = param1;
         var _loc2_:PackageOut = new PackageOut(372);
         _loc2_.writeByte(10);
         _loc2_.writeInt(0);
         _loc2_.writeInt(0);
         _loc2_.writeInt(param1);
         SocketManager.Instance.out.sendPackage(_loc2_);
      }
      
      private function __onResponseDeleteCube(param1:PkgEvent) : void
      {
         var _loc5_:* = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         this._gameInfo.curScore = param1.pkg.readInt();
         var _loc6_:int = param1.pkg.readInt();
         var _loc3_:Vector.<Object> = new Vector.<Object>();
         _loc5_ = uint(0);
         while(_loc5_ < _loc6_)
         {
            _loc2_ = param1.pkg.readInt();
            _loc4_ = param1.pkg.readInt();
            _loc3_.push({
               "id":_loc2_,
               "score":_loc4_
            });
            _loc5_++;
         }
         dispatchEvent(new CubeGameEvent("cubeDeath",_loc3_));
      }
      
      private function __onResponseGenerateCube(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         if(lock)
         {
            return;
         }
         this._gameInfo.curWaveNum = param1.pkg.readInt() + 1;
         var _loc6_:int = param1.pkg.readInt();
         var _loc4_:Vector.<CubeData> = new Vector.<CubeData>();
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc2_ = param1.pkg.readInt();
            _loc8_ = param1.pkg.readInt();
            _loc3_ = param1.pkg.readInt();
            _loc7_ = param1.pkg.readInt();
            _loc5_ = new CubeData(_loc2_,_loc8_);
            _loc4_.push(_loc5_);
            _loc9_++;
         }
         this.dispatchEvent(new CubeGameEvent("cubeGenerate",_loc4_));
      }
      
      private function __onResponseRandomCube(param1:PkgEvent) : void
      {
         var _loc6_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readInt();
         var _loc4_:CubeData = new CubeData(_loc2_,_loc6_);
         this.dispatchEvent(new CubeGameEvent("cubeRandom",{
            "cubeData":_loc4_,
            "column":_loc3_,
            "row":_loc5_
         }));
      }
      
      private function __onResponseGameResult(param1:PkgEvent) : void
      {
         if(checkNeedRequestRankInfo())
         {
            FunnyGamesManager.getInstance().requestRankInfo(3,2);
            FunnyGamesManager.getInstance().requestRankInfo(3,1);
         }
         _status = false;
         var _loc2_:Boolean = param1.pkg.readBoolean();
         this._gameInfo.curScore = param1.pkg.readInt();
         this.dispatchEvent(new CubeGameEvent("gameResult",_loc2_));
      }
      
      public function requestExitCubeGame() : void
      {
         var _loc1_:PackageOut = new PackageOut(372);
         _loc1_.writeByte(14);
         _loc1_.writeInt(0);
         SocketManager.Instance.out.sendPackage(_loc1_);
      }
      
      public function requestRestartGame() : void
      {
         var _loc1_:PackageOut = new PackageOut(372);
         _loc1_.writeByte(14);
         _loc1_.writeInt(1);
         SocketManager.Instance.out.sendPackage(_loc1_);
      }
      
      private function __onResponseGameExit(param1:PkgEvent) : void
      {
         gameInfo.curWaveNum = 0;
         gameInfo.totalWaveNum = 0;
         gameInfo.curScore = 0;
         gameInfo.level = 0;
         _lastCubeId = 0;
         var _loc2_:int = param1.pkg.readInt();
         switch(int(_loc2_))
         {
            default:
            case 1:
               if(!CubeGameManager.getInstance().checkEnergyEnough())
               {
                  return;
               }
               lock = true;
               dispatchEvent(new CubeGameEvent("clearMap"));
               dispatchEvent(new CubeGameEvent("cooldown"));
               break;
         }
      }
   }
}

class SingleTon
{
    
   
   function SingleTon()
   {
      super();
   }
}
