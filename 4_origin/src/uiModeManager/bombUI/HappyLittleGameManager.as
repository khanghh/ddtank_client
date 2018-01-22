package uiModeManager.bombUI
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import funnyGames.FunnyGamesManager;
   import funnyGames.event.FunnyGamesEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import uiModeManager.bombUI.event.HappyLittleGameEvent;
   import uiModeManager.bombUI.model.HappyMiniGameActiveInfo;
   import uiModeManager.bombUI.model.rank.HappyLittleGameRankAnalyzer;
   import uiModeManager.bombUI.model.rank.HappyMiniGameRankData;
   import uiModeManager.bombUI.model.rank.RankRewardCfg;
   
   public class HappyLittleGameManager extends CoreManager
   {
      
      private static var _instance:HappyLittleGameManager;
       
      
      public var currentGameState:int;
      
      private var _currentGameType:int;
      
      public var bombManager:BombGameManager;
      
      public var gameActiveInfos:Vector.<HappyMiniGameActiveInfo>;
      
      private var timer_fixed:TimerJuggler;
      
      private var timer_random:TimerJuggler;
      
      public var fixed_refresh:Boolean = true;
      
      public var random_refresh:Boolean = true;
      
      private var timerNum:int = 300000;
      
      private var _rankDataList:Vector.<HappyMiniGameRankData>;
      
      private var _rankRewardCfg:RankRewardCfg;
      
      private var _lastRequstRankDataTime:Date;
      
      public function HappyLittleGameManager(param1:IEventDispatcher = null)
      {
         super(param1);
         bombManager = new BombGameManager();
         gameActiveInfos = new Vector.<HappyMiniGameActiveInfo>();
         this._rankRewardCfg = new RankRewardCfg();
         this._rankDataList = new Vector.<HappyMiniGameRankData>();
      }
      
      public static function get instance() : HappyLittleGameManager
      {
         if(!_instance)
         {
            _instance = new HappyLittleGameManager();
         }
         return _instance;
      }
      
      public function get currentGameType() : int
      {
         return _currentGameType;
      }
      
      public function get rankRewardCfg() : RankRewardCfg
      {
         return this._rankRewardCfg;
      }
      
      public function set currentGameType(param1:int) : void
      {
         _currentGameType = param1;
      }
      
      private function onComplete() : void
      {
         var _loc1_:* = ComponentFactory.Instance.creatComponentByStylename("happyLittleGame.Frame");
         _loc1_.show();
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["bombgame"],onComplete);
         SocketManager.Instance.out.sendHappyMiniGameActiveData();
      }
      
      public function setUp() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(372,7),__activeDataHandler);
      }
      
      private function checkRankDataRequst() : Boolean
      {
         var _loc1_:Date = TimeManager.Instance.Now();
         if(this._lastRequstRankDataTime && _loc1_.day == this._lastRequstRankDataTime.day)
         {
            if(_loc1_.hours > 0 || _loc1_.minutes > 10)
            {
               return false;
            }
         }
         return true;
      }
      
      public function showRankFrame() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = ComponentFactory.Instance.creatComponentByStylename("simpleGameRank.Frame");
         if(_loc2_)
         {
            _loc2_.show();
         }
         if(!this._rankRewardCfg.aviliable)
         {
            _loc1_ = LoaderCreate.Instance.CreateMiniGameRankRewardCfgLoader();
            LoadResourceManager.Instance.startLoad(_loc1_);
            return;
         }
         requestRankInfo();
      }
      
      private function requestRankInfo() : void
      {
         if(this.checkRankDataRequst())
         {
            SocketManager.Instance.out.sendHappyMiniGameRankDataList();
            SocketManager.Instance.addEventListener(PkgEvent.format(372,8),onGameRankInfo);
         }
      }
      
      public function onAnalyzeRankRewardCfg(param1:HappyLittleGameRankAnalyzer) : void
      {
         this._rankRewardCfg.cfg = param1.data;
         requestRankInfo();
      }
      
      private function onGameRankInfo(param1:PkgEvent) : void
      {
         var _loc3_:* = 0;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc9_:int = 0;
         SocketManager.Instance.removeEventListener(PkgEvent.format(372,8),onGameRankInfo);
         while(_rankDataList.length > 0)
         {
            _rankDataList.pop();
         }
         var _loc7_:int = param1.pkg.readInt();
         _loc3_ = uint(0);
         while(_loc3_ < _loc7_)
         {
            _loc8_ = param1.pkg.readUTF();
            _loc5_ = param1.pkg.readUTF();
            _loc6_ = param1.pkg.readInt();
            _loc4_ = param1.pkg.readInt();
            _loc2_ = new HappyMiniGameRankData(_loc8_,_loc5_,_loc6_);
            this._rankDataList.push(_loc2_);
            _loc3_++;
         }
         this._rankDataList = this._rankDataList.sort(sortRankDataList);
         _loc9_ = 0;
         while(_loc9_ < this._rankDataList.length)
         {
            this._rankDataList[_loc9_].rank = _loc9_;
            _loc9_++;
         }
         this._lastRequstRankDataTime = TimeManager.Instance.Now();
         FunnyGamesManager.getInstance().dispatchEvent(new FunnyGamesEvent("rankRewardUpdate"));
      }
      
      private function sortRankDataList(param1:HappyMiniGameRankData, param2:HappyMiniGameRankData) : int
      {
         if(param1.score > param2.score)
         {
            return -1;
         }
         if(param1.score < param2.score)
         {
            return 1;
         }
         return 0;
      }
      
      public function getRankDataList(param1:int = 0, param2:int = 16777215) : Vector.<HappyMiniGameRankData>
      {
         param2 = param2 > this._rankDataList.length?this._rankDataList.length:param2;
         return this._rankDataList.slice(param1,param2);
      }
      
      public function getSelfRank() : int
      {
         var _loc1_:* = 0;
         _loc1_ = uint(0);
         while(_loc1_ < this._rankDataList.length)
         {
            if(this._rankDataList[_loc1_].playerName == PlayerManager.Instance.Self.NickName)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function __activeDataHandler(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         clearActiveInfo();
         var _loc2_:int = param1.pkg.readInt();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new HappyMiniGameActiveInfo();
            _loc4_.serverName = param1.pkg.readUTF();
            _loc4_.nickName = param1.pkg.readUTF();
            _loc4_.score = param1.pkg.readInt();
            _loc4_.gameType = param1.pkg.readInt();
            _loc4_.endtime = param1.pkg.readDate();
            _loc4_.rank = param1.pkg.readInt();
            _loc4_.rankType = param1.pkg.readInt();
            gameActiveInfos.push(_loc4_);
            _loc3_++;
         }
         gameActiveInfos.reverse();
         dispatchEvent(new HappyLittleGameEvent("refreshdaynew"));
      }
      
      private function clearActiveInfo() : void
      {
         var _loc1_:* = null;
         while(gameActiveInfos.length > 0)
         {
            _loc1_ = gameActiveInfos.pop();
            _loc1_ = null;
         }
      }
      
      public function startTimerByType(param1:int) : void
      {
         if(param1 == 2)
         {
            if(timer_fixed == null)
            {
               timer_fixed = TimerManager.getInstance().addTimer1000ms(timerNum,1);
               timer_fixed.addEventListener("timerComplete",__timerfixedComplete);
            }
            if(fixed_refresh)
            {
               fixed_refresh = false;
               timer_fixed.start();
            }
         }
         if(param1 == 1)
         {
            if(timer_random == null)
            {
               timer_random = TimerManager.getInstance().addTimer1000ms(timerNum,1);
               timer_random.addEventListener("timerComplete",__timerrandomComplete);
            }
            if(random_refresh)
            {
               random_refresh = false;
               timer_random.start();
            }
         }
      }
      
      private function cleartimer() : void
      {
         if(timer_fixed)
         {
            timer_fixed.stop();
            timer_fixed.removeEventListener("timerComplete",__timerfixedComplete);
            TimerManager.getInstance().removeTimer1000ms(timer_fixed);
            timer_fixed = null;
         }
         if(timer_random)
         {
            timer_random.stop();
            timer_random.removeEventListener("timerComplete",__timerrandomComplete);
            TimerManager.getInstance().removeTimer1000ms(timer_random);
            timer_random = null;
         }
      }
      
      private function __timerfixedComplete(param1:Event) : void
      {
         timer_fixed.stop();
         fixed_refresh = true;
      }
      
      private function __timerrandomComplete(param1:Event) : void
      {
         timer_random.stop();
         random_refresh = true;
      }
      
      public function clearData() : void
      {
         bombManager.clearBombData();
         clearActiveInfo();
         cleartimer();
         currentGameState = 0;
         fixed_refresh = true;
         random_refresh = true;
      }
   }
}
