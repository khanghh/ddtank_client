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
      
      public function HappyLittleGameManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function set currentGameType(value:int) : void
      {
         _currentGameType = value;
      }
      
      private function onComplete() : void
      {
         var view:* = ComponentFactory.Instance.creatComponentByStylename("happyLittleGame.Frame");
         view.show();
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
         var curTime:Date = TimeManager.Instance.Now();
         if(this._lastRequstRankDataTime && curTime.day == this._lastRequstRankDataTime.day)
         {
            if(curTime.hours > 0 || curTime.minutes > 10)
            {
               return false;
            }
         }
         return true;
      }
      
      public function showRankFrame() : void
      {
         var loader:* = null;
         var view:* = ComponentFactory.Instance.creatComponentByStylename("simpleGameRank.Frame");
         if(view)
         {
            view.show();
         }
         if(!this._rankRewardCfg.aviliable)
         {
            loader = LoaderCreate.Instance.CreateMiniGameRankRewardCfgLoader();
            LoadResourceManager.Instance.startLoad(loader);
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
      
      public function onAnalyzeRankRewardCfg(analyzer:HappyLittleGameRankAnalyzer) : void
      {
         this._rankRewardCfg.cfg = analyzer.data;
         requestRankInfo();
      }
      
      private function onGameRankInfo(pkg:PkgEvent) : void
      {
         var idx:* = 0;
         var serverName:* = null;
         var playerName:* = null;
         var score:int = 0;
         var paral:int = 0;
         var rankData:* = null;
         var i:int = 0;
         SocketManager.Instance.removeEventListener(PkgEvent.format(372,8),onGameRankInfo);
         while(_rankDataList.length > 0)
         {
            _rankDataList.pop();
         }
         var len:int = pkg.pkg.readInt();
         for(idx = uint(0); idx < len; )
         {
            serverName = pkg.pkg.readUTF();
            playerName = pkg.pkg.readUTF();
            score = pkg.pkg.readInt();
            paral = pkg.pkg.readInt();
            rankData = new HappyMiniGameRankData(serverName,playerName,score);
            this._rankDataList.push(rankData);
            idx++;
         }
         this._rankDataList = this._rankDataList.sort(sortRankDataList);
         for(i = 0; i < this._rankDataList.length; )
         {
            this._rankDataList[i].rank = i;
            i++;
         }
         this._lastRequstRankDataTime = TimeManager.Instance.Now();
         FunnyGamesManager.getInstance().dispatchEvent(new FunnyGamesEvent("rankRewardUpdate"));
      }
      
      private function sortRankDataList(left:HappyMiniGameRankData, right:HappyMiniGameRankData) : int
      {
         if(left.score > right.score)
         {
            return -1;
         }
         if(left.score < right.score)
         {
            return 1;
         }
         return 0;
      }
      
      public function getRankDataList(startIndex:int = 0, endIndex:int = 16777215) : Vector.<HappyMiniGameRankData>
      {
         endIndex = endIndex > this._rankDataList.length?this._rankDataList.length:endIndex;
         return this._rankDataList.slice(startIndex,endIndex);
      }
      
      public function getSelfRank() : int
      {
         var i:* = 0;
         for(i = uint(0); i < this._rankDataList.length; )
         {
            if(this._rankDataList[i].playerName == PlayerManager.Instance.Self.NickName)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function __activeDataHandler(pkg:PkgEvent) : void
      {
         var info:* = null;
         var i:int = 0;
         clearActiveInfo();
         var len:int = pkg.pkg.readInt();
         for(i = 0; i < len; )
         {
            info = new HappyMiniGameActiveInfo();
            info.serverName = pkg.pkg.readUTF();
            info.nickName = pkg.pkg.readUTF();
            info.score = pkg.pkg.readInt();
            info.gameType = pkg.pkg.readInt();
            info.endtime = pkg.pkg.readDate();
            info.rank = pkg.pkg.readInt();
            info.rankType = pkg.pkg.readInt();
            gameActiveInfos.push(info);
            i++;
         }
         gameActiveInfos.reverse();
         dispatchEvent(new HappyLittleGameEvent("refreshdaynew"));
      }
      
      private function clearActiveInfo() : void
      {
         var info:* = null;
         while(gameActiveInfos.length > 0)
         {
            info = gameActiveInfos.pop();
            info = null;
         }
      }
      
      public function startTimerByType(type:int) : void
      {
         if(type == 2)
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
         if(type == 1)
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
      
      private function __timerfixedComplete(evt:Event) : void
      {
         timer_fixed.stop();
         fixed_refresh = true;
      }
      
      private function __timerrandomComplete(evt:Event) : void
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
