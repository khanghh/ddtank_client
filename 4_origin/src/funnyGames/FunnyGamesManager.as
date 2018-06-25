package funnyGames
{
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.data.CubeGameRankData;
   import funnyGames.event.FunnyGamesEvent;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import uiModeManager.bombUI.model.bomb.BombRankInfo;
   
   public class FunnyGamesManager extends CoreManager
   {
      
      private static var _instance:FunnyGamesManager;
       
      
      private var _status:Boolean;
      
      public function FunnyGamesManager(single:SingleTon)
      {
         super();
         if(!single)
         {
            throw new Error("this is a single instance");
         }
      }
      
      public static function getInstance() : FunnyGamesManager
      {
         if(!_instance)
         {
            _instance = new FunnyGamesManager(new SingleTon());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(372,5),__onRankHandler);
      }
      
      public function enterFunnyGames() : void
      {
         _status = true;
      }
      
      public function exitFunnyGames() : void
      {
         _status = false;
      }
      
      public function get status() : Boolean
      {
         return _status;
      }
      
      public function requestRankInfo(gameType:uint, rankType:uint) : void
      {
         if(gameType > 3)
         {
            return;
         }
         if(rankType > 2)
         {
            return;
         }
         SocketManager.Instance.out.sendBombGameRank(gameType,rankType);
      }
      
      public function __onRankHandler(pkg:PkgEvent) : void
      {
         var info:* = null;
         var rank:int = 0;
         var gameType:int = pkg.pkg.readInt();
         var rankType:int = pkg.pkg.readInt();
         var len:int = pkg.pkg.readInt();
         if(gameType == 3)
         {
            if(rankType == 1)
            {
               CubeGameManager.getInstance().clearTotalRankData();
            }
            else
            {
               CubeGameManager.getInstance().clearTodayRankData();
            }
         }
         rank = 0;
         while(rank < len)
         {
            info = new BombRankInfo();
            info.rankType = rankType;
            info.regDis = pkg.pkg.readUTF();
            info.nameDis = pkg.pkg.readUTF();
            info.score = pkg.pkg.readInt();
            info.lvNum = pkg.pkg.readInt();
            info.rank = rank + 1;
            if(rankType == 1)
            {
               if(gameType == 3)
               {
                  CubeGameManager.getInstance().addTotalRankData(new CubeGameRankData(info.rank,info.nameDis,info.score));
               }
               HappyLittleGameManager.instance.bombManager.initTotalRankData(info,gameType);
            }
            else
            {
               if(gameType == 3)
               {
                  CubeGameManager.getInstance().addTodayRankData(new CubeGameRankData(info.rank,info.nameDis,info.score));
               }
               HappyLittleGameManager.instance.bombManager.initDayRankData(info,gameType);
            }
            rank++;
         }
         dispatchEvent(new FunnyGamesEvent("rankUpdate"));
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
