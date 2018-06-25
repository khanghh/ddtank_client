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
      
      public function CubeGameManager(single:SingleTon)
      {
         super();
         if(!single)
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
      
      public function addTotalRankData(data:CubeGameRankData) : void
      {
         _totalRankDataList.push(data);
      }
      
      public function addTodayRankData(data:CubeGameRankData) : void
      {
         _todayRankDataList.push(data);
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
      
      public function getRankDataList(startIndex:int = 0, endIndex:int = 16777215, isTotal:Boolean = false) : Vector.<CubeGameRankData>
      {
         var list:Vector.<CubeGameRankData> = !!isTotal?_totalRankDataList:_todayRankDataList;
         endIndex = endIndex > list.length?list.length:endIndex;
         return list.slice(startIndex,endIndex);
      }
      
      public function getSelfRank(isTotal:Boolean = false) : int
      {
         var i:* = 0;
         var list:Vector.<CubeGameRankData> = !!isTotal?_totalRankDataList:_todayRankDataList;
         for(i = uint(0); i < list.length; )
         {
            if(list[i].name == PlayerManager.Instance.Self.NickName)
            {
               return list[i].rank;
            }
            i++;
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
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(9);
         SocketManager.Instance.out.sendPackage(pkg);
      }
      
      private function __onResponseStartCubeGame(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var gridType:int = 0;
         var column:int = 0;
         var row:int = 0;
         var cube:* = null;
         _status = true;
         lock = false;
         this._gameInfo.curWaveNum = 1;
         this._gameInfo.level = pkg.pkg.readInt();
         this._gameInfo.totalWaveNum = pkg.pkg.readInt();
         this._gameInfo.dailyHighScore = pkg.pkg.readInt();
         this._gameInfo.historyHgihScore = pkg.pkg.readInt();
         var len:int = pkg.pkg.readInt();
         var cubes:Vector.<CubeData> = new Vector.<CubeData>();
         for(i = 0; i < len; )
         {
            id = pkg.pkg.readInt();
            gridType = pkg.pkg.readInt();
            column = pkg.pkg.readInt();
            row = pkg.pkg.readInt();
            cube = new CubeData(id,gridType);
            cubes.push(cube);
            i++;
         }
         this.dispatchEvent(new CubeGameEvent("gameStart",cubes));
      }
      
      public function resquestDeleteCube(id:int) : void
      {
         if(_lastCubeId == id)
         {
            return;
         }
         _lastCubeId = id;
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(10);
         pkg.writeInt(0);
         pkg.writeInt(0);
         pkg.writeInt(id);
         SocketManager.Instance.out.sendPackage(pkg);
      }
      
      private function __onResponseDeleteCube(pkg:PkgEvent) : void
      {
         var j:* = 0;
         var id:int = 0;
         var score:int = 0;
         this._gameInfo.curScore = pkg.pkg.readInt();
         var size:int = pkg.pkg.readInt();
         var deathDataList:Vector.<Object> = new Vector.<Object>();
         for(j = uint(0); j < size; )
         {
            id = pkg.pkg.readInt();
            score = pkg.pkg.readInt();
            deathDataList.push({
               "id":id,
               "score":score
            });
            j++;
         }
         dispatchEvent(new CubeGameEvent("cubeDeath",deathDataList));
      }
      
      private function __onResponseGenerateCube(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var id:int = 0;
         var gridType:int = 0;
         var column:int = 0;
         var row:int = 0;
         var cube:* = null;
         if(lock)
         {
            return;
         }
         this._gameInfo.curWaveNum = pkg.pkg.readInt() + 1;
         var len:int = pkg.pkg.readInt();
         var cubes:Vector.<CubeData> = new Vector.<CubeData>();
         for(i = 0; i < len; )
         {
            id = pkg.pkg.readInt();
            gridType = pkg.pkg.readInt();
            column = pkg.pkg.readInt();
            row = pkg.pkg.readInt();
            cube = new CubeData(id,gridType);
            cubes.push(cube);
            i++;
         }
         this.dispatchEvent(new CubeGameEvent("cubeGenerate",cubes));
      }
      
      private function __onResponseRandomCube(pkg:PkgEvent) : void
      {
         var gridType:int = pkg.pkg.readInt();
         var column:int = pkg.pkg.readInt();
         var row:int = pkg.pkg.readInt();
         var id:int = pkg.pkg.readInt();
         var cube:CubeData = new CubeData(id,gridType);
         this.dispatchEvent(new CubeGameEvent("cubeRandom",{
            "cubeData":cube,
            "column":column,
            "row":row
         }));
      }
      
      private function __onResponseGameResult(pkg:PkgEvent) : void
      {
         if(checkNeedRequestRankInfo())
         {
            FunnyGamesManager.getInstance().requestRankInfo(3,2);
            FunnyGamesManager.getInstance().requestRankInfo(3,1);
         }
         _status = false;
         var result:Boolean = pkg.pkg.readBoolean();
         this._gameInfo.curScore = pkg.pkg.readInt();
         this.dispatchEvent(new CubeGameEvent("gameResult",result));
      }
      
      public function requestExitCubeGame() : void
      {
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(14);
         pkg.writeInt(0);
         SocketManager.Instance.out.sendPackage(pkg);
      }
      
      public function requestRestartGame() : void
      {
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(14);
         pkg.writeInt(1);
         SocketManager.Instance.out.sendPackage(pkg);
      }
      
      private function __onResponseGameExit(pkg:PkgEvent) : void
      {
         gameInfo.curWaveNum = 0;
         gameInfo.totalWaveNum = 0;
         gameInfo.curScore = 0;
         gameInfo.level = 0;
         _lastCubeId = 0;
         var type:int = pkg.pkg.readInt();
         switch(int(type))
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
