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
      
      public function FunnyGamesManager(param1:SingleTon)
      {
         super();
         if(!param1)
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
      
      public function requestRankInfo(param1:uint, param2:uint) : void
      {
         if(param1 > 3)
         {
            return;
         }
         if(param2 > 2)
         {
            return;
         }
         SocketManager.Instance.out.sendBombGameRank(param1,param2);
      }
      
      public function __onRankHandler(param1:PkgEvent) : void
      {
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = param1.pkg.readInt();
         var _loc4_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         if(_loc3_ == 3)
         {
            if(_loc4_ == 1)
            {
               CubeGameManager.getInstance().clearTotalRankData();
            }
            else
            {
               CubeGameManager.getInstance().clearTodayRankData();
            }
         }
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc6_ = new BombRankInfo();
            _loc6_.rankType = _loc4_;
            _loc6_.regDis = param1.pkg.readUTF();
            _loc6_.nameDis = param1.pkg.readUTF();
            _loc6_.score = param1.pkg.readInt();
            _loc6_.lvNum = param1.pkg.readInt();
            _loc6_.rank = _loc2_ + 1;
            if(_loc4_ == 1)
            {
               if(_loc3_ == 3)
               {
                  CubeGameManager.getInstance().addTotalRankData(new CubeGameRankData(_loc6_.rank,_loc6_.nameDis,_loc6_.score));
               }
               HappyLittleGameManager.instance.bombManager.initTotalRankData(_loc6_,_loc3_);
            }
            else
            {
               if(_loc3_ == 3)
               {
                  CubeGameManager.getInstance().addTodayRankData(new CubeGameRankData(_loc6_.rank,_loc6_.nameDis,_loc6_.score));
               }
               HappyLittleGameManager.instance.bombManager.initDayRankData(_loc6_,_loc3_);
            }
            _loc2_++;
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
